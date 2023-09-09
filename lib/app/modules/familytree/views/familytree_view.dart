import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/familytree/views/fullfamily_tree_view.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';
import 'package:smartmasjid_v1/widgets/familybg.dart';
import 'package:smartmasjid_v1/widgets/small_bg_tree.dart';

import '../../../../widgets/space.dart';
import '../../../routes/app_pages.dart';
import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/familytree_controller.dart';

class FamilytreeView extends GetView<FamilytreeController> {
  const FamilytreeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "family_tree".tr,
        action: [
          InkWell(onTap: (){Get.to(FullfamilyTreeView());},child: SvgPicture.asset("assets/svg/familygen.svg")),
          Space(20),
        ],
      ),
      body: FamilyBG(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: .1.sh),
              SizedBox(
                height: .4.sh,
                child: CustomScrollView(
                  reverse: true,
                  shrinkWrap: true,
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.2,

                        ///no.of items in the horizontal axis
                        crossAxisCount: 3,
                      ),

                      ///Lazy building of list
                      delegate: SliverChildBuilderDelegate(
                        addSemanticIndexes: false,
                        childCount: 9,
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox1();
                                },
                              );
                            },
                            child: Container(
                              width: 115,
                              height: 115,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/familytxt.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    width: .18.sw,
                                    child: Center(
                                        child: Text(
                                      "Sameera",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.brown),
                                    ))),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: .38.sh,
                child: Column(
                  children: [
                    Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/familytxt.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: .18.sw,
                            child: Center(
                                child: Text(
                              "Sameera",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown),
                            ))),
                      ),
                    ),
                    Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/familytxt.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: .18.sw,
                            child: Center(
                                child: Text(
                              "Abdullah",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown),
                            ))),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4.0,
                        ),
                        child: Text(
                          "Add Family Member",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: clr_white),
                        )),
                    10.verticalSpace
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialogBox1 extends StatelessWidget {
  final TextEditingController pass = TextEditingController();
  final TextEditingController c = TextEditingController();

  CustomDialogBox1({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
                color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset("assets/images/picdr.png"),
                  ),
                ),
                Space(4),
                Stxt(
                  text: "Sameera",
                  size: f4,
                  color: Colors.white,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Space(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stxt(text: "Father Name :", size: f3),
              Stxt(text: "Abdullah", size: f3),
            ],
          ),
          Space(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stxt(text: "Gender :", size: f3),
              Space(16),
              Stxt(text: "Male", size: f3),
            ],
          ),
          Space(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stxt(text: "Age :", size: f3),
              Space(16),
              Stxt(text: "45", size: f3),
            ],
          ),
          Space(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stxt(text: "Marital Status :", size: f3),
              Space(16),
              Stxt(text: "Married", size: f3),
            ],
          ),
          Space(16),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox();
                },
              );
            },
            child: Container(
              height: 35.h,
              width: 140.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    Space(8),
                    Stxt(
                      text: "Edit Details",
                      size: f3,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Space(16),
        ],
      ),
    );
  }
}

class CustomDialogBox extends StatelessWidget {
  final TextEditingController pass = TextEditingController();
  final TextEditingController c = TextEditingController();

  CustomDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 50.h,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Stxt(
                      text: "Edit Family Member",
                      size: f4,
                      color: Colors.white,
                      weight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.close,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Space(16),
            CircleAvatar(
              radius: 50,
              child: Image.asset("assets/images/picdr.png"),
            ),
            Space(4),
            Stxt(
              text: "Edit Profile Picture",
              size: f3,
              color: Theme.of(context).primaryColor,
              weight: FontWeight.w600,
            ),
            Space(16),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  Stxt(
                    text: "Name*",
                    size: f4,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Safa_textfield(
                hint: "Enter Your Name",
                fillColor: Colors.white,
              ),
            ),
            Space(8),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stxt(
                    text: "Age*",
                    size: f4,
                    color: Colors.black,
                  ),
                  Stxt(
                    text: "Gender*",
                    size: f4,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Container(
                    width: 110.w,
                    child: Safa_textfield(
                      hint: "Enter Age",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Container(
                    width: 110.w,
                    child: Safa_textfield(
                      hint: "Enter Gender",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  Stxt(
                    text: "Marital Status*",
                    size: f4,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Safa_textfield(
                hint: "Enter Your status",
                fillColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  Stxt(
                    text: "Relationship",
                    size: f4,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Safa_textfield(
                hint: "Enter Your relation  ",
                fillColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  Stxt(
                    text: "Bio",
                    size: f4,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Container(
                height: 200,
                child: Safa_textfield(
                  hint: "",
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
