import React from 'react';
import TopNav from './TopNav';
import ItemBody from './ItemBody'

function App() {
  return (
    <div>
      <TopNav/>
      <div className="container">
        <ItemBody/>
      </div>
    </div>
    
  )
}

export default App;
