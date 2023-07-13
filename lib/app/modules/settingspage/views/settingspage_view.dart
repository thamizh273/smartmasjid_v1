import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/settingspage_controller.dart';

class SettingspageView extends GetView<SettingspageController> {
  SettingspageView({Key? key}) : super(key: key);

  List<Settings> settingsList = [
    Settings(image: "assets/svg/thememode.svg", text: "Language",)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: 'Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svg/thememode.svg"),
                Space(16),
                Text("Dark Mode",
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
            Row(
              children: [
                SvgPicture.asset("assets/svg/language.svg"),
                Space(16),
                Text("Language",
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
                SvgPicture.asset("assets/svg/feedback.svg"),
                Space(16),
                Text("Feedback",
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
                Text("Contact",
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
                Text("Rate our app",
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
                Text("Version",
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
                Text("Share Smart Masjid 2.0",
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