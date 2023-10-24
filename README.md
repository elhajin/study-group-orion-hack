**_if you wanna Reapplicate the hack your self, clone the repo with `starting` branch_**

## Reference you need :

**uniswap v2 usdt/weth pool** : 0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852 </br>
**orion address** : 0xb5599f568D3f3e6113B286d010d2BCa40A7745AA</br>
**orion factory** : 0x5FA0060FcfEa35B31F7A5f6025F0fF399b98Edf1</br>
**usdt**: 0xdAC17F958D2ee523a2206206994597C13D831ec7</br>
**usdc**: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48</br>
**block to be forked**: 16_542_147</br>

## real hack refference :

**tx** : 0xa6f63fcb6bec8818864d96a5b1bb19e8bd85ee37b2cc916412e720988440b2aa

### intefaces :

```solidity
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
```

## run tests :

- clone this repo :

```sh
    git clone git@github.com:elhajin/study-group.git
```

- Install dependency:

```sh
 yarn install
 forge install
```

- run tests :

```sh
    forge test -vvv
```

## notes :

> make sure in to past your **rpcUrl** for ethereum mainnet in `.env` file. see .envExample.
