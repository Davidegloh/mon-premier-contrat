pragma solidity 0.7.5; 

// On crée un struct de transaction. Chaque transaction se composera d'une adresse from, to, d'un montant et d'un Id de transaction
contract Government {
   struct Transaction{
       address from;
       address to;
       uint amount;
       uint txId; 
   }  

   //on crée un array de transaction pour stocker les transactions.
   Transaction[] transactionLog;


   
   function addTransaction(address _from, address _to, uint amount) payable external {// on créé une fonction qui ajoute des transactions.
    // on créer une variable qui s'appelle "_transaction" qu'on stock en mémoire et qui contient en argument: adresse from, adresse to, le montant et l'id de la transaction que l'on retient 
      Transaction memory _transaction  = Transaction (_from, _to, amount, transactionLog.length); 
      // on pousse (push) la variable _transaction dans le tableau (Array) "TransactionLog"
      TransactionLog.push(_transaction);
   }

    
}