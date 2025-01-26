import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  Future<void> loadEnv() async {
    await dotenv.load();
  }

  String getPexelsApiKey() {
    return dotenv.env['PEXELS_API_KEY']!;
  }
}
