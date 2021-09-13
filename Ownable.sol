pragma solidity 0.7.5; 

contract Ownable {
    address payable owner;

    modifier onlyOwner{
        require(msg.sender == owner);
        _; // run the function
    }

    constructor(){
        owner == msg.sender;
    }
}