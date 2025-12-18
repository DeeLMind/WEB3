import { NEAR } from "@near-js/tokens";

const account = new Account("user.testnet", provider);

// returns yoctoNear amount as bigint
const amount = await account.getBalance(NEAR);
// converts to human-readable string like "1.234"
NEAR.toDecimal(amount);