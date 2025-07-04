import 'package:flutter/material.dart';
import 'package:loginjwt/dice.dart';
import 'package:loginjwt/userinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';
import './token.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context)=>Token(),
        child: const MyApp(),)
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? username=null;
  String? password=null;

  bool tryValidation(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      return true;
    }
    return false;
  }

  Future<bool> loginRequest() async{
    Token  provier = context.read<Token>();

    final url = Uri.parse("http://10.0.2.2:8080/login");
    UserInfo user = UserInfo(username: username!, password: password!);
    // final headers={"Content-Type" : "application/json"};
    final headers={"Content-Type" : "application/x-www-form-urlencoded"};
    final body = user.toJson();

    try{
      final response = await http.post(url, body: body );

      if(response.statusCode == 200){
        final token = response.headers['authorization'];
        final refreshToken=  response.headers['set-cookie'];
        provier.accessToken = token!;
        provier.refreshToken = refreshToken!;
        return true;
      }else if(response.statusCode == 401){
        final msg = json.decode(utf8.decode(response.bodyBytes));
        showSnackBar(context, msg['error']);
      }else{
        showSnackBar(context, "Error:${response.statusCode}");
      }
    }catch(e){
      print("Error: ${e}");
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Builder(
        builder: (context){ //
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
              //FocusScope.of(context) :  위쪽(조상 위젯 트리) 에서 가장 가까운 FocusScope를 리턴
              // FocusScopeNode : 현재 위젯 트리(context 기준)에서 가장 가까운 FocusScope에 대한 정보를 담고 있는 객체로
              // 포커스 상태를 관리할 수 있는 기능들을 제공
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            key: ValueKey(1),
                            validator: (value){
                              if(value!.isEmpty){
                                return "input username!!";
                              }
                              return null;
                            },
                            onSaved: (value){
                              username = value!;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: "username",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: ValueKey(2),
                            validator: (value){
                              if(value!.isEmpty){
                                return "input password!!";
                              }
                              return null;
                            },
                            onSaved: (value){
                              password = value!;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: "password",
                                contentPadding: EdgeInsets.all(10)
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if(tryValidation()){
                                loginRequest().then((data){
                                  if(data){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder:(context)=> Dice() ));
                                  }
                                });

                              }else{
                                showSnackBar(context, "올바른 계정정보를 입력하세요");
                              }
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}






void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(message,
           textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
    )
  );
}

