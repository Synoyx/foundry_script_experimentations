// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/interfaces/IWETH9.sol";

contract InteractWithDeployedContractScript is Script {
    address immutable WETH9_CONTRACT_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    WETH9 _deployedContract;

    function run() external {
        // Accessing to already deployed contract with his address
        _deployedContract = WETH9(WETH9_CONTRACT_ADDRESS);

        _showContractBalance();
        _showBalanceOfGivenAccount(msg.sender);
        _makeDeposit(1 ether);
        _showContractBalance();
        _showBalanceOfGivenAccount(msg.sender);
    }

    /*
    * @author Julien P.
    * @notice Display in logs the actuel contract's balannce
    */
    function _showContractBalance() view internal {
        console.log(string.concat("Contract balance : ", _deployedContract.totalSupply()));
    }

    /*
    * @author Julien P.
    * @notice 
    *   Make a deposit of the given amount to the deployed contract
    *   This will give us the equivalent in WETH
    * @param    uint    The amount to deposit
    */
    function _makeDeposit(uint amount) view internal {
        _deployedContract.deposit{value: amount}();
    }

    function _showBalanceOfGivenAccount(address accountAddress) view internal {
        console.log(string.concat("Balance of account ", Strings.toHexString(uint256(uint160(accountAddress)), 20), 
            " : ", _deployedContract.balanceOf(accountAddress)));
    }
}