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
*   All operations must be done with a vm.prank() before,
*   as making operation with a contract's address (default case) can lead to some bugs
*/
contract InteractWithDeployedContractScript is Script {
    address immutable WETH9_CONTRACT_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address immutable ANVIL_FIRST_ADDRESS = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    WETH9 _deployedContract;

    function run() external {

        // Accessing to already deployed contract with his address
        _deployedContract = WETH9(WETH9_CONTRACT_ADDRESS);


        _showContractBalance();
        _showBalanceOfGivenAccount(ANVIL_FIRST_ADDRESS);

        _makeDeposit(10 ether);

        _showContractBalance();
        uint accountBalance = _showBalanceOfGivenAccount(ANVIL_FIRST_ADDRESS);

        _withdraw(accountBalance);

        _showContractBalance();
        _showBalanceOfGivenAccount(ANVIL_FIRST_ADDRESS);
    }

    /*
    * @author Julien P.
    * @notice Display in logs the actuel contract's balance
    */
    function _showContractBalance() internal {
        vm.prank(ANVIL_FIRST_ADDRESS);
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
        vm.prank(ANVIL_FIRST_ADDRESS);
        _deployedContract.deposit{value: amount}();
    }

    /*
    * @author Julien P.
    * @notice Shows the given account balance in WETH
    * @return    uint    The given account's balance
    */
    function _showBalanceOfGivenAccount(address accountAddress) internal returns(uint) {
        vm.prank(ANVIL_FIRST_ADDRESS);
        uint accountBalance = _deployedContract.balanceOf(accountAddress);

        console.log(string.concat("Balance of account ", Strings.toHexString(uint256(uint160(accountAddress)), 20), 
            " : ", Strings.toString(accountBalance)));

        return accountBalance;
    }

    /*
    * @author Julien P.
    * @notice Withdraw the given amoung
    * @param    uint    The amount to withdraw
    */
    function _withdraw(uint amount) internal {
        vm.prank(ANVIL_FIRST_ADDRESS);
        _deployedContract.withdraw(amount);
    }
}