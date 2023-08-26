import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/familybg.dart';
import 'package:smartmasjid_v1/widgets/small_bg_tree.dart';

import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/familytree_controller.dart';

class FamilytreeView extends GetView<FamilytreeController> {
  const FamilytreeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Family Tree",
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

                            return        Container(
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
                                    child: Center(child: Text("Sameera", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.brown),))),
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
                          child: Center(child: Text("Sameera", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.brown),))),
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
                          child: Center(child: Text("Abdullah", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.brown),))),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                      },
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
