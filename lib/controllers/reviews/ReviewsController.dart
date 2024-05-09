// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/repository/review_repo.dart';
import '../../models/response_model.dart';
import '../../models/review_model.dart';
import '../../services/networking/print_response_info.dart';
import '../home/HomeController.dart';

class ReviewsController extends GetxController {
  final ReviewsRepo repo;

  ReviewsController({
    required this.repo,
  });

  ReviewModel? _selectedReviewModel;
  ReviewModel? get selectedReviewModel => _selectedReviewModel;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getReviewsList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<ReviewModel> _reviewsList = [];
  List<ReviewModel> get reviewsList => _reviewsList;

  double _ratingZero = 0;
  double get ratingZero => _ratingZero;

  double _ratingOne = 0;
  double get ratingOne => _ratingOne;

  double _ratingTwo = 0;
  double get ratingTwo => _ratingTwo;

  double _ratingThree = 0;
  double get ratingThree => _ratingThree;

  double _ratingFour = 0;
  double get ratingFour => _ratingFour;

  double _ratingFive = 0;
  double get ratingFive => _ratingFive;

  double _ratingCount = 200;
  double get ratingCount => _ratingCount;

  double _allRating = 5.0;
  double get allRating => _allRating;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  bool _addLoading = false;
  bool get addLoading => _addLoading;
  bool _errorLoading = false;
  bool get errorLoading => _errorLoading;
  HomeController homeController = Get.find<HomeController>();

  // final commentContoller = TextEditingController();
  double _userRating = 1;
  double get userRating => _userRating;
  void setUserRating(double userRating) {
    _userRating = userRating;
    update();
  }

  Future<void> getReviewsList() async {
    _errorLoading = false;
    _isLoaded = false;

    try {
      Response response = await repo.getReviewsList();
      printResponseInfo(response, "Reviews List");
      debugPrint('userrrr :: ${response.body['data'][0]['user']['f_name']}');
      if (response.statusCode == 200) {
        _reviewsList = []; //initialze to not repeat data
        _ratingZero = response.body['0'] as double;
        _ratingOne = response.body['1'] as double;
        _ratingTwo = response.body['2'] as double;
        _ratingThree = response.body['3'] as double;
        _ratingFour = response.body['4'] as double;
        _ratingFive = response.body['5'] as double;

        _ratingCount = response.body['count'] as double;
        _allRating = response.body['all_rating'] as double;

        List<dynamic> map = response.body['data'];
        _reviewsList =
            map.map((elemnt) => ReviewModel.fromMap(elemnt)).toList();

        _reviewsList.forEach((element) {
          debugPrint(element.toString());
        });
        _isLoaded = true;
        update();
      } else if (response.statusCode == 500) {
        if ('${response.body}'.contains('Route [login] not defined')) {
          homeController.logout();
        }
      } else {
        debugPrint('reviews controller : could not get ');
        _errorLoading = true;
        _isLoaded = true;
        update();
      }
    } catch (e) {
      debugPrint('catch Error ${e.toString()}');
      e.printInfo();
      e.printError();
      _errorLoading = true;
      _isLoaded = true;
      update();
    }
  }

  Future<ResponseModel> addReview(String comment) async {
    _addLoading = true;
    update();
    Map<String, dynamic> data = {
      "content": comment,
      "rating": _userRating,
      "date": DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()),
    };
    late ResponseModel responseModel;
    try {
      Response response = await repo.addReview(data);
      // printResponseInfo(response, 'Add transaction');
      if (response.statusCode == 200 || response.statusCode == 201) {
        responseModel = ResponseModel(true, 'sucess'.tr);
        getReviewsList();
      } else if (response.statusCode == 500) {
        if ('${response.body}'.contains('Route [login] not defined')) {
          homeController.logout();
        }
      } else {
        responseModel = ResponseModel(false, response.statusText!);
        debugPrint('failed add transaction');
      }
      _addLoading = false;
      update();

      return responseModel;
    } catch (e) {
      _addLoading = false;
      update();
      responseModel = ResponseModel(false, 'error');
      debugPrint('error add transaction ${e.toString()}');
      e.printError();
    }
    return responseModel;
  }
}
