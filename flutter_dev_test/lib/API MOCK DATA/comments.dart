import 'package:faker/faker.dart';
import 'package:flutter_dev_test/API%20MOCK%20DATA/user.dart';

class Comment {
  String name; // Name of the user who commented
  User user; // class of the user's profile
  String content; // Content of the comment
  DateTime timeCommented; // Time the comment was posted
  int likes; // Number of likes the comment has received
  int shares; // Number of shares the comment has received
  List<Comment> replies; // List of replies to the comment

  Comment({
    required this.name,
    required this.user,
    required this.content,
    required this.timeCommented,
    required this.likes,
    required this.shares,
    required this.replies,
  });
}

List<Comment> generateCommentsMockData(int count) {
  final faker = Faker();
  final comments = <Comment>[];

  for (var i = 0; i < count; i++) {
    final comment = Comment(
      name: faker.person.name(),
      user: generateUsersMockData(1)[0],
      content: faker.lorem
          .sentences(faker.randomGenerator.integer(10, min: 1))
          .join(' '),
      timeCommented: faker.date.dateTime(),
      likes: faker.randomGenerator.integer(100, min: 0),
      shares: faker.randomGenerator.integer(100, min: 0),
      replies: [],
    );

    // Generate replies to the comment
    final replyCount = faker.randomGenerator.integer(5);
    for (var j = 0; j < replyCount; j++) {
      final reply = Comment(
        name: faker.person.name(),
        user: generateUsersMockData(1)[0],
        content: faker.lorem
            .sentences(faker.randomGenerator.integer(10, min: 1))
            .join(' '),
        timeCommented: faker.date.dateTime(),
        likes: faker.randomGenerator.integer(100, min: 0),
        shares: faker.randomGenerator.integer(100, min: 0),
        replies: [],
      );
      comment.replies.add(reply);
    }

    comments.add(comment);
  }

  return comments;
}

// Generate 10 comments mock data
final commentsMockData = generateCommentsMockData(10);
