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

         // ------ DEPOT-------: Je dépose des fonds depuis mon adresse vers l'adresse du smart contrat 
    function deposit() public payable returns(uint) { //fonction deposit avec le mot-clé "payable" nous permet de déposer de l'Ether sur notre smart contract. 

        balance[msg.sender] += msg.value; // Cette ligne peut être supprimer. Le mapping des balances "balance [msg.sender]" nous aident à identifier les balances internes de notre contract. Cela n'a rien a voir avec LA balance de notre smart contract itself. 
        // En effet, la balance de notre smartcontract sera la somme de tous les deposit. En gros, le balance mapping "balance [msg.sender]" na rien a voir avec return balance[msg.sender]; //ici on retourne la balance de l'envoyeur "[msg.sender]"" updaté
        // LA balance de notre smartcontract mais plutôt aavec les adresses qui ont déposé des fonds sur notre smartcontract. 
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender]; 
}

//   ------- WITHDRAW------: Je retire les fonds du smart contract pour les envoyer vers mon adresse. 

    function withdraw(uint amount) public onlyOwner returns (uint) { //La fonction withdraw permet de retirer des fonds déposer sur l'adresse de notre smart contract vers une autre adresse. Dans Cette
        require(balance[msg.sender] >= amount, "Balance not sufficient"); // Je rajoute un error handling "Require" afin de m'assurer que l'adresse voulant  retirer ne retire pas plus que ce qu'il possède sur son compte. 
        emit withdrawDone(amount, msg.sender);
        balance[msg.sender] -= amount; // Je m'assure que la fonction withdraw retire bien les fonds présents sur l'adresse. 
        //exmple il s'agit de l'adresse msg.sender vers laquelle les fonds sont envoyés. 
        msg.sender.transfer(amount);   //msg.sender est une adresse
        // le .transfer est une fonction qui permet d'envoyer des fonds vers une adresse.                                                                                                 
    }

    //------------ GET BALANCE-----: j'affiche la balance de mon adresse.
    function getBalance() public view returns(uint) {// fonction pour afficher une balance qui retourne un integer de l'adresse du owner du contrat.  
        return balance[msg.sender];
    }

    //------------ TRANSFERT----- : je transfert mes fonds d'une adresse à une autre. 
        function transfer (address recipient, uint amount) public {// fonction permettant de transferer des fonds d'une adresse à l'autre
            require(balance[msg.sender] >= amount, "Balance not sufficient"); // error handling "require" pour s'assurer que l'envoyeur à les fonds suffisants pour l'envoi. 2eme argument c'est le message d'erreur
            require(msg.sender != recipient, "Dont transfer money to yourself"); // error handling "require" pour s'assurer que l'envoyeur ne s'envoit pas les fonds à lui même
            emit transfertDone(amount, msg.sender, recipient);
            uint previousSenderBalance = balance[msg.sender];    
            _transfer(msg.sender, recipient, amount); // déclaration de la fonction _transfer (ci-dessous) avec en argument les inputs : adresse de 
                                                     // l'envoyeur, sdu receveur et le montant à transferer.
            // Cette ligne est un exemple d'interaction avec un contrat externe. Dans cette exemple, il s'agit du contrat Government.sol. Cette ligne fait écho aux lignes 17 et 19.
            // Elle permet d'envoyer les infos en paramètre à notre contrat externe. Il est aussi possible d'envoyer de la valeur vers le contrat 
            //externe en rajoutant le {value: 1 ether} par ex. 
            GovernmentInstance.addTransaction {value: 1 ether} (msg.sender, recipient, amount);   
                                                     
            assert(balance[msg.sender] == previousSenderBalance - amount); // assert est similaire à "require". Dans ce cas, il permet de s'assurer
        //qu'à l'issue du transfert, la balance du sender ait bien sa balance moins le montant transféré. 
        
        //event Logs and further checks
    }

      function _transfer(address from, address to, uint amount) private { // fonction qui permet de débiter les fonds de l'envoyeur et de créditer 
        balance[from] -= amount;                                        //le compte du receveur. Noter que cette fonction est "private"
        balance[to] += amount;    
    }

}