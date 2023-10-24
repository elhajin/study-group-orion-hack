//SPDX-License-Identifier: MIT
pragma solidity  ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {ERC20} from "contracts/token/ERC20/ERC20.sol";
interface OrionPoolV2Factory {
    function createPair(address tokenA, address tokenB) external;
    function getPair(address tokenA, address tokenB) external view returns(address);
}
interface ORION {
    function swapThroughOrionPool(
        uint112 amount_spend,
        uint112 amount_receive,
        address[] calldata path,
        bool is_exact_spend
    ) external;
    function depositAsset(address assetAddress, uint112 amount) external;
    function getBalance(address assetAddress, address user) external view returns (int192);
    function withdraw(address assetAddress, uint112 amount) external;
}
interface Uni_Pair_V2 {
    function swap(uint256 amount0Out, uint256 amount1Out, address to, bytes memory data) external;
      function mint(address to) external returns (uint256 liquidity);
}
contract OrionHack is Test {
    // get the orion contract : 
    ORION orion = ORION(0xb5599f568D3f3e6113B286d010d2BCa40A7745AA);
    // get the orion factory contract for create pool for our token and usdt and usdc  : 
    OrionPoolV2Factory factory = OrionPoolV2Factory(0x5FA0060FcfEa35B31F7A5f6025F0fF399b98Edf1);
    // get the uniswap v2 pair : weth/usdt < to take the falshloan from it . 
    Uni_Pair_V2 pool = Uni_Pair_V2(0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852);
    // get the usdc and usdt tokens : 
    ERC20 usdt = ERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    ERC20 usdc = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    // amount of flashloan : 
    uint flashLoanAmount;
    //  get the hacker token contract : 
    Token token ;
    function setUp() public {
        // create fork : in the block number : 16_542_147
        string memory mainnet = vm.envString("mainnet");
        uint fork = vm.createFork(mainnet,16542147);
        vm.selectFork(fork);
         // give usdc and usdt to this contract : 
        deal(address(usdt),address(this),10e6);
        deal(address(usdc),address(this),10e6);
        // deploy the token contract : 
        token = new Token(address(this));
        // create pool for token|usdt
        factory.createPair(address(token),address(usdt));
        // // create pool for token|usdc
        factory.createPair(address(token),address(usdc));
        // // add liquidity for swap :
        address pool1 = factory.getPair(address(token),address(usdt));
        address pool2 = factory.getPair(address(token),address(usdc));
        address(usdt).call(abi.encodeWithSignature("transfer(address,uint256)",address(pool1),10e6));
        token.transfer(pool1,4 ether);
        usdc.transfer(pool2,1e6);
        token.transfer(pool2,4 ether);
        // mint liquidity : 
        Uni_Pair_V2(pool1).mint(address(this));
        Uni_Pair_V2(pool2).mint(address(this));
        // vm labes : 
        vm.label(address(token),"token");
        vm.label(address(usdt),"usdt");
        vm.label(address(usdc),"usdc");

    }
    function test_exploitOrion() public {
        //write your test here ...
        /////////////////
        /////////



    }

}

// the token that the hacker will create : 
contract Token is ERC20("token","t"){
   // implement the test token here ....

   constructor(address a) {}
}