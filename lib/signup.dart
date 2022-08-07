import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupState createState() => new _SignupState();

}

class _SignupState extends State<SignupPage>{
  late String _email,_password;
  void signup() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      );
      if(credential!=null){
        // print("hello");
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));

      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }catch(e){
      print(e);
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
                      child: Text('register'),
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
                        signup();

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
                        child: Text('register'),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/signup', ModalRoute.withName('/signup'));
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

