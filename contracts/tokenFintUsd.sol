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
        address addr;
    }
    mapping(address => bool) public vesting; //variable para activar o desactivar vesting en una address
    mapping(address => mapping(uint => Payment)) public vestingTokens; // para ir añadiendo la cantidad de token con vesting y fecha diferente
    mapping(uint => AddressVes) public addressVesting; //para ir guardando las address q tienen vestings
    uint public vestingTokensContador = 0; 
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

    event eventoPrueba(string x);

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

      function getAllowance(address _owner, address spender) public view returns (uint){
        return allowance[_owner][spender];
    }

     function getVesting(address _address) public view returns (bool){
        return vesting[_address];
    }

    function calculateFee(uint amount, uint _porcentaje) public pure returns(uint x){
        uint calculo = amount * _porcentaje/ 1000; 
        return mul(calculo, 10**15); 
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        //recibe la direccion a donde se envia , y el valor de tokens a enviar
        //retorna un success en caso de ser exitosa
          require(vesting[msg.sender] == false, "no puede transferir porque tiene vesting ");
          require(balanceOf[msg.sender] >= _value, "no tiene tokens suficientes");//se lee alreves por lo q entiendo osea
          //si el balance es mayor entonces pasa pa la siguiente linea de lo contrario too low
          //msg.sender = direccion de quien esta enviando el saldo 

        if(vesting[_to]){
            //la direccion a donde envian token tiene vesting 
            uint contador = 0; 
            bool iterador = true; 
            while(iterador){
                if(vestingTokens[_to][contador].amount == 0){
                        //quiere decir q no tiene por lo tanto guardo aqui la cantidad actual y me salgo del ciclo
                        vestingTokens[_to][contador].amount = _value; 
                        vestingTokens[_to][contador].timestamp = block.timestamp; 
                        iterador = false; //me salgo del ciclo
                }
                contador++; 
            }
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
          require(vesting[_from] == false, "no puede transferir porque tiene vesting ");
        require(balanceOf[_from] >= _value  ); //comprobar si el dueño tiene esos tokens 
        require(allowance[_from][msg.sender] >= _value); //comprobar si quien invoca la transaccion esta autorizado a manejar esos tokens 
         if(vesting[_to]){
            //la direccion a donde envian token tiene vesting 
            uint contador = 0; 
            bool iterador = true; 
            while(iterador){
                if(vestingTokens[_to][contador].amount == 0){
                        //quiere decir q no tiene por lo tanto guardo aqui la cantidad actual y me salgo del ciclo
                        vestingTokens[_to][contador].amount = _value; 
                        vestingTokens[_to][contador].timestamp = block.timestamp; 
                        iterador = false; //me salgo del ciclo
                }
                contador++; 
            }
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

    function tokenVesting() public returns(uint disponible){
        if(vesting[msg.sender] == false && balanceOf[msg.sender]>0){ //si no tiene entonces y tiene tokens
            vesting[msg.sender] = true; //lo activo
            //ahora debo poner la primera de vestingTokens del addr el valor y la fecha actual
            uint contador = 0; 
            bool iterador = true; 
            while(iterador){
                if(vestingTokens[msg.sender][contador].amount == 0){
                        //quiere decir q no tiene por lo tanto guardo aqui la cantidad actual y me salgo del ciclo
                        vestingTokens[msg.sender][contador].amount = balanceOf[msg.sender]; 
                        vestingTokens[msg.sender][contador].timestamp = block.timestamp; 
                        iterador = false; //me salgo del ciclo
                }
                contador++; 
            }

            //otro ciclo para añadirlo a la variable addressVesting
            iterador = true; 
            contador = 0; 
            while(iterador){
                if(addressVesting[contador].active == false){
                    //no tiene entonces lo guardo ahi
                    addressVesting[contador].active = true; 
                    addressVesting[contador].addr = msg.sender; 
                    vestingTokensContador++; 
                    iterador = false; 
                }
                contador++; 
            }
            return 1;
        }else{
            return 0; 
        }
    }


    function quitarVesting() public {
        if(vesting[msg.sender]){//esta activo lo quito 
                vesting[msg.sender] = false; 
                //ahora quitar los vestingTokens; 
                uint contador = 0; 
                bool iterador = true; 
                while(iterador){
                    if(vestingTokens[msg.sender][contador].amount > 0){
                    //quiere decir q no tiene por lo tanto guardo aqui la cantidad actual y me salgo del ciclo
                    vestingTokens[msg.sender][contador].amount = 0;
                    vestingTokens[msg.sender][contador].timestamp = 0;
                    
                    }else{
                        iterador = false; //me salgo del ciclo xq ya no tiene mas 
                    }
                contador++; 
                }

                //otro ciclo para sacaro de la variable addressVesting
                iterador = true; 
                contador = 0; 
                while(iterador){
                    if(addressVesting[contador].addr == msg.sender  ){
                        //no tiene entonces lo guardo ahi
                        addressVesting[contador].active = false; 
                        addressVesting[contador].addr = 0x0000000000000000000000000000000000000000;
                        vestingTokensContador--; 
                        iterador = false; //me salgo del ciclo xq ya lo encontre
                    }
                    contador++; 
                }
        }
    }

    function getAddressinVesting() public view returns(uint cant){
                bool iterador = true; 
                uint contador = 0; 
                uint cantVesting = 0;
                while(iterador){
                    if(addressVesting[contador].active){
                        cantVesting++; 
                    }else{
                        iterador = false;
                    }
                    contador++; 
                }
                return cantVesting; 
    }

  

    function calculateGanancia(uint amount) public view returns(uint x){
      uint calculo = amount * porcentajeForumula/ 1000000;  //3831  0.3831%
      //  return mul(calculo, 10**15); 
      return calculo; 
    }
    function repartirGanancias() public onlyOwner  returns(uint status){
        //primero buscar las addr in vesting
            bool iteraVestings = true; 
            uint contadorVestings = 0; 
            while(iteraVestings){
                if(addressVesting[contadorVestings].active){
              //      emit eventoPrueba("si hay direccion con vesting, aqui empiezo a buscar los montos q tiene en vesting ");
                    status = 1; 
                    bool iterador = true; 
                    uint contador = 0; 
                    while(iterador){
                        if(vestingTokens[addressVesting[contadorVestings].addr][contador].timestamp>0){
                            //tiene vesting 
                            uint startDate = vestingTokens[addressVesting[contadorVestings].addr][contador].timestamp; // 2012-12-01 10:00:00
                            uint endDate = block.timestamp; // 2012-12-07 10:00:00
                            uint daysDiff = (endDate - startDate) / 60 / 60 / 24; // 6 days
                            if(daysDiff == vestingDays){
                                //ya pasaron 7 dias entonces envio ganancias a este wey
                          //      emit eventoPrueba("ya pasaron los dias ahora voy a enviar ganancias"); 
                                uint ganancia =  calculateGanancia(vestingTokens[addressVesting[contadorVestings].addr][contador].amount ); 
                            //    emit calcularGanancia("ganancia", ganancia);
                                 transfer(addressVesting[contadorVestings].addr, ganancia); 
                               // enviarGanancias(addressVesting[contadorVestings].addr, ganancia );
                            }else{
                                emit eventoPrueba("no han pasado los dias");
                            }
                        }else{
                            iterador = false;
                        }
                    contador++; 
                    }

                }else{
                    emit eventoPrueba("no hay direcciones en vesting o ya esta posicion no tiene por lo tanto es la ultima");
                    status = 0; 
                    iteraVestings = false;
                }
                contadorVestings++; 
            }


        return status;
    }





    
}