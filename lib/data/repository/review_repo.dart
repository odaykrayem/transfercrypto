// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import '../../constants/api_constants.dart';
import '../../services/networking/api_client.dart';

class ReviewsRepo extends GetxService {
  final ApiClient apiClient;

  ReviewsRepo({
    required this.apiClient,
  });

  Future<Response> getReviewsList() async {
    return await apiClient.getData(ApiConstants.reviewsList);
  }

  Future<Response> addReview(Map<String, dynamic> data) async {
    return await apiClient.postData(ApiConstants.addReview, data);
  }
}
