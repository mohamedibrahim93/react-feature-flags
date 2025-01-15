import logo from "./logo.svg";
import "./App.css";
import DisplayJson from "./DisplayJson";
import { getEnv } from './env';

function App() {
  console.log(process.env);
  console.log(window._env_);
  console.log(getEnv("REACT_APP_API_URL"));

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <div style={{width:'75%'}}>
          <DisplayJson title={'process'} jsonData={process.env} />
        </div>
        <div style={{width:'75%'}}>
          <DisplayJson title={'window'} jsonData={window._env_} />
        </div>
      </header>
    </div>
  );
}

export default App;
