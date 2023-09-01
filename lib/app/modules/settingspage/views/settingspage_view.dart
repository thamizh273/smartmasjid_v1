import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/language_page/views/language_page_view.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../../language_page/controllers/language_page_controller.dart';
import '../controllers/settingspage_controller.dart';

class SettingspageView extends GetView<SettingspageController> {
  SettingspageView({Key? key}) : super(key: key);
  final con = Get.put(LanguagePageController());

  List<Settings> settingsList = [
    Settings(image: "assets/svg/thememode.svg", text: "Language",)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: 'settings'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svg/thememode.svg"),
                Space(16),
                Text("dark_Mode".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                Spacer(),
                Obx(() {
                  return Switch(
                    value: controller.switchValue.value,
                    onChanged: (newValue) {
                      controller.switchValue.value = newValue;
                      ThemeService().changeTheme();

                    },
                  );
                }),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Space(16),
            GestureDetector(
              onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (_) => LanguagePageView()));
              },
              child: Container(
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/language.svg"),
                    Space(16),
                    Text("language".tr,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Space(16),
            Row(
              children: [
                SvgPicture.asset("assets/svg/feedback.svg"),
                Space(16),
                Text("feedback".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Space(16),
            Row(
              children: [
                SvgPicture.asset("assets/svg/contact.svg"),
                Space(16),
                Text("contact".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Space(16),
            Row(
              children: [
                SvgPicture.asset("assets/svg/rating.svg"),
                Space(16),
                Text("rate_our_app".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Space(16),
            Row(
              children: [
                SvgPicture.asset("assets/svg/version.svg"),
                Space(16),
                Text("version".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Space(16),
            Row(
              children: [
                SvgPicture.asset("assets/svg/share.svg"),
                Space(16),
                Text("share".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class Settings {
  String? image;
  String? text;

  Settings({
    this.image,
    this.text,
  });
}