import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class userHomePage extends StatefulWidget {
  @override
  _userHomeState createState() => new _userHomeState();
}

class _userHomeState extends State<userHomePage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  String username = '';
  String urlProfile='';


  void initState() {
    super.initState();
    getProfileUrl();
    getusername();
    /*Reference storageReference =
        FirebaseStorage.instance.ref().child("userData");
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      final snapshot = FirebaseFirestore.instance
          .collection("userData")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      print(snapshot);
    }*/





  }


  void getusername() async {
    setState(() {
      username = FirebaseAuth.instance.currentUser!.email!;
    });
  }
  Future<void> getProfileUrl() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    DocumentSnapshot snapshot1 = await FirebaseFirestore.instance
        .collection("images")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    print("imagedata");
    print(snapshot1.data());

    setState(() {
      urlProfile = snapshot.get('profilePhotoUrl');
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
            flexibleSpace: FlexibleSpaceBar(
              title: Text('$username'),
              background: urlProfile.isNotEmpty ? Image.network(
                urlProfile,
                fit: BoxFit.cover,
              ):null

            ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.upload),
                  tooltip: 'Post a new room available',
                  onPressed: () {
                   // Navigator.pushNamedAndRemoveUntil(
                     // context, '/upload', ModalRoute.withName('/upload'));
                    Navigator.pushNamed(context, '/upload');
                  },
                ),
              ]

          ),
          /*TextButton(
              onPressed: (){

          }, child: Text("Upload")),*/
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
