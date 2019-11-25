import React from 'react';
import logo from './logo.svg';
import './App.css';

import Web3 from 'web3';
var web3; 

function App() {
  setupWeb3();
  web3.eth.getAccounts().then(console.log); 
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

function setupWeb3(){
  //Modern dApp browsers
  if(window.ethereum){
    web3 = new Web3(window.ethereum);
    try{
      window.ethereum.enable().then(function() {

      });

    } catch(e){
      // The user has denied account access to DApp
    }
  } else if (window.web3){
    // Legacy Dapp browsers
    web3 = new Web3(window.web3.currentProvider); 
  } else {
    // Non-Dapp browsers
    alert('You have to install Metamask! '); 
  }
}

export default App;
