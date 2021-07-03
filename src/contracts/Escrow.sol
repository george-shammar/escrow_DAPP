// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Escrow {
    
    address agent;
    
    mapping(address => uint256) public deposits;
    
    modifier onlyAgent() {
        require(msg.sender == agent);
        _;
    }
    
    constructor() {
        agent = msg.sender;
    }
    
     function debitBuyer() public payable {
        address payee = agent;
        uint256 buyingAmount = msg.value;
        deposits[payee] = deposits[payee] + buyingAmount;
    }
    
    function creditEscrow(address payable payee) public payable {
        uint256 credit = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(credit);
    }
    
    function debitEscrow(address payee) public onlyAgent payable {
        uint256 amount = msg.value;
        
        deposits[payee] = deposits[payee] + amount;
    }
    
    function creditSeller(address payable payee) public onlyAgent payable {
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(payment);
    } 
}