import 'package:flutter/material.dart';
import 'package:flutter_dev_test/components/comment_widget.dart';

import '../API MOCK DATA/comments.dart';
import '../API MOCK DATA/user.dart';
import '../components/comment_input_widget.dart';

void ShowModalBottomSheet(
    BuildContext context, List<Comment> comments, User user) {
  final TextEditingController replyController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35))),
    builder: (BuildContext modalContext) {
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.85,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              // height: MediaQuery.of(context).size.height * 0.85,
              width: double.infinity,
              // decoration: const BoxDecoration(
              // border: Border(
              //   bottom: BorderSide(color: Colors.red),
              // ),
              // ),
              alignment: Alignment.center,
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(10.0), // Adjust the radius as needed
                      bottomRight:
                          Radius.circular(10.0), // Adjust the radius as needed
                    ),
                    color: Color(0xFF5F6368),
                  ),
                  child: Text(
                    "${comments.length} Comments",
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return CommentWidget(
                    key: Key("$index"),
                    comment: comments[index],
                    userPhoto: user.userPhoto,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 25,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
                border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
              ),
              child: CommentInputWidget(
                  userPhoto: user.userPhoto, inputController: replyController),
            ),
          ],
        ),
      );
    },
  );
}
