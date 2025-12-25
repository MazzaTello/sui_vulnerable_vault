## I will update this project in the future.

Now, we have to copy the IDs manually. In the next version, i will fix.

** The tests are not working. ** I will fix this in the next version.

# Sui Vulnerable Vault Project

This project is a simple smart contract mistake and how to fix it. It focuses on access control on the Sui blockchain.

## What is this project?

I created two versions of a Vault:
1. **Vulnerable**: A version with a security hole.
2. **Solution**: Safe version.

## The Problem (Vulnerable)

In the `vulnerable` folder, the contract allows people to withdraw money. But there is a big mistake: **it does not check who you are.**

If I deploy this contract, anyone can call the `withdraw` function and take the money. The code forgets to ask: "Are you the owner?"

## Exploit

I wrote a Python script (`exploit.py`) to test this.
- The script connects to Sui.
- It asks the contract to give me money.
- Because there is no check, the contract gives me the money.

This proves that the code isn't safe.

## The Solution (Fix)
In the `solution` folder, I fixed the code. I added one important line:

```move
assert!(tx_context::sender(ctx) == vault.owner, 403);
```

**What does this line do?**
- It checks: Is the person calling the function (`sender`) the same as the Vault owner?
- If **Yes**: Continue.
- If **No**: Stop and give an error.

## How to Test

1. **Deploy Vulnerable Code**: Put the code on the network.
2. **Run Python Script**: Use `exploit.py`. You will see the money transfer is successful.
3. **Deploy Fixed Code**: Put the new code on the network.
4. **Try Again**: Try the same script. This time, it will fail.


