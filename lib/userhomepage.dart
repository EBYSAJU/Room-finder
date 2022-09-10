import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class userHomePage extends StatefulWidget
{

  @override
  _userHomeState createState()=> new _userHomeState();

}
class _userHomeState extends State<userHomePage>{
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
   String username='';
   void initState()
   {
     super.initState();
     getusername();
     Reference storageReference = FirebaseStorage.instance.ref().child("userData");
     if (FirebaseAuth.instance.currentUser != null) {
       print(FirebaseAuth.instance.currentUser?.uid);
      final snapshot= FirebaseFirestore.instance.collection("userData").doc(FirebaseAuth.instance.currentUser?.uid).get();
       print(snapshot);
     }

   }


  void getusername() async
  {
setState(() {
  username=FirebaseAuth.instance.currentUser!.email!;
});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace:  FlexibleSpaceBar(

              title: Text('$username'),
              background:Image.network("https://firebasestorage.googleapis.com/v0/b/room-sharing-4a199.appspot.com/o/test%2Faae17286-059a-4e63-8c32-51894be3e8a4%7D?alt=media&token=65745a5b-f823-4dab-a6d3-148d17f6b3c0",
              fit: BoxFit.cover,),
            ),




          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                   Text('$username'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
