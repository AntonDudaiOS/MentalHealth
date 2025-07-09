import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('onboardingSeen') ?? false);
  }
}
