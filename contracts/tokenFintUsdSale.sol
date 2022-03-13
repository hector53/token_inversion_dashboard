// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "./tokenFintUsd.sol";
interface tokenUsdtMio {
    function transfer(address _to, uint256 _value) external returns (bool);
    function getAllowance(address _owner, address spender) external view returns (uint);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function getBalanceOf(address _address) external view returns (uint256);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function getVesting(address _address) external view returns (uint256);
    
}
contract tokenFintUsdSale  {
    address owner;
    uint256 price;
    tokenFintUsd TokenContract; // Variable de la interface.
    uint256 public tokensSold; // Acumulativo de tokens vendidos.
    uint256 public tokensBuy; // Acumulativo de tokens comprados
    uint256 public transactionCount;
    tokenUsdtMio usdt = tokenUsdtMio(address(0xf16449A4F90f90A004E7BfDA8b6bfBCAEF5b6A62)); //instanciamos el token usdt mio
    struct Transaction {
        address buyer;
        uint256 amount;
    }
    mapping(uint256 => Transaction) public transaction;
    event tokenVendidos(address indexed buyer, uint256 amount);
    event tokenComprados(address indexed buyer, uint256 amount);
    modifier onlyOwner() {
         require(msg.sender == owner, "Solo puede llamar el propietario");
        _;
    }
    constructor (address _addressContract)  {
        owner = msg.sender;
        // pásamos el contrato del token a nuestra variable interface
        TokenContract = tokenFintUsd(_addressContract);
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
   function tokenBalance() public view onlyOwner() returns (uint256)  {
    return TokenContract.balanceOf(address(this));
  }
  function buy(uint256 amount) public payable {
        require(amount > 0, "You need to sell at least some tokens");
        // al llamar la funcion original de transferencia tenemos que indicar la cantidad con los ceros de los decimales.
        uint256 amountwithzeros = mul(amount, uint256(10) ** TokenContract.decimals());
        // comprobamos que el contrato de venta tenga los tokens que se desean comprar.
        require(TokenContract.balanceOf(address(this)) >= amountwithzeros, "el contrato de venta no tiene tokens"); //address(this) direccion de nuestro contrato
        //tambien necesitamos saber q el comprador tiene los tokens con los q va pagar USDT 
        require(usdt.getBalanceOf(msg.sender) >= amountwithzeros, "el comprador no tiene suficientes USDT"); 
        //aprobamos los tokens 
    //    usdt.approve(address(this), amountwithzeros);
        //ahora aprobamos q el contrato pueda usar el transfrom
        uint256 allowance = usdt.getAllowance(msg.sender, address(this));
        //preguntamos q tenga tokens usdt
        require(allowance >= amountwithzeros, "Check the token allowance");
        //transferimos los usdt para pagar 
        usdt.transferFrom(msg.sender, address(this), amountwithzeros); //aqui envio los usdt a la cuenta mia 
        // realizamos la transferencia con un require por mayor seguridad. transferimos los fintusd 
        require(TokenContract.transfer(msg.sender, amountwithzeros), "fallo la transferencia "); // introducimos la cantidad escalada.
         // sumamos la venta.
        tokensSold += amount; // fíjese, que usamos la cantidad sin la suma de los ceros de los decimales.
        transaction[transactionCount] = Transaction(msg.sender, amount);
        transactionCount++;
        emit tokenVendidos(msg.sender, amount);
    }

    function sell(uint256 amount) public {
      require(amount > 0, "You need to sell at least some tokens");
      
      // al llamar la funcion original de transferencia tenemos que indicar la cantidad con los ceros de los decimales.
      uint256 amountwithzeros = mul(amount, uint256(10) ** TokenContract.decimals());
        require(TokenContract.getVesting(msg.sender) == false, "no puede transferir porque tiene vesting ");
       // comprobamos que la direccion donde enviamos los tokens usdt tenga los tokens que se desean cambiar osea los usdt.
        require(usdt.getBalanceOf(address(this)) >= amountwithzeros, "el contrato de venta no tiene tokens"); //address(this) direccion de nuestro contrato
        //tambien necesitamos saber q el comprador tiene los tokens con los q va pagar FintUsd 
        require(TokenContract.getBalanceOf(msg.sender) >= amountwithzeros, "el comprador no tiene suficientes FintUsd"); 
        //ahora verificamos  q el contrato pueda transferir los fintusd del usuario  
        uint256 allowance = TokenContract.getAllowance(msg.sender, address(this));
        //preguntamos q tenga tokens fintusd
        require(allowance >= amountwithzeros, "Check the token allowance fintusd");
        //transferimos los FintUsd para pagar 
        TokenContract.transferFrom(msg.sender, address(this), amountwithzeros); //aqui envio los usdt a la cuenta del contrato de venta
        // realizamos la transferencia con un require por mayor seguridad. transferimos los Usdt del contrato 
        require(usdt.transfer(msg.sender, amountwithzeros), "fallo la transferencia de usdt del contrato hacia ti "); // introducimos la cantidad escalada.
        tokensBuy += amount; // fíjese, que usamos la cantidad sin la suma de los ceros de los decimales.
        transaction[transactionCount] = Transaction(msg.sender, amount);
        transactionCount++;
        emit tokenComprados(msg.sender, amount);
  }

  function transferUsdtTo(address _to, uint256 _value) public returns (bool success){
        uint256 amountwithzeros = mul(_value, uint256(10) ** TokenContract.decimals());
        require(usdt.getBalanceOf(address(this)) >= amountwithzeros, "el contrato de venta no tiene tokens"); //address(this) direccion de nuestro contrato
        require(usdt.transfer(_to, amountwithzeros), "fallo la transferencia "); // introducimos la cantidad escalada.
        return true; //retornamos true 
    }

    function transferUsdtFrom(address _from, address _to, uint256 _value) public returns (bool success){
        uint256 amountwithzeros = mul(_value, uint256(10) ** TokenContract.decimals());
        usdt.transferFrom(_from, _to, amountwithzeros); //aqui envio los usdt a la cuenta mia 
        return true; //retornamos true 
    }


    function endSale() public {
        require(msg.sender == owner);
        // Return the tokens that were left inside of the sale contract
        uint256 amount = TokenContract.balanceOf(address(this));
        require(TokenContract.transfer(owner, amount));
     //   selfdestruct(payable(owner));
    }
}