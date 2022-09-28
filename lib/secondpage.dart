import 'package:fireandlogin/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class secondpage extends StatefulWidget {
  const secondpage({Key? key}) : super(key: key);

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Name",
                labelText: "Name"),
          ),
          TextField(
            controller: password,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
                labelText: "Password"),
          ),
          ElevatedButton(onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: name.text,
                password: password.text,
              ).then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return firstpage();
                },));
              });
            } on FirebaseAuthException catch (e) {
              if (e.code == Fluttertoast.showToast(
                  msg: "Weak Password",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              )) {
                Fluttertoast.showToast(
                    msg: "Your Password Is Very Weak",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              } else if (e.code == 'email-already-in-use') {
                Fluttertoast.showToast(
                    msg: "Your Password Is Very Weak",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            } catch (e) {
              print(e);
            }
          }, child: Text("Save"))
        ],
      ),
    );
  }
}
