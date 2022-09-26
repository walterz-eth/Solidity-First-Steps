(async () => {
    let acc = await web3.eth.getAccounts();
    console.log(acc);

    console.log("acc [0]: ", acc[0]);

    // replace with address of deployed contract
    const address = "0xd9145CCE52D386f254917e481eB44e9943F39138";

    // replace with abi contents after compiling contract
    const abiArray = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_value",
				"type": "uint256"
			}
		],
		"name": "setMyUint",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "myUint",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];

    let contract = new web3.eth.Contract (abiArray, address);

    console.log (await contract.methods.myUint().call());

    let txResult = await contract.methods.setMyUint(200).send({from: acc[0]})
    
    console.log (await contract.methods.myUint().call());
    console.log ("Transaction mined: " + txResult.status);
    console.log ("Transaction block: " + txResult.blockNumber);

})();