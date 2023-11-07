import 'package:flutter/material.dart';
import 'package:flutter_dev_test/components/appbar.dart';
import 'package:flutter_dev_test/pages/comments.dart';
import 'package:flutter_dev_test/pages/inbox.dart';
import 'package:flutter_dev_test/pages/plus.dart';
import 'package:flutter_dev_test/pages/profile.dart';
import 'package:flutter_dev_test/pages/search.dart';
import 'package:flutter_dev_test/components/button.dart';
import 'package:flutter_dev_test/components/caption.dart';
import 'package:flutter_dev_test/components/hide_button.dart';

import 'API MOCK DATA/user.dart';
import 'API MOCK DATA/video.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 0);
  final List<Video> video = generateVideoMockData(50);
  final User user = generateUsersMockData(1)[0];

  int _selectedVideoIndex = 0;
  int _selectedPageIndex = 0;
  bool _isBottomNavBarVisible = true;
  bool _isLeftButtonVisible = true;
  bool _isRightButtonVisible = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void _visible() {
    setState(() {
      _isBottomNavBarVisible = !_isBottomNavBarVisible;
      _isLeftButtonVisible = !_isLeftButtonVisible;
      _isRightButtonVisible = !_isRightButtonVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: commonAppbar,
      body: PageView(
        controller: pageController,
        children: [
          homePageView(context),
          const UserSearchPage(),
          const UserInboxPage(),
          const UserPlusPage(),
          const UserProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: Visibility(
        visible: _isBottomNavBarVisible,
        child: BottomNavigationBar(
            backgroundColor: const Color(0xFF2E2E2E),
            unselectedItemColor: Colors.white,
            selectedItemColor: const Color(0xFFFFDD5E),
            currentIndex: _selectedPageIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/apps.png',
                  width: 25, // Adjust the width as needed
                  height: 25, // Adjust the height as needed
                ),
                label: 'Apps',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/qucon.png',
                  width: 25, // Adjust the width as needed
                  height: 25, // Adjust the height as needed
                ),
                label: 'Qucon',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/zaady.png',
                  width: 25, // Adjust the width as needed
                  height: 25, // Adjust the height as needed
                ),
                label: 'Zaady',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/organize.png',
                  width: 25, // Adjust the width as needed
                  height: 25, // Adjust the height as needed
                ),
                label: 'Organize',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/Profile.png',
                  width: 25, // Adjust the width as needed
                  height: 25, // Adjust the height as needed
                ),
                label: 'Profile',
              ),
            ]),
      ),
    );
  }

  Stack homePageView(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: video.length,
          onPageChanged: (index) {
            setState(() {
              _selectedVideoIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                fit: BoxFit.cover,
                video[_selectedVideoIndex].image,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return Container(color: Colors.black, child: child);
                  } else {
                    return Container(
                      color: Colors.black,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                      color: Colors.black,
                      child: const Text('Failed to load image',
                          style: TextStyle(color: Colors.red)));
                },
              ),
            );
          },
        ),
        Visibility(
          visible: _isBottomNavBarVisible,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              alignment: const Alignment(1, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 15.0,
                    backgroundImage:
                        NetworkImage(video[_selectedVideoIndex].user.userPhoto),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 10),
                  const MyButton(
                      number: "",
                      icon: Icon(Icons.menu_book_sharp, color: Colors.white)),
                  MyButton(
                      number: "${video[_selectedVideoIndex].likes}M",
                      icon: const Icon(Icons.favorite, color: Colors.white)),
                  const SizedBox(height: 10),
                  MyButton(
                      number: "${video[_selectedVideoIndex].comments.length}",
                      icon: InkWell(
                          onTap: () {
                            ShowModalBottomSheet(context,
                                video[_selectedVideoIndex].comments, user);
                          },
                          child: const Icon(
                            Icons.chat_bubble_outlined,
                            color: Colors.white,
                          ))),
                  const SizedBox(height: 10),
                  MyButton(
                      number: "${video[_selectedVideoIndex].shares}M",
                      icon: const Icon(Icons.share, color: Colors.white)),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: _isLeftButtonVisible,
                    child: HideButton(
                        onPressed: _visible,
                        icon: const Icon(
                          Icons.keyboard_double_arrow_left,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isRightButtonVisible,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: HideButton(
                onPressed: _visible,
                icon: const Icon(
                  Icons.keyboard_double_arrow_right,
                  color: Colors.white,
                )),
          ),
        ),
        Positioned(
          top: 70,
          left: 0,
          child: Container(
            margin: const EdgeInsets.only(left: 0),
            child: HideButton(
                onPressed: () {
                  showMenu(
                    color: Colors.white,
                    context: context,
                    position: const RelativeRect.fromLTRB(0, 60, 25.0, 25.0),
                    items: [
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/post.png',
                            width: 25, // Adjust the width as needed
                            height: 25, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Post a seequl",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/view.png',
                            width: 25, // Adjust the width as needed
                            height: 25, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10),
                          const Text("View your likes",
                              style: TextStyle(color: Colors.black)),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/your.png',
                            width: 25, // Adjust the width as needed
                            height: 25, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10),
                          const Text("Your seequl posts",
                              style: TextStyle(color: Colors.black)),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/reference.png',
                            width: 25, // Adjust the width as needed
                            height: 25, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10),
                          const Text("Reference contribution",
                              style: TextStyle(color: Colors.black)),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/hashtag.png',
                            width: 25, // Adjust the width as needed
                            height: 25, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10),
                          const Text("Hashtag challenges",
                              style: TextStyle(color: Colors.black)),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/notifications.png',
                            width: 25, // Adjust the width as needed
                            height: 25, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10),
                          const Text("Notifications",
                              style: TextStyle(color: Colors.black)),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/about.png',
                            width: 25, // Adjust the width as needed
                            height: 25, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10),
                          const Text("About seequl",
                              style: TextStyle(color: Colors.black)),
                        ],
                      )),
                    ],
                  );
                },
                icon: const Icon(
                  Icons.menu_outlined,
                  color: Colors.white,
                )),
          ),
        ),
        Visibility(
          visible: _isBottomNavBarVisible,
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(10),
                child: TransparentCaption(
                  text: video[_selectedVideoIndex].description,
                ),
              )),
        )
      ],
    );
  }
}
