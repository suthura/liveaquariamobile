import 'dart:convert';

import 'package:aquaria_mobile/models/advertisement_model.dart';
import 'package:aquaria_mobile/models/main_item_model.dart';
import 'package:aquaria_mobile/models/orders_model.dart';
import 'package:aquaria_mobile/models/sup_req_model.dart';
import 'package:aquaria_mobile/utils/custom_http.dart';
import 'package:aquaria_mobile/utils/error_messages.dart';
import 'package:aquaria_mobile/utils/url_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as dev;

import 'package:rflutter_alert/rflutter_alert.dart';

class ItemOrderProvider extends ChangeNotifier {
  bool isLoadingItems = false;
  bool get getisLoadingItems => isLoadingItems;
  setisLoadingItems(val) {
    isLoadingItems = val;
    notifyListeners();
  }

  MainItemsModel? loadedMainItems;
  MainItemsModel? get getloadedMainItems => loadedMainItems;
  setloadedMainItems(val) {
    loadedMainItems = val;
    notifyListeners();
  }

  Future<void> loadAllMainItems(context) async {
    try {
      setisLoadingItems(true);
      // var token = Provider.of<AuthProvider>(context, listen: false).getloggedinUser?.token;
      final response = await CustomHttp.getDio().get(
        kGetAllItemsData,
      );

      var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      MainItemsModel temp = MainItemsModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200) {
        setloadedMainItems(temp);
      } else {
        errorMessage(context, errorTxt: 'Error Loading Items').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisLoadingItems(false);
    }
  }

  TextEditingController itmWeightController = TextEditingController();
  TextEditingController itmSizeController = TextEditingController();
  TextEditingController itmColorController = TextEditingController();
  TextEditingController itmDescriptionController = TextEditingController();

  TextEditingController get itmWeightControllerGetter => itmWeightController;
  TextEditingController get itmSizeControllerGetter => itmSizeController;
  TextEditingController get itmColorControllerGetter => itmColorController;
  TextEditingController get itmDescriptionControllerGetter => itmDescriptionController;

  bool isSavingRequest = false;
  bool get getisSavingRequest => isSavingRequest;
  setisSavingRequest(val) {
    isSavingRequest = val;
    notifyListeners();
  }

  TextEditingController quantityController = TextEditingController();
  TextEditingController get getQuantityController => quantityController;

  TextEditingController breedingCapacityController = TextEditingController();
  TextEditingController get getBreedingCapacityController => breedingCapacityController;

  TextEditingController futureCollectionController = TextEditingController();
  TextEditingController get getFutureCollectionController => futureCollectionController;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController get getDescriptionController => descriptionController;

  List<XFile> supReqimages = [];
  List<XFile> get getsupReqimages => supReqimages;
  setgetsupReqimages(val) {
    supReqimages = val;
    notifyListeners();
  }

  XFile? videoFile;
  XFile? get getvideoFile => videoFile;
  setvideoFile(val) {
    videoFile = val;
    notifyListeners();
  }

  Future<void> saveSuplierRequest(context, {required SingleItem item}) async {
    try {
      setisSavingRequest(true);

      FormData formData = FormData.fromMap({
        for (int i = 0; i < getsupReqimages.length; i++)
          "images[$i]": await MultipartFile.fromFile(
            getsupReqimages[i].path,
          ),
        if (videoFile != null)
          "videos[0]": await MultipartFile.fromFile(
            videoFile!.path,
          ),
        "item_id": item.id,
        "quantity": quantityController.text,
        "breeding_capacity": breedingCapacityController.text,
        "description": descriptionController.text,
        "future_collection": futureCollectionController.text,
      });
      final response = await CustomHttp.getDio().post(
        kSaveSupRequest,
        data: formData,
      );

      // var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      // BaseModel temp = BaseModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200 || response.statusCode == 201) {
        errorMessage(context, errorTxt: 'Request Sent', btnType: 3).show();
      } else {
        errorMessage(context, errorTxt: 'Error Sending Request').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisSavingRequest(false);
    }
  }

  bool isLoadingSupReq = false;
  bool get getisLoadingSupReq => isLoadingSupReq;
  setisLoadingSupReq(val) {
    isLoadingSupReq = val;
    notifyListeners();
  }

  SupplierRequestsModel? loadedSupplierReqs;
  SupplierRequestsModel? get getloadedSupplierReqs => loadedSupplierReqs;
  setloadedSupplierReqs(val) {
    loadedSupplierReqs = val;
    notifyListeners();
  }

  Future<void> loadSupplierRequests(context) async {
    try {
      setisLoadingSupReq(true);
      // var token = Provider.of<AuthProvider>(context, listen: false).getloggedinUser?.token;
      final response = await CustomHttp.getDio().get(
        kLoadSupReq,
      );

      var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      SupplierRequestsModel temp = SupplierRequestsModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200 || response.statusCode == 201) {
        setloadedSupplierReqs(temp);
      } else {
        errorMessage(context, errorTxt: 'Error Loading Data').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisLoadingSupReq(false);
    }
  }

