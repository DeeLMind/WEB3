import { Connection } from "@solana/web3.js";

const connection = new Connection("https://api.devnet.solana.com", "confirmed");
console.log("Connection to Solana Devnet established:", connection);