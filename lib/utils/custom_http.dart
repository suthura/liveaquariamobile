import 'dart:developer';
import 'dart:io';
import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/utils/context_helper.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class CustomHttp {
  static final Dio _dio = Dio();

  static Dio getDio() {
    var auth = Provider.of<AuthProvider>(ContextHelper.navigatorKey.currentContext!, listen: false);
    var token = auth.getloggedinUser == null ? "" : auth.getloggedinUser!.accessToken;
    log({token}.toString());
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // log(options.data.toString());
          // log(options.headers.toString());
          options.headers[HttpHeaders.contentTypeHeader] = "application/json";
          options.headers[HttpHeaders.acceptHeader] = "application/json";
          // options.headers['deviceId'] = await AuthProvider().getDeviceId();
          options.headers['Authorization'] = "Bearer $token";
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // Do something with response data
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          return handler.resolve(e.response!);
        },
      ),
    );
    return _dio;
  }
}
