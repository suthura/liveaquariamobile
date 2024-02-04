import 'dart:convert';

import 'package:aquaria_mobile/models/advertisement_model.dart';
import 'package:aquaria_mobile/models/main_item_model.dart';
import 'package:aquaria_mobile/models/sup_req_model.dart';
import 'package:aquaria_mobile/utils/custom_http.dart';
import 'package:aquaria_mobile/utils/error_messages.dart';
import 'package:aquaria_mobile/utils/url_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as dev;

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
}
