import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/loading.dart';
import '../../../routes/export.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/activitiespage_controller.dart';

class ActivitiespageView extends GetView<ActivitiespageController> {
  ActivitiespageView({Key? key}) : super(key: key);

  final activityCtrl_ = Get.put(ActivitiespageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "activities".tr,
        ),
        body: Obx(() {
          return activityCtrl_.isloadingtrans.value
              ? loading(context)
              : Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: StickyGroupedListView(
                    physics: BouncingScrollPhysics(),
                    elements: activityCtrl_
                        .tansactionHistoryData.value.getTransactionHistory!,
                    order: StickyGroupedListOrder.ASC,
                    groupBy: (element) =>
                        DateTime(element.processDate!.year,element.processDate!.month,element.processDate!.day),
                    groupComparator: (DateTime value1, DateTime value2) =>
                        value2.compareTo(value1),
                    itemComparator: (element1, element2) =>
                        (element1.processDate!).compareTo(element2.processDate!),
                    floatingHeader: true,
                    groupSeparatorBuilder: _getGroupSeparator,
                    itemBuilder: _getItem,
                  ),
                );
        }));
  }

  Widget _getGroupSeparator(element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(top: 4),
          width: 120,
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border.all(
              color: Get.theme.primaryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Stxt(
              text:
                  '${element.processDate!.day}/${element.processDate!.month}/${element.processDate!.year}',
              size: f2,
              color: clr_white,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem(BuildContext ctx, element) {
    var icons=['donate','servicedr','donate','donate',];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.0),
      child: SizedBox(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.0),
          leading:iconss(ctx,element),

          //subtitle: Text('${element.date.hour}:00'),
          subtitle: Stxt(text:  DateFormat.jm().format(
              DateTime.parse(
                  "${element.processDate!.toLocal()}")), size: f2),

          title: Stxt(
              text: '${element.transactionMessage} to ${element.receiverName}',
              size: f3,
              weight: FontWeight.w500),
          trailing: Stxt(
              text: "-${element.transactionAmount}",
              size: f4,
              weight: FontWeight.bold,
              color: clr_red),
        ),
      ),
    );
  }
  Widget iconss( ctx,element) {


    if (element.transactionMessage.contains("Membership")) {
      // Widget to display when the condition is true
      return SvgPicture.asset("assets/svg/donate.svg",height: 30.h,);
    } else if (element.transactionMessage.contains("Donation")) {
      // Widget to display when the condition is true
      return SvgPicture.asset("assets/svg/memberdr.svg",height: 30.h);
    } else if (element.transactionMessage.contains("Service")) {
      // Widget to display when the condition is true
      return SvgPicture.asset("assets/svg/servicedr.svg",height: 32.h);
    }else {
      // Widget to display when the condition is false
      return SvgPicture.asset("assets/svg/wallet.svg",height: 30.h);
    }
  }
}
