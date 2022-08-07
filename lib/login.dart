import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();

}

class _LoginState extends State<LoginPage>{
  var size,height,width;
   late String _email,_password;
   void signin() async {
     try {
       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: _email,
           password: _password
       );
       if(credential!=null){
       // print("hello");
         Navigator.pushNamedAndRemoveUntil(
             context, '/home', ModalRoute.withName('/home'));

       }

     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         print('No user found for that email.');
       } else if (e.code == 'wrong-password') {
         print('Wrong password provided for that user.');
       }
     }
   }

  @override
  Widget build(BuildContext context) {
     size=MediaQuery.of(context).size;
     height=size.height;
     width=size.width;
  return Scaffold(
    body:Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,


              children: [
                Center(
                  child: Container(

                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height * 0.15,
                    color: Colors.greenAccent,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username ',
                        prefixIcon: Icon(Icons.account_box),
                      ),
                      onChanged: (input){
                        _email=input;
                      }

                    ),

                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height * 0.10,
                  color: Colors.greenAccent,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password ',
                      prefixIcon: Icon(Icons.password),
                    ),
                    obscureText: true,

                    onChanged: (input)=>_password=input,
                  ),

                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,

                    child: TextButton(
                 child: Text('LOGIN'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.20);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.60);
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
        onPressed: ()  {
            signin();

        }),
        ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: TextButton(
                      child: Text('Create an account'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.blue.withOpacity(0.20);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.blue.withOpacity(0.60);
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: ()  {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signup', ModalRoute.withName('/signup'));

                      }),
                ),

              ],
            ),
    )
  );
        }




        }