  List<SingleSupplierRequestModel> getSeperateSupReq({required String approval, required List<int> published}) {
    List<SingleSupplierRequestModel> temp = [];
    if (getloadedSupplierReqs != null) {
      return getloadedSupplierReqs!.data!.where((element) => element.status == approval && published.contains(element.isPublish)).toList();
    } else {
      return temp;
    }
  }

  AvertisementsModel? loadedadslist;
  AvertisementsModel? get getloadedadslist => loadedadslist;
  setloadedadslist(val) {
    loadedadslist = val;
    notifyListeners();
  }

  Future<void> loadAdvertisements(context) async {
    try {
      setisLoadingItems(true);
      // var token = Provider.of<AuthProvider>(context, listen: false).getloggedinUser?.token;
      final response = await CustomHttp.getDio().get(
        kLoadAdvertisements,
      );

      var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      AvertisementsModel temp = AvertisementsModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200) {
        setloadedadslist(temp);
      } else {
        errorMessage(context, errorTxt: 'Error Loading Items').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisLoadingItems(false);
    }
  }

  String selectedOrderType = 'Sample';
  String get getselectedOrderType => selectedOrderType;
  setselectedOrderType(val) {
    selectedOrderType = val;
    notifyListeners();
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController get getaddressController => addressController;

  Future<void> saveOrderrRequest(context, {required SingleAvertisement item}) async {
    try {
      setisSavingRequest(true);

      FormData formData = FormData.fromMap({
        "type": getselectedOrderType == "Sample" ? "sample_order" : "place_order",
        "supplier_request_id": item.id,
        "quantity": getselectedOrderType == "Sample" ? "1" : quantityController.text,
        "address": addressController.text,
      });
      final response = await CustomHttp.getDio().post(
        kSaveOrder,
        data: formData,
      );

      // var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      // BaseModel temp = BaseModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200 || response.statusCode == 201) {
        errorMessage(context, errorTxt: 'Request Sent', btnType: 3).show();
      } else {
        errorMessage(context, errorTxt: 'Error Sending Request').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisSavingRequest(false);
    }
  }

  OrdersModel? loadedOrdersList;
  OrdersModel? get getloadedOrdersList => loadedOrdersList;
  setloadedOrdersList(val) {
    loadedOrdersList = val;
    notifyListeners();
  }

  bool isLoadingOrders = false;
  bool get getisLoadingOrders => isLoadingOrders;
  setisLoadingOrders(val) {
    isLoadingOrders = val;
    notifyListeners();
  }

  Future<void> loadOrders(context, {bool isSubUser = false}) async {
    try {
      setisLoadingOrders(true);
      // var token = Provider.of<AuthProvider>(context, listen: false).getloggedinUser?.token;
      final response = await CustomHttp.getDio().get(
        isSubUser ? kGetSUbOrder : kSaveOrder,
      );

      var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      OrdersModel temp = OrdersModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200) {
        setloadedOrdersList(temp);
      } else {
        errorMessage(context, errorTxt: 'Error Loading Orders').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisLoadingOrders(false);
    }
  }

  List<SingleOrder> getSepeateOrderMainUser({required String approval}) {
    List<SingleOrder> temp = [];
    if (getloadedSupplierReqs != null) {
      return getloadedOrdersList!.data!.where((element) => element.adminStatus == approval).toList();
    } else {
      return temp;
    }
  }

  List<SingleOrder> getSepeateOrderSubUser({required String approval}) {
    List<SingleOrder> temp = [];
    if (getloadedSupplierReqs != null) {
      return getloadedOrdersList!.data!.where((element) => element.userStatus == approval).toList();
    } else {
      return temp;
    }
  }

  bool isUpdatingStatus = false;
  bool get getisUpdatingStatus => isUpdatingStatus;
  setisUpdatingStatus(val) {
    isUpdatingStatus = val;
    notifyListeners();
  }

  TextEditingController userNoteController = TextEditingController();
  TextEditingController get getuserNoteController => userNoteController;

  setuserNoteController(String? val) {
    if (val == null) {
      userNoteController.clear();
    } else {
      userNoteController.text = val;
    }
    notifyListeners();
  }

  Future<void> updateOrderrRequest(context, {required String status, required SingleOrder item}) async {
    try {
      setisUpdatingStatus(true);

      FormData formData = FormData.fromMap({
        "user_status": status,
        "user_note": userNoteController.text,
      });
      final response = await CustomHttp.getDio().put(
        "$kSaveOrder/${item.id}",
        data: formData,
      );

      // var encoded = jsonEncode(response.data);
      dev.log(response.data.toString());

      // BaseModel temp = BaseModel.fromJson(jsonDecode(encoded));

      if (response.statusCode == 200 || response.statusCode == 201) {
        loadOrders(context, isSubUser: true);
        errorMessage(
          context,
          errorTxt: 'Request Updated',
          btnType: 3,
          buttons: [
            DialogButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ).show();
      } else {
        errorMessage(context, errorTxt: 'Error Updating').show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setisUpdatingStatus(false);
    }
  }
}
