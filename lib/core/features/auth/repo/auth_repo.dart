import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:gorintest/common/constants/firebase_constants.dart';
import 'package:gorintest/common/utils/auth_exception_handler.dart';
import 'package:gorintest/common/utils/helper_functions.dart';
import 'package:gorintest/core/model/app_user.dart';
import 'package:gorintest/core/networking/api_response.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<ApiResponse<AppUser?>> signUpFirebase({
    required String email,
    required String password,
    required String name,
    File? imageFile,
  }) async {
    try {
      if (await HelperFunctions.hasNetwork()) {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await auth.currentUser?.updateDisplayName(name);
        AppUser appUser = AppUser(
          email: email,
          name: name,
          uid: auth.currentUser!.uid,
        );

        if (imageFile != null) {
          String imageUrl = await uploadFile(
            file: imageFile,
            fileName: imageFile.uri.pathSegments.last,
            uid: auth.currentUser!.uid,
          );
          appUser.imageUrl = imageUrl;
        }

        await saveUser(appUser: appUser);

        return ApiResponse(
          status: Status.success,
          message: 'Successfully Signed Up',
          data: appUser,
        );
      } else {
        return ApiResponse(
          status: Status.error,
          message: 'Please check your internet connection',
        );
      }
    } on FirebaseAuthException catch (e) {
      return ApiResponse(
        status: Status.error,
        message: AuthExceptionHandler.getErrorMessageForExcpetion(e),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return ApiResponse(
        status: Status.error,
        message: 'Something went wrong!',
      );
    }
  }

  Future<ApiResponse<AppUser?>> signInThroughFirebase(
      String email, String password) async {
    try {
      if (await HelperFunctions.hasNetwork()) {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        AppUser? appUser = await getUser(uid: auth.currentUser!.uid);

        return ApiResponse(
          status: Status.success,
          message: 'Successfully Logged In',
          data: appUser,
        );
      } else {
        return ApiResponse(
          status: Status.error,
          message: 'Please check your internet connection',
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('e.code --- ${e.code}');
      return ApiResponse(
        status: Status.error,
        message: AuthExceptionHandler.getErrorMessageForExcpetion(e),
      );
    } catch (e) {
      return ApiResponse(status: Status.error, message: "Something went wrong");
    }
  }

  Future<ApiResponse> signOutThroughFirebase() async {
    try {
      await auth.signOut();
      return ApiResponse(
        status: Status.success,
      );
    } on FirebaseAuthException catch (e) {
      return ApiResponse(status: Status.error, message: e.message);
    } catch (e) {
      return ApiResponse(status: Status.error, message: e.toString());
    }
  }

  Stream<List<AppUser>> getUsers() {
    Stream<QuerySnapshot> stream =
        firestore.collection(FirebaseCollections.userCollection).snapshots();
    return stream.asyncMap(getAppUsers);
  }

  Future<List<AppUser>> getAppUsers(QuerySnapshot stream) async {
    List<AppUser> appUsers = [];
    var result = stream.docs.map((doc) async {
      AppUser appUser = AppUser.fromJson(doc.data() as Map<String, dynamic>);
      return appUser;
    });

    appUsers = await Future.wait(result);
    return appUsers;
  }

  Future<AppUser> saveUser({required AppUser appUser}) async {
    Map<String, dynamic> userObj = appUser.toJson();
    await firestore
        .collection(FirebaseCollections.userCollection)
        .doc(appUser.uid)
        .set(
          userObj,
          SetOptions(merge: true),
        );
    return appUser;
  }

  Future<AppUser?> getUser({required String uid}) async {
    DocumentSnapshot<Map<String, dynamic>> document = await firestore
        .collection(FirebaseCollections.userCollection)
        .doc(uid)
        .get();
    if (document.exists) {
      AppUser appUser = AppUser.fromJson(document.data()!);
      return appUser;
    }
    return null;
  }

  Future<String> uploadFile({
    required File file,
    required String fileName,
    required String uid,
  }) async {
    String link = '';
    final storageRef = storage.ref();
    final uploadTask =
        await storageRef.child('images/users/$uid/$fileName').putFile(file);

    final ref = uploadTask.storage.ref('images/users/$uid/$fileName');
    link = await ref.getDownloadURL();
    return link;
  }
}
