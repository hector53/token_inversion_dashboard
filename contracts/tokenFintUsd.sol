// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
contract tokenFintUsd {
    address owner;
    string public name; //nombre del token
    string public symbol;   //simbolo del token 
    uint8 public decimals;  //variable para los decimales 
    uint256 public totalSupply; //cantidad inicial del token 
    mapping(address => uint256) public balanceOf; 
    mapping(address => mapping(address => uint256)) public allowance; 
    mapping(address => mapping(address => uint256)) public vesting; 
    mapping(address => mapping(address => uint256)) public vestingTimeByAddress; 
    uint16 public vestingTimeDuration; 
    bool public vestingActive; 
    //aqui se guarda la direccion de quien aprueba y luego la direccion a quien aprueba y la cantidad
    //ejemplo [xxxxx] => [yyyy] => 15
      modifier onlyOwner() {
         require(msg.sender == owner, "Solo puede llamar el propietario");
        _;
    }
     constructor(){
        owner = msg.sender;
        name = "Token FintUsd Test 1"; 
        symbol = "FIntUsd"; 
        decimals = 18; 
        totalSupply = 1000000000000 * (uint256(10) ** decimals ); 
        balanceOf[msg.sender] = totalSupply; //enviamos todos los tokens a la direccion creadora del contrato
    }
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event aumentarMonedas(uint amount);
    event disminuirMonedas(uint amount);
    function getBalanceOf(address _address) public view returns (uint256) {
        return balanceOf[_address];
    }
      function getAllowance(address _owner, address spender) public view returns (uint){
        return allowance[_owner][spender];
    }
    function transfer(address _to, uint256 _value) public returns (bool success){
        //recibe la direccion a donde se envia , y el valor de tokens a enviar
        //retorna un success en caso de ser exitosa
          require(balanceOf[msg.sender] >= _value);//se lee alreves por lo q entiendo osea
          //si el balance es mayor entonces pasa pa la siguiente linea de lo contrario too low
          //msg.sender = direccion de quien esta enviando el saldo 
          balanceOf[msg.sender] -= _value; //descontamos el monto a transferir de la cuenta q esta transfiriendo 
          balanceOf[_to] += _value; //sumamos el token a la direccion q esta recibiendo 
          emit Transfer(msg.sender, _to, _value); //emitimos el evento de transferencia 
          return true; //retornamos true 
    }
    function approve(address _spender, uint256 _value) public returns (bool success){
        allowance[msg.sender][_spender] = _value; //autorizamos a tener esos tokens 
        emit Approval(msg.sender, _spender, _value); 
        return true; 
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(balanceOf[_from] >= _value  ); //comprobar si el dueño tiene esos tokens 
        require(allowance[_from][msg.sender] >= _value); //comprobar si quien invoca la transaccion esta autorizado a manejar esos tokens 
        balanceOf[_from] -= _value; 
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value; 
        emit Transfer(_from, _to, _value);
        return true;
    }
    function AumentaMoneda(uint amount) public onlyOwner {
        require(totalSupply + amount > totalSupply);
        require(balanceOf[owner] + amount > balanceOf[owner]);
        balanceOf[owner] += amount;
        totalSupply += amount;
        emit aumentarMonedas(amount);
    }
    function DisminuyeMoneda(uint amount) public onlyOwner {
        require(totalSupply >= amount);
        require(balanceOf[owner] >= amount);
        totalSupply -= amount;
        balanceOf[owner] -= amount;
        emit disminuirMonedas(amount);
    }
}