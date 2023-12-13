// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.18;

// Simple interface for exposing WETH9 contract's methods : https://etherscan.io/token/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#code
interface WETH9 {
    function balanceOf(address accountAddress) external view returns(uint);
    function deposit() external payable;
    function withdraw(uint wad) external;

    function totalSupply() external view returns (uint);

    function approve(address guy, uint wad) external returns (bool);

    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
}