import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_state_picker_plus/country_state_picker_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartmasjid_v1/app/authRepository.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';


import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/bgcontainer_auth.dart';


import '../../../routes/app_pages.dart';
import '../controllers/masjid_finder_controller.dart';
import 'barcodeQrPage.dart';

class MasjidFinderView extends StatelessWidget {
  MasjidFinderView({Key? key}) : super(key: key);
  final MasjidFinderController c = Get.put(MasjidFinderController());
  final SignupPageController singctrl = Get.put(SignupPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGContainerAuth(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Space(16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(barcodeQrScanner());
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/scanner.svg",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Scan".tr,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "select_your_masjid".tr,
                style: TextStyle(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade400,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child:  CountryStatePickerPlus(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              countryHintText: "select_country".tr,
                              stateHintText: 'select_state'.tr,
                              cityHintText: 'select_city'.tr,
                              dropdownColor:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  fontWeight: FontWeight.w600),
                              onCityChanged: (value) {
                                c.selectedCity.value = value;
                                c.masjidFinder_get(value,"");
                                c.update();
                              },
                              onCountryChanged: (value) {
                                c.searchctrl_.value.text = "";
                                c.selectedCountry.value = value;
                                c.masjidFinder_get("null","");
                                c.update();
                              },
                              onStateChanged: (value) {
                                c.selectedState.value = value;
                                c.masjidFinder_get("null","");
                                c.update();
                              },
                            ),

                        ),
                      ),
                      SizedBox(height: 16.0),
                      Obx(() {
                        return Text(
                          '${c.selectedCountry.value}  ${c.selectedState
                              .value} ${c.selectedCity.value}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Divider(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'or'.tr,
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .secondary,
                          fontSize: 12),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 40,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      hexStringToColor("818F93"),
                      hexStringToColor("3B555C"),
                    ]),
                    borderRadius: BorderRadius.circular(8)),
                child: Obx(() {
                  return TextField(
                    focusNode: c.searchFocusNode,
                    autofocus: false,

                    // textInputAction: TextInputAction.search,
                    controller: c.searchctrl_.value,
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        fontWeight: FontWeight.w600),
                    // textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    onTap: () {
                      c.masjidListdata.value.getMasjidFilter = null;
                      c.selectedCity.value = "";
                      c.selectedCountry.value = "";
                      c.selectedState.value = "";
                    },
                    onChanged: (value) {
                      c.searchQuery.value = value;

                      c.masjidFinder_get(value,"");
                      c.update();
                      // Future.delayed(Duration(milliseconds: 500),(){
                      //   c.isLoading.value=true;
                      //   c.update();
                      // });
                      // c.isLoading.value=false;

                      // c.searchQuery.value = value;
                      // // c.filteredMasjidList.value =
                      // // c.masjidListdata.value.getMasjidFilter!;
                      //
                      // if (value.isEmpty) {
                      //   c.searchctrl_.value.clear();
                      //   FocusScope.of(context).unfocus();
                      // }
                    },

                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 12),
                      hintText: 'search_by_masjid_name'.tr,
                      // label: Text("Search by Masjid Name", style: TextStyle(fontSize: 12),),
                      filled: true,
                      fillColor: Colors.grey.shade400,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          // Change the border color for focused state
                          width:
                          2.0, // Change the border width for focused state
                        ),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 1),
                        child: IconButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(c.searchFocusNode);
                          },
                          icon: Icon(
                            Icons.search,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    // onSubmitted: (value) {
                    //   if (value.isEmpty) {
                    //     _textEditingController.clear();
                    //     FocusScope.of(context).unfocus();
                    //   }
                    // },
                  );
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 12.h, right: 12.h, left: 12.h, bottom: 5.h),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "searching_results".tr,
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              SizedBox(height: 10.h),
                              Obx(() {
                                return Container(
                                  height: .52.sh,
                                  child: (c.selectedCity.value.isEmpty &&
                                      c.searchQuery.value.isEmpty)
                                      ? Image.asset(
                                      "assets/images/selectmasjid_img.png")
                                      : c.isLoading.value
                                      ?  DialogHelper.showLoading()
                                      : ((c.masjidListdata.value
                                      .getMasjidFilter == null)
                                      ? Center(
                                      child: Stxt(
                                        text: "no data",
                                        size: f3,
                                        color: Get.theme.colorScheme
                                            .secondary,
                                      ))
                                      : buildListView()),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: c.masjidListdata.value.getMasjidFilter!.length,
      // Number of cards
      itemBuilder: (BuildContext context, int index) {
        var masjid = c.masjidListdata.value.getMasjidFilter![index];
        print("ssssssss");
        return Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Image.asset("assets/images/masjidselc.png"
                        // masjid.masjidImage.toString(),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            masjid.masjidName.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Icon(Icons.more_vert_outlined),
                          //   ],
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        masjid.area.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                          Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          foregroundColor: Colors.white,
                          fixedSize: Size(120, 35),
                        ),
                        onPressed: () {
                          var id =
                              c.masjidListdata.value.getMasjidFilter![index].id;

                          Get.dialog(
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: AlertDialog(
                                    insetPadding: EdgeInsets.zero,
                                    contentPadding: EdgeInsets.zero,
                                    elevation: 10,
                                    backgroundColor: Get.theme.colorScheme
                                        .primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    // title: Center(
                                    //     child: Stxt(
                                    //   text: "Are you Sure?",
                                    //   size: f3,
                                    //   weight: FontWeight.bold,
                                    //   color: Colors.white,
                                    //   textAlign: TextAlign.center,
                                    // )),

                                    // contentPadding: EdgeInsets.symmetric(vertical: 20.h,),
                                    title: SizedBox(
                                      height: 80.h,
                                      width: 90.w,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          AutoSizeText(
                                            textAlign: TextAlign.center,
                                            "are_you_sure_want_to_join".tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),
                                            // size: f3,
                                            // // weight: FontWeight.bold,
                                            // color: Colors.white,
                                            // textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 8,),
                                          AutoSizeText( "${c.masjidListdata.value.getMasjidFilter![index].masjidName} ?",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),
                                            // size: f3,
                                            // weight: FontWeight.bold,
                                            // color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                    actionsPadding: EdgeInsets.only(bottom: 20),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          SButton(
                                              width: 90.w,
                                              height: 25.h,
                                              color: Get.theme.colorScheme
                                                  .secondary,
                                              ontap: () {
                                                Get.back();
                                              },
                                              text: "cancel".tr,
                                              txtsize: f1,
                                              txtClr:
                                              Get.theme.colorScheme.primary),
                                          SButton(
                                              height: 25.h,
                                              width: 90.w,
                                              ontap: () async {

                                                if(AuthenticationRespository.instance.gsignBool.value==false){
                                                  await c.signUpComplete(id);
                                                  //await c.loginGmail(id)(id);
                                                }else{
                                                  await c.loginGmail(id);}
                                                await GoogleSignIn().signOut();
                                                await FirebaseAuth.instance.signOut();
                                                // else{
                                                //   await c.signUpComplete(id);
                                                // }


                                                c.update();
                                              },
                                              text: "confirm".tr,
                                              txtsize: f1,
                                              txtClr:
                                              Get.theme.colorScheme.primary),
                                        ],
                                      )
                                    ],
                                    //iconPadding: EdgeInsets.all(20),
                                  )
                              )
                          );

                          // Get.defaultDialog(
                          //
                          // backgroundColor: Get.theme.colorScheme.primary,
                          // titleStyle: TextStyle(color: Colors.white),
                          // title: "Are you sure?",
                          // content: Stxt(
                          // text:
                          // "${c.masjidListdata.value.getMasjidFilter![index].masjidName}",
                          // size: f3,
                          // color: Colors.white,
                          // weight: FontWeight.bold,
                          // ),
                          //
                          // onCancel: () =>
                          // Navigator.popUntil(context, (route) => true),
                          // onConfirm: () {
                          // c.signUpComplete(id);
                          // c.update();
                          // Get.offAllNamed(Routes.REQUEST_MASJID);
                          // },
                          // );

                          // c.masjidFinder_get();
                          // Get.toNamed(
                          //     Routes.LOGIN_PAGE);
                          //  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidRequestPage()));
                        },
                        child: Text("join_masjid".tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
