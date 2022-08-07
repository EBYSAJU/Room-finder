import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();

}

class _LoginState extends State<LoginPage>{
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
  return Scaffold(
    body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints)
      {
        if(constraints.maxWidth>600){
          return Column(

            children: [
              Container(

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
              Container(
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
                  child: TextButton(
               child: Text('LOGIN'),
            style: ButtonStyle(
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

            ],
          );
        }
        else{
          return Center(
            child: Column(
              children: [
                 Container(
                    height: constraints.maxHeight * 0.25,
                    alignment: Alignment.center,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username test mobile ',
                        prefixIcon: Icon(Icons.account_box),
                      ),
                    ),

                  ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password test mobile',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),


                ),
                Container(
                  child: TextButton(
                      child: Text('LOGIN'),
                      style: ButtonStyle(
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
                      onPressed: () {

                      }),
                ),




              ],

            ),

          );

        }

      },

    ),

  );

  }


}

