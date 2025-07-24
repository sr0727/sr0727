import './App.css';
import Login from "./Login";
import TestConponent from "./TestConponent";
import {BrowserRouter, Route, Routes} from "react-router-dom";
function App() {
  return(
      <>
        <BrowserRouter>
          <Routes>
            <Route path={"/"} element={<Login/>}></Route>
            <Route path={"/test"} element={<TestConponent/>}></Route>
          </Routes>
        </BrowserRouter>
      </>
  );
}


export default App;
