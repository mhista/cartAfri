import 'package:uuid/uuid.dart';

class Utills {
  static String uniqueReference() => const Uuid().v4();
}
