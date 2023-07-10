import 'dart:convert';



import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../Model/masjidFinderModel.dart';

class MasjidFinderController extends GetxController {
  final _restCallController = Get.put(restCallController());
  //TODO: Implement MasjidFinderController
 // var seller_list_model=SelllerListModel().obs;
  @override
  void onInit() {
    masjidFinder_get();
    filteredMasjidList = masjidList.obs;
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


  FocusNode searchFocusNode = FocusNode();
  Rx<TextEditingController> textEditingController = TextEditingController().obs;
  RxString selectedCountry = ''.obs;
  RxString selectedState = ''.obs;
  RxString selectedCity = ''.obs;

  RxBool isLoading =true.obs;

  var masjidListdata =MasjidFinderModel().obs;

  RxString searchQuery = ''.obs;
  List<Masjid> masjidList = [
    Masjid(name: 'Masjid-e-Nooraniah', location: 'Muthiyalpet', imagePath: 'assets/images/masjidselc.png'),
    Masjid(name: 'Masjid Al-Falah', location: 'New Town', imagePath: 'assets/images/masjidselc.png'),
    Masjid(name: 'Masjid Al-Huda', location: 'City Center', imagePath: 'assets/images/masjidselc.png'),
    Masjid(name: 'Masjid Al-Hakh', location: 'City Center', imagePath: 'assets/images/masjidselc.png'),
  ];

  RxList filteredMasjidList = [].obs;
  RxList<Masjid> filterMasjidsByName(String query) {
    return masjidList.where((masjid) => masjid.name.toLowerCase().contains(query.toLowerCase())).toList().obs;
  }

  masjidFinder_get() async {
    isLoading.value = true;
    var header = """
query Query(\$state: String) {
  get_masjid_filter(state_: \$state) {
    id
    masjid_name
    masjid_image
    area
  }
}
    """;
    var body = {
      "state": "pudhucherry"
    };
    var res =await _restCallController.gql_query(header, body);
    print("lllll");
    print(json.encode(res));
    print("lllll");
    isLoading.value = false;
    masjidListdata.value=masjidFinderModelFromJson(json.encode(res));

  }

}
class Masjid {
  final String name;
  final String location;
  final String imagePath;

  Masjid({required this.name, required this.location, required this.imagePath});
}