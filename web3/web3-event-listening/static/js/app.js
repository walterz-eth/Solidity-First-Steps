const enableMetaMaskButton = document.querySelector('.enableMetamask');
const statusText = document.querySelector('.statusText');
const listenToEventsButton = document.querySelector('.startStopEventListener');
const contractAddr = document.querySelector('#address');
const contractAbi = document.querySelector('#abi');
const eventResult = document.querySelector('.eventResult');

enableMetaMaskButton.addEventListener('click', () => {
  enableDapp();
});
listenToEventsButton.addEventListener('click', () => {
  listenToEvents();
});

let accounts;
let web3;

async function enableDapp() {

  if (typeof window.ethereum !== 'undefined') {
    try {
      accounts = await ethereum.request({
        method: 'eth_requestAccounts'
      });
      web3 = new Web3(window.ethereum);
      statusText.innerHTML = "Account: " + accounts[0];

      listenToEventsButton.removeAttribute("disabled");
      contractAddr.removeAttribute("disabled");
      contractAbi.removeAttribute("disabled");
    } catch (error) {
      if (error.code === 4001) {
        // EIP-1193 the user rejected the transaction
        statusText.innerHTML = "Error: Need permission to access MetaMAsk";
        console.log('Permissions needed to continue.');
      } else {
        console.error(error.message);
      }
    }
  } else {
    statusText.innerHTML = "Error: Need to install MetaMask";
  }
};


async function listenToEvents() {
  
  let abi = JSON.parse(contractAbi.value);
  
  let contractInstance = new web3.eth.Contract(abi, contractAddr.value);
  contractInstance.events.ChangeEvent().on("data", (event) => {
  	eventResult.innerHTML = JSON.stringify(event) + "<br />=====<br />" + eventResult.innerHTML;
  	
  	console.log ("Transaction mined.");
  });
}
