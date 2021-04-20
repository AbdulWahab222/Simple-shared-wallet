
    uint creationTime = block.timestamp;
    uint tillThisTime = block.timestamp + 30 days;
    
    
    function sendMoney() public payable {
        require( block.timestamp > creationTime + 1 minutes);
        balances[ContractAddress] += msg.value;
    }
    
    
    function transferFrom(address payable _spender, uint _amount) public {
        require(block.timestamp < tillThisTime);
        require(eligible[msg.sender], "You are not authorized");
        allowance[ContractAddress][_spender] -= _amount;
        _spender.transfer(_amount);
        balances[ContractAddress] -= _amount;
        balances[_spender] += _amount;
        
    }
