pragma solidity 0.7.5; 

import "./Ownable.sol";

contract Destroyable is Ownable{

    constructor(){
        address payable owner = msg.sender;
    }

    function close() public payable onlyowner{
        require (msg.sender == owner, "You are not the owner");
        selfdestruct(msg.sender); // le contrat est désormais inutilisable et tous les fonds restants sont envoyer au owner du smart contract

    }
}