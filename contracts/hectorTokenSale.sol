// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "./hectorToken.sol";
contract hectorTokenSale  {
    address owner;
    uint256 price;
    hectorToken TokenContract; // Variable de la interface.
    uint256 public tokensSold; // Acumulativo de tokens vendidos.
    address payable private ethFunds = payable(0x5C2143affd2963291Cda790c591dEf00d4D5843B);
    uint256 public transactionCount;
    struct Transaction {
        address buyer;
        uint256 amount;
    }
    mapping(uint256 => Transaction) public transaction;
    event Sold(address indexed buyer, uint256 amount);
    modifier onlyOwner() {
         require(msg.sender == owner, "Solo puede llamar el propietario");
        _;
    }
    
    constructor(uint256 _price, address _addressContract)  {
        
        owner = msg.sender;
        price = _price;
        
        // pásamos el contrato del token a nuestra variable interface
        TokenContract = hectorToken(_addressContract);
    }
    
    
  //No importamos toda la libreria SafeMath porque solamente necesitamos la función multiplicación.
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }
  
    function priceinWeis() public view  returns (uint256) {
    return price;
  }
  
 
    function setPrice(uint256 _newprice) public onlyOwner() {
    price = _newprice;
  }
  
  
   function etherBalance() public view onlyOwner() returns (uint256)  {
    return address(this).balance;
  }
  
   function tokenBalance() public view onlyOwner() returns (uint256)  {
    return TokenContract.balanceOf(address(this));
  }
  

   
  
    
  function buy(uint256 tokens) public payable {
        
        // que la cantidad que nos paga sea igual al precio x la cantidad de tokens que desea
        require(msg.value == mul(price, tokens), "la cantidad q paga no es igual al precio por la cantidad de tokens" ); 
        
        // al llamar la funcion original de transferencia tenemos que indicar la cantidad con los ceros de los decimales.
        uint256 amountwithzeros = mul(tokens, uint256(10) ** TokenContract.decimals());
        
        // comprobamos que el contrato de venta tenga los tokens que se desean comprar.
        require(TokenContract.balanceOf(address(this)) >= amountwithzeros, "el contrato de venta no tiene tokens"); //address(this) direccion de nuestro contrato
        
        // realizamos la transferencia con un require por mayor seguridad.
        require(TokenContract.transfer(msg.sender, amountwithzeros), "fallo la transferencia "); // introducimos la cantidad escalada.
        ethFunds.transfer(msg.value);
         // sumamos la venta.
        tokensSold += tokens; // fíjese, que usamos la cantidad sin la suma de los ceros de los decimales.
        transaction[transactionCount] = Transaction(msg.sender, tokens);
        transactionCount++;
        
        emit Sold(msg.sender, tokens);
        
    }


    function endSale() public {
        require(msg.sender == owner);
        // Return the tokens that were left inside of the sale contract
        uint256 amount = TokenContract.balanceOf(address(this));
        require(TokenContract.transfer(owner, amount));
        selfdestruct(payable(owner));
    }

}