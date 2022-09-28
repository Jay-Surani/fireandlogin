import 'package:fireandlogin/homepage.dart';
import 'package:fireandlogin/secondpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MaterialApp(
    home: firstpage(),
  ));
}

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  TextEditingController lname = TextEditingController();
  TextEditingController lpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: lname,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Name",
                labelText: "Name"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: lpassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
                labelText: "Password"),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: lname.text,
                  password: lpassword.text
              ).then((value){
                 Navigator.push(context,MaterialPageRoute(builder: (context) {
                   return homepage();
                 },));
              });
            } on FirebaseAuthException catch (e) {
              if (e.code ==  Fluttertoast.showToast(
                  msg: "User Not Found",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0)) {

              } else if (e.code == Fluttertoast.showToast(
                  msg: "Wrong Password",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0)) {

              }
            }
          }, child: Text("Login")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return secondpage();
                  },
                ));
              },
              child: Text("Sing Up"))
        ],
      ),
    );
  }
}
