import './App.css';
import {BrowserRouter, Route, Routes} from "react-router-dom";
import MainLayout from "./MainLayout";
import UserJoin from "./UserJoin";
import UserLogin from "./UserLogin";
import Writing from "./Writing";
import Home from "./Home";

function App() {
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path={"/"} element={<MainLayout/>}>
            <Route index element={<Home/>}/>
            <Route path={"/user-join"} element={<UserJoin/>}/>
            <Route path={"/user-login"} element={<UserLogin/>}/>
            <Route path={"/writing"} element={<Writing/>}/>
          </Route>
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
