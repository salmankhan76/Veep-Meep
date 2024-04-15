import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthServices {
  /*Future<bool> isAppleSignInAvailable() {
    return SignInWithApple.isAvailable();
  }*/

  signInWithGoogle({required Function(User) onSuccess, required Function(String) onError}) async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((authResult) {
        onSuccess(FirebaseAuth.instance.currentUser!);
      }).catchError((error) {
        onError('Google Signing Failed $error');
      });
    } catch (e) {
      onError('Google Signing Failed ${e.toString()}');
    }
  }

  /*signInWithApple({Function(User) onSuccess, Function(String) onError}) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // nonce: _sha256ofString(_generateNonce()),
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.semicolabs.qityol',
        redirectUri:
            Uri.parse('https://qityol-6856f.firebaseapp.com/__/auth/handler'),
      ),
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      // rawNonce: _generateNonce(),
      accessToken: credential.authorizationCode
    );

    await FirebaseAuth.instance
        .signInWithCredential(oauthCredential)
        .then((authResult) {
      onSuccess(FirebaseAuth.instance.currentUser);
    }).catchError((error) {
      onError('Apple Signing Failed $error');
    });
  }

  signInWithFacebook(
      {Function(User) onSuccess, Function(String) onError}) async {
    final result = await FacebookAuth.instance
        .login(permissions: (['email', 'public_profile']));
    final token = result.accessToken.token;

    try {
      final fbCredential = FacebookAuthProvider.credential(token);
      await FirebaseAuth.instance
          .signInWithCredential(fbCredential)
          .then((authResult) {
        onSuccess(FirebaseAuth.instance.currentUser);
      }).catchError((error) {
        onError('Facebook Signing Failed $error');
      });
    } catch (e) {
      onError('Facebook Signing Failed ${e.toString()}');
    }
  }*/

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
