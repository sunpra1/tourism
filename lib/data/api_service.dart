import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tourism/data/pojo/pp_tc_faq_ab_response.dart';

import 'pojo/blog_response.dart';
import 'pojo/blogs_response.dart';
import 'pojo/dashboard_response.dart';
import 'pojo/my_image_response.dart';
import 'pojo/nearby_places_response.dart';
import 'pojo/video_detail_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://www.panchpokharitourism.com/api/")
abstract class APIService {
  factory APIService(Dio dio, {String baseUrl}) = _APIService;

  @GET("Public/AppInitial")
  Future<DashboardResponse> getDashboardData();

  @GET("public/NearPlaces")
  Future<NearbyPlacesResponse> getNearbyPlaces();

  @GET("Blog/GetAllBlog")
  Future<BlogsResponse> getAllBlogs();

  @GET("Blog/GetBlogById/{blogId}")
  Future<BlogResponse> getBlogById(@Path("blogId") String blogId);

  @POST("ImageVideo/GetAllImageList")
  Future<MyImageResponse> getImages();

  @POST("ImageVideo/GetAllVideoList")
  Future<VideoDetailResponse> getVideos(@Body() Map<String, dynamic> body);

  @POST("Website/PPTCFAQ")
  Future<PpTcFaqAbResponse> getAppDetails(@Body() Map<String, dynamic> body);
}
