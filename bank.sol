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

// DATA LOCATION
    //storage - permanent storage of data (state variables)
    //memory - temporary storage used in function execution
    //call data - save arguments/input to our functions
    
    //strings, arrays, mappings, structs
    
    
    // Mapping
    mapping(address => uint) balance; // Is it useful to have a variable balance to our contract so that our contract can query for its own balance

// Instance de l'interface 
   //On créé une instance du contrat Gov dans notre Bank contract. On spécifie l'adresse du contrat externe Gov afin d'intéragir avec le Gov contrat.
    GovernmentInterface GovernmentInstance = GovernmentInterface(0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8);

  
  // Event 
    event depositDone(uint amount, address indexed depositedTo); // Event : C'est une façon de log  des events et de la data during a function execution. En arguments s'affichera
    // le montant déposé et l'addresse recevant les fonds. 
    
       event withdrawDone(uint amount, address sender); // Event : C'est une façon de log  des events et de la data during a function execution. En arguments s'affichera
    // le montant déposé et l'addresse d'envoi et l'adresse recevant les fonds. 

    event transfertDone(uint amount, address sender, address recipient); 

contract Bank is Ownable, Destroyable { // Ce contract hérite de Ownable.sol et Destroyable.sol {

}