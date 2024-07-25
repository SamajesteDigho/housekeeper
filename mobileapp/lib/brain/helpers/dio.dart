import 'dart:io';

import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GETX;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:housekeeper/brain/constants/strings.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppStrings.baseServerURL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options = options);
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (DioException e, handler) {
        // EasyLoading.dismiss();
        ErrorEntity eInfo = createErrorEntity(e);
        print('[ERROR (${eInfo.code})] : ${eInfo.message}');
        // MySnackBar.failureSnackBar(
        //   title: '',
        //   message: eInfo.message,
        // );
        // return handler.next(e);
      }),
    );
  }

  createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: 'Request Cancelled');
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -1, message: 'Connection TimeOut'.tr);
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -1, message: 'Sending TimeOut'.tr);
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -1, message: 'Receiving TimeOut'.tr);
      case DioExceptionType.values:
        {
          try {
            int errCode = error.response != null ? error.response!.statusCode! : -1;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: error.response!.data['message'] ?? 'Bad Request');
              case 401:
                return ErrorEntity(code: errCode, message: error.response!.data['message'] ?? 'Unauthorized Request');
              case 403:
                return ErrorEntity(code: errCode, message: "Forbidden Action");
              case 404:
                return ErrorEntity(
                  code: errCode,
                  message: error.response!.data['message'] ?? 'Resource could not be found',
                );
              case 405:
                return ErrorEntity(code: errCode, message: "Method Not Allowed");
              case 500:
                return ErrorEntity(code: errCode, message: error.response!.data['message'] ?? 'Something went wrong');
              case 502:
                return ErrorEntity(code: errCode, message: "Bad Gateway");
              case 503:
                return ErrorEntity(code: errCode, message: "Service Unavailable");
              case 505:
                return ErrorEntity(code: errCode, message: "HTTP Version Not Supported");
              default:
                {
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? 'Something went wrong' // error.response!.data ?? error.response?.statusMessage
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: '(EXCEPTION) Unknown error. Request abandoned');
          }
        }
      default:
        return ErrorEntity(
          code: -1,
          message: error.response == null ? '(DEFAULT) Unpredicted Failure' : '(DEFAULT) ${error.response}',
        );
    }
  }

  onError(ErrorEntity eInfo) {
    GETX.Get.snackbar(
      "",
      eInfo.message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      dismissDirection: DismissDirection.horizontal,
      icon: const Icon(Icons.phonelink_erase_rounded),
    );
  }

  void cancelRequest(CancelToken token) {
    token.cancel("Request Canceled");
  }

  /// =======================================================
  /// RESTFUL API to the Server
  /// ======================================================
  Future get(String path,
      {Map<String, dynamic>? queryParams,
      Options? options,
      bool refresh = false,
      bool noCache = true,
      bool list = false,
      String cacheKey = '',
      bool cacheDisk = false}) async {
    print("Requesting [GET] ${AppStrings.baseServerURL}$path");
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!
        .addAll({"refresh": refresh, "noCache": noCache, "list": list, "cacheKey": cacheKey, "cacheDisk": cacheDisk});
    requestOptions.headers = requestOptions.headers ?? {};
    var response = await dio.get(
      path,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    print("Requesting [POST] ${AppStrings.baseServerURL}$path");
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

//   Future put(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//     var response = await dio.put(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     return response.data;
//   }
//
//   Future patch(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//     var response = await dio.patch(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     return response.data;
//   }
//
//   Future delete(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     var response = await dio.delete(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     return response.data;
//   }
//
//   /// restful post form
//   Future postForm(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//     var response = await dio.post(
//       path,
//       data: FormData.fromMap(data),
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     return response.data;
//   }
//
//   Future postStream(
//     String path, {
//     dynamic data,
//     int dataLength = 0,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//     /*Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }*/
//     requestOptions.headers!.addAll({
//       Headers.contentLengthHeader: dataLength.toString(),
//     });
//     var response = await dio.post(
//       path,
//       data: Stream.fromIterable(data.map((e) => [e])),
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     return response.data;
//   }
// }
//
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "[EXCEPTION]: code ($code) ==> $message";
  }
}
