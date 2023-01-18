import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tourism/data/pojo/dynamic_data_response.dart';
import 'package:tourism/data/pojo/login_response.dart';
import 'package:tourism/data/pojo/pp_tc_faq_ab_response.dart';
import 'package:tourism/data/pojo/register_response.dart';
import 'package:tourism/data/pojo/vendors_response.dart';

import 'pojo/blog_response.dart';
import 'pojo/blogs_response.dart';
import 'pojo/dashboard_response.dart';
import 'pojo/my_images_response.dart';
import 'pojo/nearby_places_response.dart';
import 'pojo/vendor_response.dart';
import 'pojo/videos_detail_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://www.panchpokharitourism.com/api/")
abstract class APIService {
  factory APIService(Dio dio, {String baseUrl}) = _APIService;

  @GET("Public/AppInitial")
  Future<DashboardResponse> getDashboardData();

  @GET("public/NearPlaces")
  Future<NearbyPlacesResponse> getNearbyPlaces();

  @POST("Blog/GetAllBlog")
  Future<BlogsResponse> getAllBlogs(@Body() Map<String, dynamic> body);

  @GET("Blog/GetBlogById/{blogId}")
  Future<BlogResponse> getBlogById(@Path("blogId") String blogId);

  @POST("ImageVideo/GetAllImageList")
  Future<MyImagesResponse> getImages();

  @POST("ImageVideo/GetAllVideoList")
  Future<VideosDetailResponse> getVideos(@Body() Map<String, dynamic> body);

  @POST("Website/PPTCFAQ")
  Future<PpTcFaqAbResponse> getAppDetails(@Body() Map<String, dynamic> body);

  @POST("Vendor/GetVendorList")
  Future<VendorsResponse> getVendors(@Body() Map<String, dynamic> body);

  @GET("Vendor/GetVendorById/{vendorId}")
  Future<VendorResponse> getVendor(@Path("vendorId") String vendorId);

  @POST("Account/Register")
  Future<RegisterResponse> registerUser(@Body() Map<String, dynamic> body);

  @POST("Account/Login")
  Future<LoginResponse> loginUser(@Body() Map<String, dynamic> body);

  @POST("UserProfile/SaveUpdateUserProfile")
  Future<DynamicDataResponse> updateProfile(@Body() Map<String, dynamic> body);

  @GET("UserProfile/GetUserProfileById/{profileId}")
  Future<LoginResponse> getProfile(@Path("profileId") String profileId);
}
