import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCGlFhyyzZhwKO97uXKNNBbHIOGINkKI9I",
            authDomain: "shatapp-ef646.firebaseapp.com",
            projectId: "shatapp-ef646",
            storageBucket: "shatapp-ef646.appspot.com",
            messagingSenderId: "849257838422",
            appId: "1:849257838422:web:36f615622434596a5c48f7"));
  } else {
    await Firebase.initializeApp();
  }
}
