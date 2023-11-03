import './App.css';
import { VatomIdentitySDK } from "@vatom/identity-sdk"
import { VatomWallet } from "@vatom/wallet-sdk"

import { useEffect, useRef, useState } from 'react';

function App() {
  const divRef = useRef(null)
  const clientId = "94JHkdj8jF83jfFF2LI8Q4"
  const identitySdk = new VatomIdentitySDK(clientId, { loginCallbackUri: '/callback', logoutCallbackUri: '/logout-callback', authority: 'https://id.vatom.com', businessId: '' })
  const [accessToken, setAccessToken] = useState(identitySdk.getAccessToken())

  useEffect(() => {
    const triggerCallback = async () => {
      const res = await identitySdk.onCallbacks()
      if (res) {
        setAccessToken(identitySdk.getAccessToken())
      }
    }
    triggerCallback()
  }, [])


  useEffect(() => {
    if (divRef.current && accessToken) {
      new VatomWallet(divRef.current, accessToken.access_token, '', 
      {
        baseUrl: 'https://wallet.vatominc.com/',

        hideTokenActions: true,
        scanner: {
          enabled: false
        }
        // pageConfig: {
        //   theme: {
        //     iconTitle: {
        //       textAlign: 'left',
        //       color: '#F8F9FA'
        //     },
        //     icon: {
        //       backgroundColor: '#111111',
        //       border: '1px solid #3F4A55',
        //       color: '#F8F9FA'
        //     },
        //     main: {},
        //     emptyState: {},
        //     mode: 'dark',
        //     pageTheme: 'dark'
        //   }
        // }
      })
    }
  }, [divRef, accessToken])

  return (
    <div className="App">
      {!accessToken ? (
        <button onClick={identitySdk.login}>Login</button>
      ) : (
        <span>Logged In: </span>
      )}
      {accessToken && <button onClick={identitySdk.logout}>Logout</button>}

      <div className="App" ref={divRef}>

      </div>
    </div>
  );
}

export default App;