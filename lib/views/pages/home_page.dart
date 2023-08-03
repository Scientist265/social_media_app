import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/devWorld_post.dart';
import 'package:social_media_app/components/drawer.dart';
import 'package:social_media_app/components/widgets/custom_text_fielld.dart';
import 'package:social_media_app/views/pages/profile_page.dart';

import '../../components/constants/styling.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currUser = FirebaseAuth.instance.currentUser;
  final user = FirebaseAuth.instance.currentUser!;
  final _textController = TextEditingController();

// Message method
  void postMessage() {
    //only post if there is value in Textfield
    if (_textController.text.isNotEmpty) {
      //store in firestore
      FirebaseFirestore.instance.collection('Users post').add({
        'UserEmail': user.email,
        'Message': _textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }
    // clear the Textfield once post
    setState(() {
      _textController.clear();
    });
  }

  // navigate to profile page
  void goToProfilePage() {
    //pop drawer first
    Navigator.pop(context);
    // now do the navigation
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  // sign user out
  void signUserOut() async {
    Navigator.pop(context);
    FirebaseAuth.instance.signOut;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Text(
            'DevWorld',
            style: Styles.headLine,
          ),
        ),
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOutTap: signUserOut,
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: [
              //DevWorld
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users post')
                          .orderBy('TimeStamp', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final posts = snapshot.data!.docs[index];
                                return DevWorldPost(
                                    message: posts['Message'],
                                    time: posts['TimeStamp'].toString(),
                                    user: posts['UserEmail'],
                                    postId: posts.id,
                                    whoLiked:
                                        List<String>.from(posts['Likes']));
                              });
                        } else {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('${snapshot.error}'),
                            );
                          }
                        }
                        return const Center(child: CircularProgressIndicator());
                      })),
              // Post message
              Row(
                children: [
                  const Expanded(
                      child:
                          CustomTextField(hintText: 'Write something here...')),
                  IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.send))
                ],
              ),

              // grabUser
              // Text(
              //   '${user.email}',
              //   style: const TextStyle(fontSize: 16, color: Colors.grey),
              // )
            ],
          ),
        ),
      )),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Text('User'),
            Spacer(),
            Icon(Icons.barcode_reader),
            Icon(Icons.favorite_border_outlined),
            Icon(Icons.notifications)
          ],
        ),
      ),
    );
  }
}
