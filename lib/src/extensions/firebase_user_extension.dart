import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtension on FirebaseUser {
  String getFacebookPhotoUrl({
    int imageSize = 350,
  }) {
    for (UserInfo profile in providerData) {
      // check if the provider id matches "facebook.com"
      if (FacebookAuthProvider.providerId == profile.providerId) {
        String facebookUserId = profile.uid;
        return 'https://graph.facebook.com/$facebookUserId/picture?height=$imageSize';
      }
    }

    return photoUrl;
  }
}
