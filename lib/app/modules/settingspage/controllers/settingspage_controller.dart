import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smartmasjid_v1/app/modules/language_page/controllers/language_page_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';


class SettingspageController extends GetxController {
  //TODO: Implement SettingspageController


  RxBool switchValue = ThemeService().isSavedDarkMode().obs;
  final langctl=Get.find<LanguagePageController>();
    var load=false.obs;
    loading(){
      load.value=true;
      update();
      Future.delayed(Duration(milliseconds: 200),() async{
       load.value=false;
       update();
      });
    }

    Future<void> sendEmail(String email, String subject, String body) async {
    String username = 'mbbasha@smasjid.com'; // Your Gmail email address
    String password = 'cwyp cxgy xwsx uuiz'; // Your Gmail password

    final smtpServer = gmail(username, password);

    final message = Message()
    ..from = Address(username)
      ..recipients.add(email)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. Error: $e');
    }
  }

  void shareApp() {
    const playStoreAppLink = "https://play.google.com/store/apps/details?id=com.safa.ummati";

    Share.share(
      'Check out this app on the Play Store: $playStoreAppLink',
      subject: 'Check out this app!',
      sharePositionOrigin: Rect.fromCenter(
        center: Offset(0, 0),
        width: 0,
        height: 50,
      ),
    );
  }



  @override
  void onInit() {
    langctl.selectedRadioIndex.value = langctl.langStore.read('selectedindex') ?? 0;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
