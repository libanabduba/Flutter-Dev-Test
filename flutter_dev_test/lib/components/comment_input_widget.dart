import 'package:flutter/material.dart';

import '../pages/emojiSearch.dart';

class CommentInputWidget extends StatelessWidget {
  final String userPhoto;
  final TextEditingController inputController;
  final replies;

  const CommentInputWidget(
      {super.key,
      required this.userPhoto,
      required this.inputController,
      this.replies = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userPhoto),
      ),
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Row(
          children: [
            IconButton(
              icon: const ImageIcon(
                AssetImage(
                  'assets/icons/smile.png',
                ),
                size: 20,
                color: Color.fromARGB(255, 28, 29, 31),
              ),
              onPressed: () async {
                // String emoji = await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const EmojiSearchPage(),
                //   ),
                // );
                String emoji = await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                EmojiSearchPage(
                                    title: replies ? "Reply" : "Comment"),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ) ??
                    "";

                inputController.text = inputController.text + emoji;
              },
            ),
            Expanded(
              child: TextField(
                controller: inputController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: 'Add a comment',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: () {},
            ),
          ],
        ),
      ),
      // trailing: IconButton(
      //   icon: const ImageIcon(
      //     AssetImage('assets/icons/send.png'),
      //     color: Colors.blue,
      //   ),
      //   onPressed: () {},
      // ),
    );
  }
}
