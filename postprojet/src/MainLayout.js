import {Link, Outlet} from "react-router-dom";

export default function MainLayout(){
    return(
        <>
            <h1>게시판</h1>
            <Link to={"/"}>홈</Link>
            {" | "}
            <Link to={"/user-join"}>회원 가입</Link>
            {" | "}
            <Link to={"/user-login"}>로그인 </Link>
            {" | "}
            <Link to={"/writing"}>글쓰기</Link>

            <Outlet/>
        </>
    )
}