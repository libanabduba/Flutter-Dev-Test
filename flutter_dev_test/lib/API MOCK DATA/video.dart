import 'package:faker/faker.dart';
import 'package:flutter_dev_test/API%20MOCK%20DATA/user.dart';
import 'comments.dart';

class Video {
  String image; // URL of the user's profile photo
  String description; // Description of the video
  List<Comment> comments; // comments of the user who commented
  User user; // userPhoto of the user who created video
  int likes; // Number of likes the video has received
  int shares; // Number of shares the video has received

  Video({
    required this.image,
    required this.description,
    required this.comments,
    required this.user,
    required this.likes,
    required this.shares,
  });
}

List<Video> generateVideoMockData(int count) {
  final faker = Faker();
  final video = <Video>[];

  for (var i = 0; i < count; i++) {
    final vid = Video(
      image: faker.image.image(random: true, keywords: [
        'muslim',
        'islam',
        'hijab',
        'quran',
        'allah',
        'muhammad',
        'ramadan',
        'arab',
        'arabic'
      ]),
      comments:
          generateCommentsMockData(faker.randomGenerator.integer(100, min: 0)),
      description: faker.lorem
          .sentences(faker.randomGenerator.integer(10, min: 1))
          .join(' '),
      user: generateUsersMockData(1)[0],
      likes: faker.randomGenerator.integer(10, min: 0),
      shares: faker.randomGenerator.integer(100, min: 0),
    );
    video.add(vid);
  }

  return video;
}

// Generate 10 comments mock data
final commentsMockData = generateVideoMockData(10);
