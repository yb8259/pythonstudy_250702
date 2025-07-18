import React, { useState } from "react";
import Viewer from "./Viewer";
import Controller from "./Controller";
import "./App.css";

const App = () => {
  const [count, setCount] = useState(0);
  return (
    <div className="App">
      <h1>Simple Counter</h1>
      <section>
        <Viewer count={count} />
      </section>
      <section>
        <Controller />
      </section>
    </div>
  );
};

export default App;
