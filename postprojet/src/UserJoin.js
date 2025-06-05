import {useDispatch} from "react-redux";
import {addAuthenInfo} from "./store";
import {useNavigate} from "react-router-dom";

export default function UserJoin(){
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const handleSubmit = (e)=>{
        e.preventDefault();
        dispatch(
            addAuthenInfo({
                username: e.target.username.value,
                password: e.target.password.value,
                fullname: e.target.fullname.value,
            })
        );
        navigate("/");
    }

    return(
        <>
            <form onSubmit={handleSubmit}>
                <label>아이디 : <input type={"text"} name={"username"}  placeholder={"Username"}/></label>
                <br/>
                <label>비밀번호 : <input type={"password"} name={"password"} placeholder={"Password"}/></label>
                <br/>
                <label>이름 : <input type={"text"} name={"fullname"} placeholder={"Fullname"}/></label>
                <br/>
                <button type={"submit"} name={"join"}>가입</button>
            </form>
        </>
    )
}