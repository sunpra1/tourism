import 'package:dio/dio.dart';
import 'package:tourism/utils/network_interceptor.dart';

class Utils {
  static Dio getDioWithInterceptor() {
    Dio dio = Dio();
    Interceptor interceptor = NetworkInterceptor();
    dio.interceptors.add(interceptor);
    return dio;
  }
}
