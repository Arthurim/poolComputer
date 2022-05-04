pragma solidity ^0.8.0;

abstract contract CurvePoolInterface {
    function getPoolInformations() virtual public view returns (
        // the number of tokens in the pool, for now we assume it is equal to 2
        uint8 nTokens,
        // the address of each token in the pool, this is expected to be of length nTokens
        address[] memory tokenAddresses,
        // the amount of each token in the pool, this is expected to be of length nTokens
        uint256[] memory balances,
        // the constant invariant
        uint256 k,
        // the amplification factor
        uint256 A
        
    );
}

contract PriceAndSlippageComputerContract {

    CurvePoolInterface curvePoolContract;
    function setCurvePoolContractAddress(address _address) external {
        curvePoolContract = CurvePoolInterface(_address);
    }

    function computePriceOfx() public returns(uint) {
        uint8 nTokens;
        address[] memory tokenAddresses;
        uint256[] memory balances;
        uint256 k;
        uint256 A;
        (nTokens, tokenAddresses, balances, k, A) = curvePoolContract.getPoolInformations();
        require(nTokens == 2);
        return computePriceOfx(balances[0], balances[1], k, A);
    }

    function computePriceOfx(uint x, uint y, uint k, uint A) public view returns(uint) {
        return ((k/2)**2 / x) * (1 + (2*A*x*x*y)/(k/2)**3);
    }


    function computePriceOfy(uint x, uint y, uint k, uint A) public view returns(uint) {
        return computePriceOfx(y, x, k, A);
    }

    function computeSlippage(uint x, uint y) public returns(uint) {
        return 0;
    }
}