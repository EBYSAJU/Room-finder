import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blur/blur.dart';

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
       //  Navigator.pushNamedAndRemoveUntil(
         //    context, '/home', ModalRoute.withName('/home'));
         Navigator.pushNamedAndRemoveUntil(
             context, '/upload', ModalRoute.withName('/upload'));

       }

     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        final snackBar= SnackBar(
           content: Text('No user found for that email',textAlign: TextAlign.center,),
           duration: Duration(seconds: 5,microseconds: 2000),

         );
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
       } else if (e.code == 'wrong-password') {
         //print('Wrong password provided for that user.');
         final snackBar= SnackBar(
           content: Text('wrong-password',textAlign: TextAlign.center,),
           duration: Duration(seconds: 5,microseconds: 2000),

         );
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
       }
       else{
         final snackBar= SnackBar(
           content: Text('Please check the login credentials',textAlign: TextAlign.center,),
           duration: Duration(seconds: 5,microseconds: 2000),

         );
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
          image: AssetImage("assets/images/bcimage.jpg"),
          fit: BoxFit.cover
        )

      ),

      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,


                  children: [
                    Center(
                      child: Container(

                        width: MediaQuery.of(context).size.width/1.5,
                        height: MediaQuery.of(context).size.height * 0.10,
                        color: Colors.white54,
                        child: TextField(

                            style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder( borderRadius: BorderRadius.zero,),
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
                      width: MediaQuery.of(context).size.width/1.5,
                      height: MediaQuery.of(context).size.height * 0.10,
                      color: Colors.white54,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.zero, ),
                          hintText: 'Password ',
                          prefixIcon: Icon(Icons.password),
                        ),
                        obscureText: true,

                        onChanged: (input)=>_password=input,
                      ),

                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,

                        child: TextButton(
                     child: Text('LOGIN'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
                          child: Text('Create an account?'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Colors.black.withOpacity(0.20);
                                if (states.contains(MaterialState.focused) ||
                                    states.contains(MaterialState.pressed))
                                  return Colors.black.withOpacity(0.60);
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
        ),
      ),
    )
  );
        }




        }


