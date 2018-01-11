// Import the page's CSS. Webpack will know what to do with it.
import "./style.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

/*
 * When you compile and deploy your Voting contract,
 * truffle stores the abi and deployed address in a json
 * file in the build directory. We will use this information
 * to setup a Voting abstraction. We will use this abstraction
 * later to create an instance of the Voting contract.
 * Compare this against the index.js from our previous tutorial to see the difference
 * https://gist.github.com/maheshmurthy/f6e96d6b3fff4cd4fa7f892de8a1a1b4#file-index-js
 */

import voting_artifacts from '../build/contracts/SongComposition.json'

var Music = contract(voting_artifacts);
var notes = null;

if (typeof web3 !== 'undefined') {
  console.warn("Using web3 detected from external source like Metamask")
  // Use Mist/MetaMask's provider
  window.web3 = new Web3(web3.currentProvider);
}

Music.setProvider(web3.currentProvider);
Music.deployed().then(function(contractInstance) {
  contractInstance.song.call().then(function(v) {
    notes = v;
    console.log(notes);
  })
});