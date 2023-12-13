// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "openzeppelin/contracts/utils/Strings.sol";

import "../src/interfaces/IWETH9.sol";


/*
* @author Julien P.
* @notice 
*   Some interactions with an already deployed contract
*   I took the WETH9 contract, and test it on a local fork of mainnet
*/
contract InteractWithDeployedContractScript is Script {
    address immutable WETH9_CONTRACT_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    WETH9 _deployedContract;

    function run() external {
        // Accessing to already deployed contract with his address
        _deployedContract = WETH9(WETH9_CONTRACT_ADDRESS);

        _showContractBalance();
        _showBalanceOfGivenAccount(address(this));

        _makeDeposit(10 ether);

        _showContractBalance();
        uint accountBalance = _showBalanceOfGivenAccount(address(this));

        //_withdraw(1 ether); // Brocked for the moment

        _showContractBalance();
        _showBalanceOfGivenAccount(address(this));
    }

    /*
    * @author Julien P.
    * @notice Display in logs the actuel contract's balance
    */
    function _showContractBalance() view internal {
        console.log(string.concat("Contract balance : ", Strings.toString(_deployedContract.totalSupply())));
    }

    /*
    * @author Julien P.
    * @notice 
    *   Make a deposit of the given amount to the deployed contract
    *   This will give us the equivalent in WETH
    * @param    uint    The amount to deposit
    */
    function _makeDeposit(uint amount) internal {
        _deployedContract.deposit{value: amount}();
    }

    /*
    * @author Julien P.
    * @notice Shows the given account balance in WETH
    * @return    uint    The given account's balance
    */
    function _showBalanceOfGivenAccount(address accountAddress) view internal returns(uint) {
        uint accountBalance = _deployedContract.balanceOf(accountAddress);

        console.log(string.concat("Balance of account ", Strings.toHexString(uint256(uint160(accountAddress)), 20), 
            " : ", Strings.toString(accountBalance)));

        return accountBalance;
    }

    function _withdraw(uint amount) internal {
        _deployedContract.withdraw(amount);
    }
}