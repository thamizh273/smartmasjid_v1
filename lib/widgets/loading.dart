import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../app/routes/export.dart';

class DialogHelper {
static Widget showLoading() {

  return  Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Get.theme.primaryColor,
        rightDotColor: Color(0xff7bbfcb),
        size: 80.w,
      ),
    );

 }}