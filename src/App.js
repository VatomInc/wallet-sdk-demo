import './App.css';
import { VatomWallet } from "@vatom/wallet-sdk"
import { useEffect, useRef } from 'react';


function App() {
  const divRef = useRef(null)

  const accessToken = ""
  const businessId = ""

  useEffect(() => {
    if(divRef.current){
      new VatomWallet(divRef.current, accessToken, businessId)
    }
  }, [divRef])

  return (
    <div className="App" ref={divRef}>

    </div>
  );
}

export default App;
