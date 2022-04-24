/*
Joint Savings Account
---------------------
*/

pragma solidity ^0.5.0;

contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    
    function withdraw(uint amount, address payable recipient) public {

        // Require that the withdrawal is from an owner of the account and the account as sufficient funds
        require(recipient == accountOne || recipient == accountTwo,"You don't own this account!");
        require(address(this).balance >= amount, "Insufficient funds!"); 

        // Set lastToWithdraw to the current recipient
        if (lastToWithdraw != recipient){
        lastToWithdraw = recipient;
        }

        // Call the `transfer` function of the `recipient` and pass it the `amount`
        recipient.transfer(amount);
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {
        contractBalance = address(this).balance;
    }

    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    // Add a fallback function so the contract can store Ether sent from outside the deposit function.
    function() external payable {}
}
