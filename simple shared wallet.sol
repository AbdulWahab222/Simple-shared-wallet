
pragma solidity >=0.5.0 <0.8.4;

contract SimpleSharedWallet {
    
    address public owner;
    address ContractAddress = address(this);
    
    constructor() public {
        owner = msg.sender;
    }
    
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    mapping(address => bool) eligible;
    
    
    function sendMoney() public payable {
        balances[ContractAddress] += msg.value;
    }
    
    function ContBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function setAllowance(address _addr, uint _amount) public {
        require(msg.sender == owner, "You are not allowed");
        eligible[_addr] = true;
        allowance[ContractAddress][_addr] = _amount;

    }
    
    function transferFrom(address payable _spender, uint _amount) public {
        require(eligible[msg.sender], "You are not authorized");
        allowance[ContractAddress][_spender] -= _amount;
        _spender.transfer(_amount);
        balances[ContractAddress] -= _amount;
        balances[_spender] += _amount;
        
    }
    
    function withDraw(address payable _to, uint _amount) public payable {
        require(msg.sender == owner);
        _to.transfer(_amount);
        balances[ContractAddress] -= _amount;
    }
}
