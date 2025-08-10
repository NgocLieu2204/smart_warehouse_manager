// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class DioClient {
//   static final Dio dio = Dio();
//   static final storage = const FlutterSecureStorage();

//   static void init() {
//     dio.options.baseUrl = "https://your-backend-api.com";
//     dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final token = await storage.read(key: 'firebase_token');
//         if (token != null) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         return handler.next(options);
//       },
//     ));
//   }
// }
