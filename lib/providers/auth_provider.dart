import 'dart:convert';
import 'dart:developer';

import 'package:aquaria_mobile/models/bank_list_model.dart';
import 'package:aquaria_mobile/models/common_data_model.dart';
import 'package:aquaria_mobile/models/login_user_model.dart';
import 'package:aquaria_mobile/models/sub_user_model.dart';
import 'package:aquaria_mobile/screens/auth/login_screen.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController get getNameController => nameController;

  TextEditingController emailController = TextEditingController();
  TextEditingController get getEmailController => emailController;

  TextEditingController phoneController = TextEditingController();
  TextEditingController get getPhoneController => phoneController;

  TextEditingController vendorCodeController = TextEditingController();
  TextEditingController get getVendorCodeController => vendorCodeController;

  TextEditingController brNoController = TextEditingController();
  TextEditingController get getBrNoController => brNoController;

  TextEditingController addressController = TextEditingController();
  TextEditingController get getAddressController => addressController;

  TextEditingController countryController = TextEditingController();
  TextEditingController get getCountryController => countryController;

  TextEditingController timezoneController = TextEditingController();
  TextEditingController get getTimezoneController => timezoneController;

  TextEditingController currencyController = TextEditingController();
  TextEditingController get getCurrencyController => currencyController;

  TextEditingController accountNoController = TextEditingController();
  TextEditingController get getAccountNoController => accountNoController;

  TextEditingController bankController = TextEditingController();
  TextEditingController get getBankController => bankController;

  TextEditingController branchController = TextEditingController();
  TextEditingController get getBranchController => branchController;

  TextEditingController offeringItemsController = TextEditingController();
  TextEditingController get getOfferingItemsController => offeringItemsController;

  TextEditingController deliveryMethodsController = TextEditingController();
  TextEditingController get getDeliveryMethodsController => deliveryMethodsController;

  TextEditingController specializedAreasController = TextEditingController();
  TextEditingController get getSpecializedAreasController => specializedAreasController;

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
            "type": getselectedRole == 'Vendor' ? "supplier" : "customer",
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
          errorMessage(context, errorTxt: response.data['message'], btnType: 3).show();
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
        "type": "sub_customer",
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "password_confirmation": passwordController.text,
        "customer_id": getloggedinUser!.data!.id
      });

      final response = await CustomHttp.getDio().post(
        kRegister,
        data: formData,
      );

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

  CommonDataModel? loadedCommonData;
  CommonDataModel? get getloadedCommonData => loadedCommonData;
  setloadedCommonData(val) {
    loadedCommonData = val;
    notifyListeners();
  }

  Future<void> loadCommonData(context) async {
    try {
      if (loadedCommonData == null) {
        // setisLoadingSubUsers(true);
        // var token = Provider.of<AuthProvider>(context, listen: false).getloggedinUser?.token;
        final response = await CustomHttp.getDio().get(
          kGetCommnData,
        );

        var encoded = jsonEncode(response.data);
        // dev.log(response.data.toString());

        CommonDataModel temp = CommonDataModel.fromJson(jsonDecode(encoded));

        if (response.statusCode == 200 || response.statusCode == 201) {
          setloadedCommonData(temp);
        } else {
          errorMessage(context, errorTxt: 'Error Loading Common Data').show();
        }
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      // setisLoadingSubUsers(false);
    }
  }

  BankListModel? loadedBanksList;
  BankListModel? get getloadedBanksList => loadedBanksList;
  setloadedBanksList(val) {
    loadedBanksList = val;
    notifyListeners();
  }

  Countries? selectedCountry;
  Countries? get getselectedCountry => selectedCountry;
  setselectedCountry(val) {
    selectedCountry = val;
    notifyListeners();
  }

  SingleBankData? selectedBank;
  SingleBankData? get getselectedBank => selectedBank;

  setselectedBank(val) {
    selectedBank = val;
    notifyListeners();
  }

  BankBranches? selectedBranch;
  BankBranches? get getselectedBranch => selectedBranch;
  setselectedBranch(val) {
    selectedBranch = val;
    notifyListeners();
  }

  List<DeliveryMethods> selectedDeliveryMethods = [];
  setselectedDeliveryMethods(val) {
    selectedDeliveryMethods = val;
    notifyListeners();
  }

  Future<void> loadBanksData(context) async {
    try {
      setloadedBanksList(null);
      setselectedBank(null);
      setselectedBranch(null);
      // setisLoadingSubUsers(true);
      // log("$kGetBanks/${selectedCountry!.code}");
      // var token = Provider.of<AuthProvider>(context, listen: false).getloggedinUser?.token;
      final response = await CustomHttp.getDio().get(
        "$kGetBanks/${selectedCountry!.id}",
      );

      var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      BankListModel temp = BankListModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200 || response.statusCode == 201) {
        setloadedBanksList(temp);
      } else {
        errorMessage(context, errorTxt: 'Error Loading Bank Data').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      // setisLoadingSubUsers(false);
    }
  }

  String selectedRole = 'Customer';
  String get getselectedRole => selectedRole;
  setselectedRole(val) {
    selectedRole = val;
    notifyListeners();
  }

  Timezones? selectedTimezone;
  Timezones? get getselectedTimezone => selectedTimezone;
  setselectedTimezone(val) {
    selectedTimezone = val;
    notifyListeners();
  }

  Currencies? selectedCurrency;
  Currencies? get getselectedCurrency => selectedCurrency;
  setselectedCurrency(val) {
    selectedCurrency = val;
    notifyListeners();
  }

  Future<void> registerUser(context) async {
    setIsCreatingUser(true);
    try {
      // log({
      //   "avatar": getuserimage == null ? "" : [await MultipartFile.fromFile(getuserimage!.path)],
      //   "name": nameController.text,
      //   "email": emailController.text,
      //   "phone": phoneController.text,
      //   "password": passwordController.text,
      //   "password_confirmation": passwordController.text,
      //   "type": getselectedRole == 'Vendor' ? "supplier" : "customer",
      //   if (getselectedRole == 'Vendor') ...{
      //     "vendor_code": vendorCodeController.text,
      //     "br_number": brNoController.text,
      //     "address": addressController.text,
      //     "country_id": selectedCountry!.id,
      //     "timezone_id": selectedTimezone!.id,
      //     "currency_id": selectedCurrency!.id,
      //     "bank_account": accountNoController.text,
      //     "bank_id": selectedBank!.id,
      //     "bank_branch_id": selectedBranch!.id,
      //     "offering_items": [],
      //     "delivery_methods": selectedDeliveryMethods.map((e) => e.id).toList(),
      //     "specialized_areas": specializedAreasController.text,
      //   }
      // }.toString());
      FormData formData = FormData.fromMap({
        "avatar": getuserimage == null ? "" : [await MultipartFile.fromFile(getuserimage!.path)],
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "password_confirmation": passwordController.text,
        "type": getselectedRole == 'Vendor' ? "supplier" : "customer",
        if (getselectedRole == 'Vendor') ...{
          "vendor_code": vendorCodeController.text,
          "br_number": brNoController.text,
          "address": addressController.text,
          "country_id": selectedCountry!.id,
          "timezone_id": selectedTimezone!.id,
          "currency_id": selectedCurrency!.id,
          "bank_account": accountNoController.text,
          "bank_id": selectedBank!.id,
          "bank_branch_id": selectedBranch!.id,
          "offering_items": [],
          "delivery_methods": selectedDeliveryMethods.map((e) => e.id).toList(),
          "specialized_areas": specializedAreasController.text,
        }
      });

      final response = await CustomHttp.getDio().post(
        kRegister,
        data: formData,
      );

      log(response.data.toString());

      if ([200, 201].contains(response.statusCode)) {
        // Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Account Created"),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginScreen(),
          ),
          (Route<dynamic> route) => false,
        );
        // errorMessage(context, errorTxt: 'Account Created', btnType: 3).show();

        // loadSubUsers(context);
        // Navigator.pop(context);
      } else {
        errorMessage(context, errorTxt: 'Error Saving', btnType: 3).show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setIsCreatingUser(false);
    }
  }
}
