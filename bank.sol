pragma solidity 0.7.5; 

import "./Ownable.sol";
import "./Destroyable.sol";

// ----------------- L'INTERFACE----------------
// Toujours positionner à la racine d'un contrat. In order to interact with the Gov contract, our contract needs to know the "function definition" of the Gov function, the input and the output of the gov contract. 
// We also need to know where the Gov contract is localized. For all of this, we need an interface. 

interface GovernmentInterface {
    // On spécifie les fonctions avec lesquelles on veut intéragir. On  a besoin  de savoir comment la fonction est appelée,quels sont ses arguments et ce qu'il retourne(s'il retourne quelque chose).
        function addTransaction(address _from, address _to, uint _amount) payable external; 

}
//---------------------------------------------


contract Bank is Ownable, Destroyable { // Ce contract hérite de Ownable.sol et Destroyable.sol {

}