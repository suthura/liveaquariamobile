import 'dart:convert';

import 'package:aquaria_mobile/models/login_user_model.dart';
import 'package:aquaria_mobile/models/sub_user_model.dart';
import 'package:aquaria_mobile/screens/home/home_screen.dart';
import 'package:aquaria_mobile/utils/custom_http.dart';
import 'package:aquaria_mobile/utils/error_messages.dart';
import 'package:aquaria_mobile/utils/url_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController get getUsernameController => usernameController;
  TextEditingController passwordController = TextEditingController();
  TextEditingController get getPasswordController => passwordController;

  bool isLogginIn = false;
  bool get getIsLogginIn => isLogginIn;
  setIsLogginIn(val) {
    isLogginIn = val;
    notifyListeners();
  }

  LoginUserModel? loggedinUser;
  LoginUserModel? get getloggedinUser => loggedinUser;
  setloggedinUser(LoginUserModel? val) {
    dev.log("from login " + val!.accessToken.toString());
    loggedinUser = val;
    notifyListeners();
  }

  Future<void> performMainLogin(context) async {
    setIsLogginIn(true);
    try {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        errorMessage(context, errorTxt: 'Please enter valid credentials', btnType: 3).show();
      } else {
        final response = await CustomHttp.getDio().post(
          kLoginURL,
          data: {
            "email": usernameController.text,
            "password": passwordController.text,
          },
        );

        var encoded = jsonEncode(response.data);

        LoginUserModel temp = LoginUserModel.fromJson(jsonDecode(encoded));

        if (response.statusCode == 200) {
          usernameController.clear();
          passwordController.clear();
          setloggedinUser(temp);
          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 2),
                pageBuilder: (_, __, ___) => const HomeScreen(),
              ),
              (route) => false);
        } else {
          errorMessage(context, errorTxt: 'Error Login', btnType: 3).show();
        }
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setIsLogginIn(false);
    }
  }

  bool isCreatingUser = false;
  bool get getIsCreatingUser => isCreatingUser;
  setIsCreatingUser(val) {
    isCreatingUser = val;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController get getNameController => nameController;

  TextEditingController emailController = TextEditingController();
  TextEditingController get getEmailController => emailController;

  TextEditingController phoneController = TextEditingController();
  TextEditingController get getPhoneController => phoneController;

  // TextEditingController passwordController = TextEditingController();
  // TextEditingController get getPasswordController => passwordController;
  XFile? image;
  XFile? get getuserimage => image;
  setimage(XFile? val) {
    image = val;
    notifyListeners();
  }

  Future<void> createSubUser(context) async {
    setIsCreatingUser(true);
    try {
      FormData formData = FormData.fromMap({
        "avatar": getuserimage == null ? "" : [await MultipartFile.fromFile(getuserimage!.path)],
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "password_confirmation": passwordController.text,
      });

      final response = await CustomHttp.getDio().post(
        kSaveSubUser,
        data: formData,
      );
      // dev.log(response.data);

      // var encoded = jsonEncode(response.data);

      // BaseModel temp = BaseModel.fromJson(jsonDecode(encoded));
      // dev.log(response.statusCode.toString());
      if ([200, 201].contains(response.statusCode)) {
        loadSubUsers(context);
        Navigator.pop(context);
      } else {
        errorMessage(context, errorTxt: 'Error Saving', btnType: 3).show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setIsCreatingUser(false);
    }
  }

  bool isLoadingSubUsers = false;
  bool get getisLoadingSubUsers => isLoadingSubUsers;
  setisLoadingSubUsers(val) {
    isLoadingSubUsers = val;
    notifyListeners();
  }

  SubUserModel? loadedSubUsers;
  SubUserModel? get getloadedSubUser => loadedSubUsers;
  setloadedSubUsers(val) {
    loadedSubUsers = val;
    notifyListeners();
  }

  Future<void> loadSubUsers(context) async {
    try {
      setisLoadingSubUsers(true);
      // var token = Provider.of<AuthProvider>(context, listen: false).getloggedinUser?.token;
      final response = await CustomHttp.getDio().get(
        kGetSubUser,
      );

      var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      SubUserModel temp = SubUserModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200) {
        setloadedSubUsers(temp);
      } else {
        errorMessage(context, errorTxt: 'Error Loading Items').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisLoadingSubUsers(false);
    }
  }
}
