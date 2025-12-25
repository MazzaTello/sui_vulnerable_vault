//defines a Move module
module sui_vulnerable_vault::sui_vulnerable_vault{
    
    //imports libraries
    use sui::object::UID;
    use sui::tx_context::TxContext;
    use sui::tx_context;
    use sui::transfer;
    use sui::object;
    use sui::coin;
    use sui::sui::SUI;

    public struct Vault has key{
        id: UID,
        owner: address,
        //unsigned number don't have negative values
        balance: coin::Coin<SUI>
    }

    //creates a vault object on blockchain
    public entry fun create_vault(ctx: &mut TxContext){

        //create the Vault object in memory
        let vault = Vault{
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            balance: coin::zero<SUI>(ctx),
        };

        //shared object so everyone can exploit
        transfer::share_object(vault);
    }

    //anyone can deposit balance to the vault
    public entry fun deposit(vault: &mut Vault, payment: coin::Coin<SUI>, ctx: &mut TxContext){
        coin::join(&mut vault.balance, payment);
    }

    //anyone can withdraw balance from the vault
    // !! Missing access control vulnerability !!
    public entry fun withdraw(vault: &mut Vault, amount: u64, ctx: &mut TxContext){

        
        //decrease vault balance without access control
        let coin = coin::split(&mut vault.balance, amount, ctx);
        transfer::public_transfer(coin, tx_context::sender(ctx));
    }

}

