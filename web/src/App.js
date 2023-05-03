import "./App.css";
import { VatomWallet } from "@vatom/wallet-sdk";
import { useEffect, useRef, useState } from "react";

function App() {
  const divRef = useRef(null);

  const [accessToken, setAccessToken] = useState("");
  const [businessId, setBusinessId] = useState("");

  const [shouldRender, setShouldRender] = useState(false);

  useEffect(() => {
    if (divRef.current && shouldRender) {
      new VatomWallet(divRef.current, accessToken, businessId, {
        baseUrl: "https://wow.vatom.com",
      });
    }
  }, [shouldRender, accessToken, businessId]);

  return (
    <div>
      {!shouldRender ? (
        <>
          <input
            type="text"
            value={accessToken}
            placeholder="access token"
            onChange={(e) => setAccessToken(e.target.value)}
          />
          <input
            type="text"
            value={businessId}
            placeholder="business id"
            onChange={(e) => setBusinessId(e.target.value)}
          />
          <button onClick={() => setShouldRender(true)}>Render!</button>
        </>
      ) : null}
      <div ref={divRef} className="App"></div>
    </div>
  );
}

export default App;
