import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EmojiSearchPage extends StatefulWidget {
  const EmojiSearchPage({super.key, required this.title});
  final String title;

  @override
  _EmojiSearchPageState createState() => _EmojiSearchPageState();
}

class _EmojiSearchPageState extends State<EmojiSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  String emojiStr = "";

  Future<List<Emoji>> fetchData() async {
    List<Emoji> filterEmojiEntities = await EmojiPickerUtils().searchEmoji(
        emojiStr == "" ? "face" : emojiStr,
        defaultEmojiSet); // Simulating a time-consuming operation
    return filterEmojiEntities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleSpacing: 2,
        title: Text(widget.title),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.grey),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Search Emoji...',
                          border: InputBorder.none,
                        ),
                        onChanged: (query) {
                          setState(() {
                            emojiStr = query;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Emoji>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6, // Number of columns
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              String selectedEmoji =
                                  snapshot.data![index].emoji;
                              Navigator.pop(context, selectedEmoji);
                            },
                            child: Center(
                              child: Text(
                                snapshot.data![index].emoji,
                                style: const TextStyle(fontSize: 35.0),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
