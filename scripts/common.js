const {accessSync} = require('fs');
// NB: loads .env file into respective env vars
// (see: https://github.com/motdotla/dotenv#readme)
const dotenv = require('dotenv');
const {exit} = require('process');

function loadEnv(envPath) {
    try {
        // NB: ensure we can load the env file
        accessSync(envPath);
        dotenv.config({path: envPath});
    } catch (error) {
        console.error(error);
        exit(2);
    }
}

module.exports = {
    loadEnv,
}
