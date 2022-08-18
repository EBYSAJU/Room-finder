import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => new _RegisterState();

}

class _RegisterState extends State<RegisterPage>{
  var size,height,width;
  late String _email,_password;
  void signup() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      ).then((value) {
        FirebaseFirestore.instance.collection('userData').doc(value.user?.uid).set({"email":value.user?.email});
        Navigator.pushNamedAndRemoveUntil(
            context, '/upload', ModalRoute.withName('/upload'));
      });
      if(credential!=null){
        // print("hello");
        Navigator.pushNamedAndRemoveUntil(
            context, '/upload', ModalRoute.withName('/upload'));

      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       // print('The password provided is too weak.');

        final snackBar= SnackBar(
          content: Text('The password provided is too weak',textAlign: TextAlign.center,),
          duration: Duration(seconds: 5,microseconds: 2000),

        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
       // print('The account already exists for that email.');

        final snackBar= SnackBar(
          content: Text('The account already exists for that email',textAlign: TextAlign.center,),
          duration: Duration(seconds: 5,microseconds: 2000),

        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    }catch(e){
      print(e);
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
                  image: AssetImage("assets/images/registerbackground.jpg"),
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
                        child: Text('Register'),
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
                          signup();

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


