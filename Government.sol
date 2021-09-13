pragma solidity 0.7.5; 

contract Government {
      // On créer un struct de transaction. Chaque transaction se composera d'une adresse from, to, d'un montant et d'un Id de transaction
    struct Transaction {
        address from;
        address to;
        uint amount;
        uint txId;
        
      
    }
    
}