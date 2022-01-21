import './App.css';
import { useWeb3React } from "@web3-react/core";
import { injected, network } from "./wallet/Connector";

import logo from './logo.svg';
import './App.css';

function App() {
  const { active, account, library, activate, deactivate } = useWeb3React()

  async function connect() {
    try {
      await activate(injected);
    } catch (ex) {
      console.log(ex)
    }
  }


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
      <br />
      {active ?
        <h2> Wallet Connected</h2>
        : <button onClick={connect}>Connect wallet</button> }
    </div>
  );
}

export default App;
