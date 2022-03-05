// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.12;

contract PiggyBank {
    address private minter;
    mapping(address => uint256) private getContractBalance;
    
    constructor() {
        minter = msg.sender;
    }

    modifier onlyOwner() {
        require(minter == msg.sender, "ERROR_CODE: 0x1 => Invalid contract owner!");
        _;
    }

    fallback() external payable {}

    event Received(address, uint256);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    
    function withdrawFunds(address payable _to, uint256 _amount) public onlyOwner {
        //TODO: Add a modifier to allow only withdraws from the contract owner
        _to.transfer(_amount);

    }

    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }

}