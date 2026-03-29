import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../view/model/singel_booking_model.dart';

class BookingDetailsController extends GetxController {

  Rx<SingleBookingData?> singleBooking = Rx<SingleBookingData?>(null);
  RxBool isSingleBookingLoading = false.obs;

  Future<void> getSingleBooking({required String id}) async {

    try {
      isSingleBookingLoading.value = true;

      final response = await ApiClient.getData(ApiUrl.getSingleBooking(id: id),);

      final jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200) {

        final model = SingleBookingResponse.fromJson(jsonResponse);
        singleBooking.value = model.data;

      } else {
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to fetch booking", isError: true,);
      }

    } catch (e) {
      showCustomSnackBar(e.toString(), isError: true,);

    } finally {

      isSingleBookingLoading.value = false;
    }
  }
}