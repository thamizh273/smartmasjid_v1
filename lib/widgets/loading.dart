import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../app/routes/export.dart';

class DialogHelper {
static Widget showLoading() {

  return  Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Get.theme.colorScheme.secondary,
        rightDotColor: Get.theme.primaryColor,
        size: 80.w,
      ),
    );

 }}