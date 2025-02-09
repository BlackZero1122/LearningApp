import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthMService{
  final FirebaseAuth auth= FirebaseAuth.instance;

  getCurrentUser()async{
    return await auth.currentUser;
  }


  Future<User?> signInWithGoogle(BuildContext context)async{
    try {
      final FirebaseAuth firebaseAuth= FirebaseAuth.instance;
      if (kIsWeb) {
  final GoogleAuthProvider provider = GoogleAuthProvider()
      .setCustomParameters({'prompt': 'select_account'});
  UserCredential result = await firebaseAuth.signInWithPopup(provider);
  User? userdetails= result.user;
if(userdetails!=null){
      // await FirebaseFirestore.instance.collection('users').doc(userdetails.uid).set({
      //           'name': userdetails.displayName,
      //           'gender': "Male",
      //           'email': userdetails.email, // Optional: Store user email
      //           'createdAt':
      //               FieldValue.serverTimestamp(), // Timestamp for user creation
      //         });
      // return userdetails;
}
}else{
final GoogleSignIn googleSignIn= GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication= await googleSignInAccount?.authentication;

    final AuthCredential credential= GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken:  googleSignInAuthentication?.accessToken,
    );

    UserCredential result= await firebaseAuth.signInWithCredential(credential);

    User? userdetails= result.user;

    if(userdetails!=null){
      //  await FirebaseFirestore.instance.collection('users').doc(userdetails.uid).set({
      //           'name': userdetails.displayName,
      //           'gender': "Male",
      //           'email': userdetails.email, // Optional: Store user email
      //           'createdAt':
      //               FieldValue.serverTimestamp(), // Timestamp for user creation
      //         });
      return userdetails;
    }
}
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

   Future<User?> signInWithApple({List<Scope> scopes = const []}) async {
    try {
      final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential = result.credential!;
        final oAuthCredential = OAuthProvider('apple.com');
        final credential = oAuthCredential.credential(
            idToken: String.fromCharCodes(AppleIdCredential.identityToken!));
        final UserCredential = await auth.signInWithCredential(credential);
        final firebaseUser = UserCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = AppleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName}${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      default:
        
    }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}