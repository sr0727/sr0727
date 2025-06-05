import {configureStore, createSlice} from "@reduxjs/toolkit";

const initState ={
    authenInfo:[
        {username : "aaa", password : "1111", fullname:"장세령"},
        {username : "bbb", password : "2222", fullname:"박뚝배기"},
        {username : "ccc", password : "3333", fullname:"김된장국"},
        {username : "ddd", password : "4444", fullname:"이자바"},
        {username : "eee", password : "5555", fullname:"박코딩"}
    ],
    postInfo:[
        {id: 1, username: "aaa", title: "요즘 스트레스 어떻게 푸세요?", content: "일 끝나고 집에만 있으니까 답답하네요. 다들 스트레스 풀기 좋은 방법 있을까요?" },
        {id: 2, username: "bbb", title: "주말에 뭐 할까 고민 중", content: "비도 오고 해서 집에서 뭘 하면 좋을지 추천 좀 해주세요!" },
        {id: 3, username: "ccc", title: "진로 고민이 많아요", content: "앞으로 어떤 일을 해야 할지 잘 모르겠어요. 경험 있으신 분들 조언 부탁드립니다." },
        {id: 4, username: "ddd", title: "새로 산 이어폰 후기", content: "이번에 산 무선 이어폰 음질도 좋고 디자인도 마음에 들어요!" },
        {id: 5, username: "eee", title: "요즘 본 드라마 추천해요", content: "요즘 재미있게 본 드라마나 영화 있으면 공유해 주세요~" },
    ],
}

const postSlice = createSlice({
    name: "post",
    initialState:initState,
    reducers:{
        addAuthenInfo:(state,action)=>{
            state.authenInfo.push(action.payload);//배열정보추가
        },
        addPostInfo:(state, action) =>{
            state.postInfo.push(action.payload);//배열정보추가
        },
        updatePostInfo: (state, action) => {
            state.postInfo = state.postInfo.map(t =>
                t.id === action.payload.id
                    ? action.payload// 기존 데이터 유지 + 덮어쓰기
                    : t
            );
        },
        deletePostInfo:(state, action) =>{
            state.postInfo = state.postInfo.filter(t=>t.id !== Number(action.payload));
        }
    }
});

const store = configureStore({
    reducer:{
        post:postSlice.reducer,
    }
});

export const { addAuthenInfo, addPostInfo, updatePostInfo, deletePostInfo } = postSlice.actions;
export default store;