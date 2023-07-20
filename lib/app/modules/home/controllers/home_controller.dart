import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/controllers/login_page_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../Model/getUserModel.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement HomeController
  final _restCallController = Get.put(restCallController());


  late TabController tabController;
  RxInt currentPage=0.obs;
  RxBool alarm = false.obs;
  RxBool isloading = false.obs;
  var getUserData=GetUserModel().obs;





  @override
  void onInit() {


    getUserDetails();
    tabController = TabController(length: 1, vsync: this);
    tabController.animation!.addListener(
          () {
        final value =  tabController.animation!.value.round();
        // if (value != currentPage && mounted) {
        //   changePage(value);
        // }
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  getUserDetails() async {

    isloading.value=true;
    var header="""
query Get_User_By_Id(\$id: String) {
  Get_User_By_Id(id_: \$id) {
    id
    profile_image
    auth_uid
    dob
    email_id
    first_name
    language
    last_name
    live_status
    masjid_id {
      id
      masjid_name
      state
      area
      about
      district
    }
    member_status
    phone_number
    post
    user_type
  }
}
    """;
    var body ={
      "id": "8c2b377a-c61a-4e3a-889d-f42294024a99"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;
    print("getUser");
   getUserData.value=getUserModelFromJson(json.encode(res));
    log(json.encode(res));
    print("getUser");

  }


  // void increment() => count.value++;
}
