import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
static var supabaseUrl = dotenv.env['SUPABASE_URL']!;
static var supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;

  static const String unknownError = 'Something went wrong. Please try again.';
}

