
import 'package:dio/dio.dart';

import '../local/cache_helper.dart';
import 'end_points.dart';


//Dio Helper That's Connect and Talk to API.
class DioHelper {
  static late Dio dio;

  //Here The Initialize of Dio and Start Connect to API Using baseUrl.
  static init() {
    dio = Dio(
      BaseOptions(
        //Here the URL of API.
        baseUrl: baseUrl,

        //   receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Accept': 'application/json',
          //'lang':'en'
        },
      ),
    );
  }

  //This Function to call API and get Some Data based on url(End Points) and Headers needed in API to get the Specific Data.
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept-Language' : CacheHelper.get(key: "locale") == 'en_EN' ? 'en' : 'ar',
      };
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //This Function that's Used To Post Data to API based on URL(End Points) and Headers.
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    FormData? formData,
    //bool files = false,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept-Language' : CacheHelper.get(key: "locale") == 'en_EN' ? 'en' : 'ar',
        'Content-Type' : data != null ? "application/json": 'multipart/form-data'
      };
      final Response response = await dio.post(
        url,
        data: data ?? formData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }

  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    //bool files = false,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept-Language' : CacheHelper.get(key: "locale") == 'en_EN' ? 'en' : 'ar',
      };
      final Response response = await dio.put(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }

  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
    bool files = false,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      // 'Authorization': token ,
      'Accept-Language' : CacheHelper.get(key: "locale") == 'en_EN' ? 'en' : 'ar',
      'Content-Type': 'application/json',
    };
    return await dio.patch(
      url,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    //String lang = 'en',
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Accept-Language' : CacheHelper.get(key: "locale") == 'en_EN' ? 'en' : 'ar',
        // 'Authorization': token ,
        //'Content-Type': 'application/json',
      };
      final Response response = await dio.delete(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }

  }


  Future<void> cacheLanguageCode(String languageCode) async {
    CacheHelper.set(key: "LOCALE", value: languageCode);

  }


  Future<String> getCachedLanguageCode() async {

    final cachedLanguageCode = CacheHelper.get(key: "LOCALE");
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return "ar";
    }
  }
}