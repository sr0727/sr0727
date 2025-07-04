import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:loginjwt/token.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int leftDice=1;
  int rightDice=1;
  bool admin = false;
  String? errorMessage=null;

  Future<void> adminRequest() async{
    Token provider = context.read<Token>();

    final url = Uri.parse("http://10.0.2.2:8080/admin");
    final headers = {"authorization": provider.accessToken};
    try{
      final response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        admin=true;
      }else if(response.statusCode == 403){
        errorMessage = utf8.decode(response.bodyBytes);
      }else if(response.statusCode == 456){
        await accessTokenRequest();
        await adminRequest();
      }
    }catch(e){
      print("Error: ${e}");
    }
  }

  Future<void> accessTokenRequest() async{
    Token provider = context.read<Token>();

    print("액세트 토큰 재발급 요청");
    final url = Uri.parse('http://10.0.2.2:8080/reissue');
    final headers={ 'Cookie': provider.refreshToken};

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        final access=response.headers["authorization"];
        provider.accessToken=access!;

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e}');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
          title: Text("Dice Game")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Image.asset("images/dice${leftDice}.png",
                        width: 300,)
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Image.asset("images/dice${rightDice}.png",
                        width: 300,)
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () async{
                  await adminRequest();
                  if(admin){
                    setState(() {
                      leftDice =  Random().nextInt(6) + 1;
                      rightDice = Random().nextInt(6) + 1;
                    });
                  }else{
                    showToast(errorMessage!);
                  }
                },
                child: Icon(Icons.play_arrow,
                    color: Colors.white,
                    size: 50,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent
                ),)
          ],
        ),
      ),
    );
  }

  void showToast(String message){
    Fluttertoast.showToast(msg: message,
      fontSize: 25,
      backgroundColor: Colors.white,
      textColor: Colors.orangeAccent,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM);
  }
}
