pragma solidity >=0.5.0 <0.8.4;

contract SimpleSharedWallet {
    
    address public owner;
    uint creationTime = block.timestamp;
    uint tillThisTime = block.timestamp + 30 days;
    
    constructor() {
        owner = msg.sender;
    }
    
    function sendMoney() public payable {
        
    }
    
    
    mapping(address => uint) public allowance;
    mapping(address => bool) eligible;
    
    function addAllowance(address _to, uint _amount) public {
        require(msg.sender == owner);
        eligible[_to] = true;
        allowance[_to] = _amount;
        
    }
    
    
    modifier ownerOrAllowed(uint _amount){
        require(allowance[msg.sender] >= _amount,"You are not owner allowed or Allownce limit is exceeded");
        _;
    }
    

    function transfer(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(block.timestamp < tillThisTime);
        require(eligible[_to] = true);
        allowance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    function withdraw(address payable _to, uint _amount) public {
        require(msg.sender == owner);
    }
    
}
