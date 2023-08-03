import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/constants/colors.dart';
import 'package:social_media_app/components/post_related/like_button.dart';

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
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.fillColor,
                borderRadius: currUser == true
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))
                    : const BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
            child: Text(
              widget.message,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[300]),
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
