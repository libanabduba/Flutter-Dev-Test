import 'package:flutter/material.dart';
import 'package:flutter_dev_test/components/appbar.dart';

import '../API MOCK DATA/comments.dart';
import '../components/comment_input_widget.dart';
import '../components/comment_widget.dart';

class ReplyPage extends StatelessWidget {
  final Comment comment;
  final String userPhoto;

  final TextEditingController _replyController = TextEditingController();

  ReplyPage({super.key, required this.comment, required this.userPhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppbar,
        body: Container(
            color: Colors.white,
            child: Column(children: [
              secondAppbar(context, "Reply"),
              SizedBox(height: 25),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    CommentWidget(
                      comment: comment,
                      replies: true,
                      userPhoto: userPhoto,
                    ),
                    SizedBox(height: 10),
                    CommentInputWidget(
                        userPhoto: userPhoto,
                        inputController: _replyController,
                        replies: true),
                  ]))
            ])));
  }
}
