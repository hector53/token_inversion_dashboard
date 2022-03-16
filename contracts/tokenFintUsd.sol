// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
contract tokenFintUsd {
    address owner;
    string public name; //nombre del token
    string public symbol;   //simbolo del token 
    uint8 public decimals;  //variable para los decimales 
    uint256 public totalSupply; //cantidad inicial del token 
    uint8 public interes; 
    uint8 public vestingDays; 
    uint public porcentajeForumula; //( (1 + interes) ^ (1/52) )-1
    mapping(address => uint256) public balanceOf; 
    mapping(address => mapping(address => uint256)) public allowance; 
     struct Payment {
        uint amount;
        uint timestamp;
    }
    struct AddressVes {
        bool active;
        uint counter;
        mapping(uint => Payment) cantOfVesting;
    }
    mapping(address => AddressVes) public vesting; //variable para activar o desactivar vesting en una address
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
        interes = 22; //0.22%
        vestingDays = 0; 
        porcentajeForumula = 3831; //0.3831
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event aumentarMonedas(uint amount);
    event disminuirMonedas(uint amount);
    event calcularGanancia(string texto, uint ganancia);
    event iniciarVesting(string texto, address indexed _from);
    event deleteVesting(string texto, address indexed _from);
    event eventoPrueba(string x);
    event eventoPrueba2(string x, uint c);
  

    function mul(uint256 a, uint256 b) public pure returns (uint256 c) {
    if (a == 0) {
    return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
    }
    function getBalanceOf(address _address) public view returns (uint256) {
        return balanceOf[_address];
    }
    function getVestingAddr(address addr, uint c) public view returns(Payment memory){
        return vesting[addr].cantOfVesting[c]; 
    }

      function getAllowance(address _owner, address spender) public view returns (uint){
        return allowance[_owner][spender];
    }

     function getVesting(address _address) public view returns (bool){
        return vesting[_address].active;
    }

    function calculateFee(uint amount, uint _porcentaje) public pure returns(uint x){
        uint calculo = amount * _porcentaje/ 1000; 
        return mul(calculo, 10**15); 
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        //recibe la direccion a donde se envia , y el valor de tokens a enviar
        //retorna un success en caso de ser exitosa
        require(vesting[msg.sender].active == false, "tiene vesting"); 
          require(vesting[msg.sender].active == false, "no puede transferir porque tiene vesting ");
          require(balanceOf[msg.sender] >= _value, "no tiene tokens suficientes");//se lee alreves por lo q entiendo osea
          //si el balance es mayor entonces pasa pa la siguiente linea de lo contrario too low
          //msg.sender = direccion de quien esta enviando el saldo 
            if(vesting[_to].active){
            vesting[_to].cantOfVesting[vesting[_to].counter].amount = _value; 
            vesting[_to].cantOfVesting[vesting[_to].counter].timestamp = block.timestamp; 
            vesting[_to].counter++; 
            }
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
          require(vesting[_from].active == false, "no puede transferir porque tiene vesting ");
        require(balanceOf[_from] >= _value  ); //comprobar si el dueño tiene esos tokens 
        require(allowance[_from][msg.sender] >= _value); //comprobar si quien invoca la transaccion esta autorizado a manejar esos tokens 
        
          if(vesting[_to].active){
            vesting[_to].cantOfVesting[vesting[_to].counter].amount = _value; 
            vesting[_to].cantOfVesting[vesting[_to].counter].timestamp = block.timestamp; 
            vesting[_to].counter++; 
            }
        balanceOf[_from] -= _value; 
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value; 
        emit Transfer(_from, _to, _value);
        return true;

    }
    function setInteres(uint8 _value) public onlyOwner{
            interes = _value; 
    }
     function setVestingDays(uint8 _value) public onlyOwner{
            vestingDays = _value; 
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
    function tokenVesting() public {
        uint balanceSender = balanceOf[msg.sender]; 
        require(vesting[msg.sender].active == false && balanceSender>0, "no balance, vesting active");
            //si no tiene vesting y tiene tokens entonces puede iniciar su vesting
            vesting[msg.sender].active = true; //lo activo
            vesting[msg.sender].cantOfVesting[vesting[msg.sender].counter].amount = balanceSender; 
            vesting[msg.sender].cantOfVesting[vesting[msg.sender].counter].timestamp = block.timestamp; 
            vesting[msg.sender].counter++; 
            emit iniciarVesting("Inicio vesting", msg.sender);
    }
    function removeVesting() public {
        require(vesting[msg.sender].active, "no tiene vesting"); 
        vesting[msg.sender].active = false; 
        vesting[msg.sender].counter = 0; 
        emit deleteVesting("Remove vesting", msg.sender);
    }
    function calculateGanancia(uint amount) public view returns(uint x){
      uint calculo = amount * porcentajeForumula/ 1000000;  //3831  0.3831%
      //  return mul(calculo, 10**15); 
      return calculo; 
    }
    function distributeProfitsVesting(address addr) public onlyOwner(){
        require(vesting[addr].active, "no tiene vesting");
        uint totalAmountTransfer;
       // emit eventoPrueba2("el contador es: ", vesting[addr].counter);
         for (uint i = 0; i < vesting[addr].counter; i++) {
            uint startDate = vesting[addr].cantOfVesting[i].timestamp; // 2012-12-01 10:00:00
            uint endDate = block.timestamp; // 2012-12-07 10:00:00
            uint daysDiff = (endDate - startDate) / 60 / 60 / 24; // 6 days
            if(daysDiff == vestingDays){
                //ya pasaron 7 dias entonces envio ganancias a este wey
          //      emit eventoPrueba("ya pasaron los dias ahora voy a enviar ganancias"); 
                uint ganancia =  calculateGanancia(vesting[addr].cantOfVesting[i].amount ); 
                totalAmountTransfer = totalAmountTransfer + ganancia; 
                // enviarGanancias(addressVesting[contadorVestings].addr, ganancia );
                //ponemos nueva fecha 
                vesting[addr].cantOfVesting[i].timestamp = block.timestamp; 
              //  emit eventoPrueba2("totalAmountTransfer: ", totalAmountTransfer);
            }else{
                emit eventoPrueba("no han pasado los dias");
            }
        }
        //ya tenemos el total a transferir , transferimos 
        transfer(addr, totalAmountTransfer);
    }
}