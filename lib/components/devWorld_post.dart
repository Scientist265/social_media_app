import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';
import 'package:social_media_app/components/constants/sizing.dart';
import 'package:social_media_app/components/like_button.dart';

class DevWorldPost extends StatefulWidget {
  const DevWorldPost(
      {super.key,
      required this.message,
      required this.user,
      required this.time,
      required this.postId,
      required this.whoLiked});
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> whoLiked;

  @override
  State<DevWorldPost> createState() => _DevWorldPostState();
}

class _DevWorldPostState extends State<DevWorldPost> {
  // get Like
  final currUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.whoLiked.contains(currUser.email);
  }

  //toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Users post').doc(widget.postId);
    if (isLiked) {
      //if post is liked , add user's email to the 'whoLikes' field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currUser.email]),
      });
    } else {
      //if post is not liked , remove from "wholikes "field
      postRef.update({
        'Likes': FieldValue.arrayRemove([currUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                color: AppColors.textFieldBorder,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
          AppSizing.h10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.user,
                style: const TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  LikeButton(
                      isLiked: isLiked,
                      onTap: () {
                        toggleLike();
                      }),
                  Text(widget.whoLiked.length.toString())
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
