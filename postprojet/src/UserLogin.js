import {useDispatch, useSelector} from "react-redux";
import {useNavigate} from "react-router-dom";

export default function UserLogin(){
    const navigate = useNavigate();
    const dispatch=useDispatch();
    const select = useSelector(state => state.post.authenInfo);


    const handleUserLogin = (e)=>{
        e.preventDefault();
        const data={username:e.target.username.value, password:e.target.password.value};
        const result = select.filter(e=>(e.username === data.username) && (e.password === data.password));
        if(result.length === 0){
            alert("로그인정보가 틀렸습니다.");
            e.target.username.value="";
            e.target.password.value = "";
            return;
        }
        alert("로그인 성공");
        navigate("/");
    }

    return(
        <>
            <form onSubmit={handleUserLogin}>
                <label>아이디 : <input type={"text"} name={"username"}  placeholder={"Username"}/></label>
                <br/>
                <label>비밀번호 : <input type={"password"} name={"password"} placeholder={"Password"}/></label>
                <br/>
                <button type={"submit"} name={"login"}>로그인</button>
            </form>
        </>
    )
}