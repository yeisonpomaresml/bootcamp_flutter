import 'screens/screens.dart';

class AppConfig {
  static String initialRoute = 'login';

  static routes() {
    return {
      'login': ((context) => const LoginScreen()),
      'register': ((context) => const RegisterScreen()),
      'home': ((context) => const HomeScreen()),
      'mapa': ((context) => const MapaScreen()),
      'profile': ((context) => const ProfileScreen()),
      'acerca': ((context) => const AcercaScreen()),
    };
  }
}
