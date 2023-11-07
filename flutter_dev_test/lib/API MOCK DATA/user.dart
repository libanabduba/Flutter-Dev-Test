import 'package:faker/faker.dart';

class User {
  String name; // Name of the user who commented
  String userPhoto; // URL of the user's profile photo
  String username; // Username of the user who commented

  User({
    required this.name,
    required this.userPhoto,
    required this.username,
  });
}

List<User> generateUsersMockData(int count) {
  final faker = Faker();
  final users = <User>[];

  for (var i = 0; i < count; i++) {
    final user = User(
      name: faker.person.name(),
      userPhoto: faker.image.image(random: true, keywords: [
        'profile',
        'user',
        'avatar',
        'people',
        'person',
        'account',
        'face',
        'portrait',
        'photo',
        'picture'
      ]),
      username: faker.internet.userName(),
    );
    users.add(user);
  }

  return users;
}

// Generate 10 comments mock data
final commentsMockData = generateUsersMockData(10);
