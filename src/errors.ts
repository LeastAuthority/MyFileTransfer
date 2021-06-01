// import {AlertOptions} from "@ionic/core";
// import {ClientConfig} from "@/go/wormhole/types";

import {AlertOptions} from "@ionic/core";
import {ClientConfig} from "@/go/wormhole/types";

export class AlertError extends Error {
    public opts: AlertOptions;

    constructor(opts: AlertOptions) {
        super();
        this.opts = opts;
    }

    get message() {
        return this.opts.message as string;
    }
}


class ErrMailbox extends AlertError {
    public pattern(config: ClientConfig): RegExp {
        return new RegExp(`.*${config.rendezvousURL}.*`)
    }

    public matches(errorMsg: string, config: ClientConfig): boolean {
        return this.pattern(config).test(errorMsg)
    }
}

class ErrRelay extends AlertError {
    name = 'Relay Error'

    public pattern(config: ClientConfig): RegExp {
        // TODO: improve error messaging.
        return new RegExp(`(^websocket.Dial failed$)|(.*${config.transitRelayURL}.*)`);
    }

    public matches(errorMsg: string, config: ClientConfig): boolean {
        return this.pattern(config).test(errorMsg)
    }
}

export const errReceiveNoSender = new Error('No sender seen, check the code and try again.')
export const errMailbox = new ErrMailbox({
    message: 'Unable to connect to the rendezvous server.',
})
export const errRelay = new ErrRelay({
    message: 'Unable to connect to the transit relay.',
})

// export class ReceiveError extends Error {
//     // name = 'ReceiveError'
//     message = 'No sender seen, check the code and try again.';
// }

// export interface Error {
//     alert: AlertOptions
// }
//
// // TODO: something core comprehensive
// export const Errors: Error[] = [
//
// ];
//
// export function matchError(errorMsg: string, config: ClientConfig): Error {
//
//     (new RegExp(`.*${config.rendezvousURL}.*`)).test(errorMsg)
// }