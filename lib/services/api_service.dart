import "dart:async";
import "dart:convert";
import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:learning_app/helpers/locator.dart";
import "package:learning_app/models/api_status.dart";
import "package:learning_app/models/response_models/api_response.dart";
import "package:learning_app/services/global_service.dart";
import "package:learning_app/services/http_service.dart";
import "package:learning_app/services/network_service.dart";

class APIService implements IAPIService {
  INetworkService get _networkService => locator<INetworkService>();
  HttpService get _httpService => locator<HttpService>();
  GlobalService get _globalService => locator<GlobalService>();

  @override
  Future<ApiStatus> login(String email, String password) async {
    if (await _networkService.isConnected) {
      try {
        if(Platform.isAndroid || Platform.isIOS){
          try{
          await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return ApiStatus(
              data: null,
              errorCode: "PA0004",
            );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code=='invalid-credential') {
        return ApiStatus(
              data: null,
              errorCode: "FA0001",
            );
      } else if (e.code == "wrong-password") {
        return ApiStatus(
              data: null,
              errorCode: "FA0002",
            );
      } else {
        return ApiStatus(
              data: null,
              errorCode: "FA0003",
            );
      }
    }
    }
        else{
          return ApiStatus(
              data: null,
              errorCode: "PA0004",
            );
        }
      } on HttpException catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0013");
      } on FormatException catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0007");
      } on TimeoutException catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0003");
      } catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0006");
      }
    } else {
      return ApiStatus(data: null, errorCode: "PA0005");
    }
  }

  @override
  Future<ApiStatus> signup(String name, String email, String password, String gender) async {
    if (await _networkService.isConnected) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        if(Platform.isAndroid || Platform.isIOS){
          try{
          await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
            User? user = FirebaseAuth.instance.currentUser;
          // Add user details
          if(user!=null){
            await firestore.collection('users').doc(user.uid).set({
      'name': name,
      'gender': "gender",
      'email': user.email, // Optional: Store user email
      'createdAt': FieldValue.serverTimestamp(), // Timestamp for user creation
    });
          }
    
      return ApiStatus(
              data: null,
              errorCode: "PA0004",
            );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return ApiStatus(
              data: null,
              errorCode: "FA0004",
            );
      } else if (e.code == "weak-password") {
        return ApiStatus(
              data: null,
              errorCode: "FA0005",
            );
      } else {
        return ApiStatus(
              data: null,
              errorCode: "FA0006",
            );
      }
    }
    }
        else{
          return ApiStatus(
              data: null,
              errorCode: "PA0004",
            );
        }
      } on HttpException catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0013");
      } on FormatException catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0007");
      } on TimeoutException catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0003");
      } catch (e, s) {
        _globalService.logError("Error Occured!", e.toString(), s);
        debugPrint(e.toString());
        return ApiStatus(data: e, errorCode: "PA0006");
      }
    } else {
      return ApiStatus(data: null, errorCode: "PA0005");
    }
  }

}

abstract class IAPIService {
  Future<ApiStatus> login(String email, String password);
  Future<ApiStatus> signup(String name, String email, String password, String gender);
}
