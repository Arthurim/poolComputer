// Right click on the script name and hit "Run" to execute
(async () => {
    try {
        console.log('Running deployWithWeb3 script...')
        
        var abi = [
	{
		"inputs": [],
		"name": "getPoolInformations",
		"outputs": [
			{
				"internalType": "uint8",
				"name": "nTokens",
				"type": "uint8"
			},
			{
				"internalType": "address[]",
				"name": "tokenAddresses",
				"type": "address[]"
			},
			{
				"internalType": "uint256[]",
				"name": "balances",
				"type": "uint256[]"
			},
			{
				"internalType": "uint256",
				"name": "k",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "A",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
        var PriceAndSlippageComputerContract = web3.eth.contract(abi)
        var contractAddress = /* our contract address on Ethereum after deploying */
        var PriceAndSlippageComputer = PriceAndSlippageComputerContract.at(contractAddress)

        // MIM UST pool
        let curvePoolAddress = "0x55A8a39bc9694714E2874c1ce77aa1E599461E18";
        PriceAndSlippageComputer.setCurvePoolContractAddress(curvePoolAddress);
        let x_price = PriceAndSlippageComputer.computePriceOfx();
        console.log(x_price)
    
    } catch (e) {
        console.log(e.message)
    }
  })()