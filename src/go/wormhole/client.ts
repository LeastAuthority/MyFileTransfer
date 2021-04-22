import {ClientConfig, wormhole} from "@/go/wormhole/types";
import {Reader} from '@/go/wormhole/streaming';
import Send from "@/views/Send.vue";

const DEFAULT_PROD_CLIENT_CONFIG: ClientConfig = {
    // rendezvousURL: "wss://relay.magic-wormhole.io:4000/v1",
    // transitRelayAddress: "transit.magic-wormhole.io:4001",
    rendezvousURL: "wss://mailbox.wormhole.bryanchriswhite.com/v1",
    transitRelayAddress: "wss://relay.wormhole.bryanchriswhite.com:443",
    passPhraseComponentLength: 2,
}

// TODO: move to own client wrapper lib

export type ProgressFunc = (sentBytes: number, totalBytes: number) => void

export interface Offer {
    name: string;
    size: number;
    accept?: () => Promise<Error>;
    reject?: () => Promise<Error>;
}

export type OfferCondition = (offer: Offer) => void

export interface TransferOptions {
    progressFunc?: ProgressFunc;
    offerCondition?: OfferCondition;
    code?: string;

    // TODO: keep?
    bufferSizeBytes?: number;

    // TODO: refactor
    name?: string;
    size?: number;
}

export interface SendResult {
    code: string;
    result: Promise<void>;
}

export interface ClientInterface {
    // TODO: readonly or at least protected.
    goClient: number;

    sendText(msg: string): Promise<string>;

    recvText(code: string): Promise<string>;

    sendFile(file: File, opts?: TransferOptions): Promise<SendResult>;

    recvFile(code: string, opts?: TransferOptions): Promise<Reader>;

    free(): void;
}


export default class Client implements ClientInterface {
    public goClient: number;

    constructor(config?: ClientConfig) {
        // console.log(`NODE_ENV: ${process.env.NODE_ENV}`);
        if (!config && process.env.NODE_ENV === 'production') {
            config = DEFAULT_PROD_CLIENT_CONFIG;
        }

        this.goClient = wormhole.Client.newClient(config)
    }

    public async sendText(message: string): Promise<string> {
        return wormhole.Client.sendText(this.goClient, message);
    }

    public async sendFile(file: File, opts?: TransferOptions): Promise<SendResult> {
        const data = new Uint8Array(await file.arrayBuffer());
        return wormhole.Client.sendFile(this.goClient, file.name, data, opts);
    }

    public async recvText(code: string): Promise<string> {
        return wormhole.Client.recvText(this.goClient, code)
    }

    public async recvFile(code: string, opts?: TransferOptions): Promise<Reader> {
        // console.log(`opts.offerCondition: ${opts!.offerCondition}`);
        try {
            const reader = await wormhole.Client.recvFile(this.goClient, code, opts);
            let bufferSizeBytes = reader.bufferSizeBytes;
            if (typeof (opts) !== 'undefined' && opts.bufferSizeBytes) {
                bufferSizeBytes = opts.bufferSizeBytes;
            }
            return new Reader(bufferSizeBytes, reader.read);
        } catch (error) {
            return Promise.reject(error);
        }
    }

    public free() {
        const err = wormhole.Client.free(this.goClient)
        if (!err) {
            throw err;
        }
    }
}
