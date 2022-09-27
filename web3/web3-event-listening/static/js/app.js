const enableMetaMaskButton = document.querySelector('.enableMetamask');
const statusText = document.querySelector('.statusText');
const listenToEventsButton = document.querySelector('.startStopEventListener');
const getEventsButton = document.querySelector('.getEventsButton');
const contractAddr = document.querySelector('#address');
const contractAbi = document.querySelector('#abi');
const eventResult = document.querySelector('.eventResult');

enableMetaMaskButton.addEventListener('click', () => {
  enableDapp();
});
listenToEventsButton.addEventListener('click', () => {
  listenToEvents();
});
getEventsButton.addEventListener('click', () => {
  getEvents();
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
  
  // LISTEN for events
  contractInstance.events.ChangeEvent().on("data", (event) => {
  	eventResult.innerHTML = "NEW EVENT data received: " + "<br/>" + JSON.stringify(event) + "<br />=====<br />" + eventResult.innerHTML;
  });
}

async function getEvents() {
  
  let abi = JSON.parse(contractAbi.value);
  let contractInstance = new web3.eth.Contract(abi, contractAddr.value);
  
  // Now, let's QUERY events:
  contractInstance.getPastEvents("ChangeEvent", {fromBlock: 0}).then((event) => {
  	eventResult.innerHTML = "QUERIED EVENT data received: " + "<br/>" + JSON.stringify(event) + "<br />=====<br />" + eventResult.innerHTML;
  });
  // Now, let's FILTER by topic (arguments marked as 'indexed'):
  contractInstance.getPastEvents("ChangeEvent", {filter:{_value: false}, fromBlock: 0}).then((event) => {
  	eventResult.innerHTML = "FILTERED EVENT data received: " + "<br/>" + JSON.stringify(event) + "<br />=====<br />" + eventResult.innerHTML;
  });
}
