import 'package:hive_flutter/hive_flutter.dart';

/// Nomes das boxes Hive usadas para cache offline
class HiveBoxes {
  HiveBoxes._();

  static const String userProfile = 'user_profile_box';
  static const String userPosts = 'user_posts_box';
}

/// Inicializa o Hive e abre as boxes usadas pelo app
Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.userProfile);
  await Hive.openBox(HiveBoxes.userPosts);
}