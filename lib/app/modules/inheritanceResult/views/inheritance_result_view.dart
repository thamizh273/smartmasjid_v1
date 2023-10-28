
import '../../../routes/export.dart';
import '../controllers/inheritance_result_controller.dart';

class InheritanceResultView extends GetView<InheritanceResultController> {
  const InheritanceResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritanceResultView'),
        centerTitle: true,
      ),
      body:

    ListView(
            shrinkWrap: true,
            children: [
              (controller.argument[0]==0||controller.argument[0]==null)?
    ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Stxt(text: "husband ${index + 1} ${controller.argument[3]} ${controller.argument[4]}", size: f1);
        }
    ):ListView.builder(
                  shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.argument[0],
                  itemBuilder: (context, index) {
                    return Stxt(text: "Wife ${index + 1} ${controller.argument[1]} ${controller.argument[2]}", size: f1);
                  }
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.argument[5],
                  itemBuilder: (context, index) {
                    return Stxt(text: "son ${index + 1} ${controller.argument[6]} ${controller.argument[7]}", size: f1);
                  }
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.argument[8],
                  itemBuilder: (context, index) {
                    return Stxt(text: "daughter ${index + 1} ${controller.argument[9]} ${controller.argument[10]}", size: f1);
                  }
              ),
            ],
          ),


    );
  }
}
