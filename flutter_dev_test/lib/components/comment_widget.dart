import 'package:flutter/material.dart';
import 'package:flutter_dev_test/API%20MOCK%20DATA/comments.dart';

import '../pages/reply.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final bool replies;
  final String userPhoto;

  const CommentWidget(
      {super.key,
      required this.comment,
      this.replies = false,
      required this.userPhoto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(comment.user.userPhoto),
      ),
      title: Container(
        margin:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Text("@${comment.user.username}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    overflow: TextOverflow.clip,
                  )),
            ),
            Spacer(flex: 6),
            Text(
              '${comment.timeCommented.hour}:${comment.timeCommented.minute}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.content),
          !replies
              ? Row(
                  children: [
                    IconButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/comment.png'),
                        color: Colors.grey,
                      ),
                      onPressed: replies
                          ? null
                          : () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ReplyPage(
                              //       comment: comment,
                              //       user: comment,
                              //     ),
                              //   ),
                              // );
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      ReplyPage(
                                    comment: comment,
                                    userPhoto: userPhoto,
                                  ),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                          opacity: animation, child: child),
                                ),
                              );
                            },
                    ),
                    Text(comment.replies.length.toString()),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/favorite.png'),
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                    Text(comment.likes.toString()),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/flag.png'),
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              : SizedBox(height: 15),
          replies
              ? Row(children: [
                  Text("Replying to ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  InkWell(
                      onTap: () {},
                      child: Text("John Doe @JohntheD",
                          style: TextStyle(color: Color(0xFFFFBB00))))
                ])
              : const SizedBox(),

          comment.replies.length > 0 && !replies
              ? InkWell(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View ${comment.replies.length} replies',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF959595),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                size: 25, color: Color(0xFF959595)),
                          ])),
                )
              : const SizedBox(),

          const SizedBox(height: 10),
          // const SizedBox(height: 5),
          // Text(
          //   '${comment.shares} shares',
          //   style: const TextStyle(fontSize: 12),
          // ),
        ],
      ),
    );
  }
}
