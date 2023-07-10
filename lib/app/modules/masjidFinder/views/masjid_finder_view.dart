import 'package:country_state_picker_plus/country_state_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../../widgets/space.dart';
import '../../../routes/app_pages.dart';
import '../controllers/masjid_finder_controller.dart';

class MasjidFinderView extends GetView<MasjidFinderController> {
  MasjidFinderView({Key? key}) : super(key: key);
  final MasjidFinderController c = Get.put(MasjidFinderController());

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
                    Column(
                      children: [
                        SvgPicture.asset("assets/svg/scanner.svg",),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Scan", style: TextStyle(color: Theme
                            .of(context)
                            .colorScheme
                            .secondary),)
                      ],
                    ),
                  ],
                ),
              ),
              Text("Select Your Masjid", style: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .secondary, fontWeight: FontWeight.w600, fontSize: 20),),
              SizedBox(
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
                          padding: const EdgeInsets.only(left: 16, right: 16,),
                          child: CountryStatePickerPlus(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            countryHintText: "Select Country",
                            stateHintText: 'Select State',
                            cityHintText: 'Select City',
                            dropdownColor: Theme
                                .of(context)
                                .colorScheme
                                .secondary,
                            style: TextStyle(fontSize: 12, color: Theme
                                .of(context)
                                .colorScheme
                                .primary, fontWeight: FontWeight.w600),
                            onCityChanged: (value) {
                              c.selectedCity.value = value;
                            },
                            onCountryChanged: (value) {
                              c.selectedCountry.value = value;
                            },
                            onStateChanged: (value) {
                              c.selectedState.value = value;
                              c.update();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Obx(() {
                        return Text(
                          '${c.selectedCountry.value}  ${c
                              .selectedState.value} ${c.selectedCity
                              .value}',
                          style: TextStyle(fontSize: 12, color: Theme
                              .of(context)
                              .colorScheme
                              .secondary),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('OR', style: TextStyle(color: Theme
                        .of(context)
                        .colorScheme
                        .secondary, fontSize: 12),),
                  ),
                  Expanded(child: Divider(color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,)),
                ],
              ),
              SizedBox(
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
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Obx(() {
                  return TextField(
                    focusNode: c.searchFocusNode,
                    autofocus: false,

                    // textInputAction: TextInputAction.search,
                    controller: c.textEditingController.value,
                    style: TextStyle(color: Theme
                        .of(context)
                        .colorScheme
                        .primary, fontWeight: FontWeight.w600),
                    // textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      c.searchQuery.value = value;
                      c.filteredMasjidList.value =
                          c.filterMasjidsByName(value);

                      if (value.isEmpty) {
                        c.textEditingController.value.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },

                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 12),
                      hintText: 'Search by Masjid Name',
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
                          width: 2.0, // Change the border width for focused state
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 1),
                        child: IconButton(onPressed: () {
                          FocusScope.of(context).requestFocus(
                              c.searchFocusNode);
                        }, icon: Icon(Icons.search, size: 25,),),
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Searching Results",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 400,
                                child: c.masjidList.isEmpty
                                    ? SvgPicture.asset(
                                    "assets/svg/showmasjid.svg")
                                    :
                                ListView.builder(
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemCount: c.masjidListdata.value.getMasjidFilter!.length,
                                       // Number of cards
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    var masjid = c.masjidListdata.value.getMasjidFilter![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Card(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(8)
                                                  ),
                                                  child: Image.asset(
                                                    masjid.masjidImage.toString(),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        masjid.masjidName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight
                                                                .w600),
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
                                                  Text(masjid.area.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12),),
                                                  SizedBox(height: 10),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .primary,
                                                      foregroundColor: Colors
                                                          .white,
                                                      fixedSize: Size(120, 35),
                                                    ),
                                                    onPressed: () {
                                                      c.masjidFinder_get();
                                                      // Get.toNamed(
                                                      //     Routes.LOGIN_PAGE);
                                                      //  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidRequestPage()));
                                                    },
                                                    child: Text("Join Masjid",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            fontSize: 14)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
}
