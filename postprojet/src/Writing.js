import {useDispatch} from "react-redux";
import {addPostInfo} from "./store";
import {useRef} from "react";
import {useNavigate} from "react-router-dom";

export default function Writing(){
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const nextId = useRef(6);

    const handleWriting = (e)=>{
        e.preventDefault();
        dispatch(
            addPostInfo({
                id:nextId.current,
                title: e.target.title.value,
                content: e.target.body.value
            })
        );
        nextId.current++;
        navigate("/");
    }
    return(
        <>
            <form onSubmit={handleWriting}>
                <p>제목 : <input type={"text"} name={"title"} /></p>
                <p><textarea name={"body"} rows="20" cols="40"></textarea></p>
                <input type={"button"} value="수정"  onClick={(e)=>{

                }}/>
                <input type={"button"} value="삭제" onClick={(e)=>{

                }}/>
            </form>
        </>
    )
}