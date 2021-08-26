import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AthlimaFirebaseUser {
  AthlimaFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

AthlimaFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AthlimaFirebaseUser> athlimaFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AthlimaFirebaseUser>(
        (user) => currentUser = AthlimaFirebaseUser(user));
