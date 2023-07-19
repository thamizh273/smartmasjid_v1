import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/controllers/login_page_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../rest_call_controller/rest_call_controller.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement HomeController
  final _restCallController = Get.put(restCallController());


  late TabController tabController;
  RxInt currentPage=0.obs;
  RxBool alarm = false.obs;
  RxBool isloading = false.obs;


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
    query Query(\$id: String) {
  Get_User_By_Id(id_: \$id) {
    id
    first_name
    email_id
    dob
    auth_uid
    language
    last_name
    live_status
    masjid_id {
      masjid_name
    }
    phone_number
    pass_word
    post
    profile_image
    user_type
    member_status
  }
}
    """;
    var body ={
      "id": "1dda1ece-6f81-497c-86fd-b28074c00389"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;
    print("getUser");

    log(json.encode(res));
    print("getUser");
  }


  // void increment() => count.value++;
}
