import 'package:dropdown_search/dropdown_search.dart';

import '../app/routes/export.dart';

class safa_dropdown extends StatelessWidget {
  safa_dropdown({
    required this.items,
    this.hinttext,
    this.tittle,
    required this.onchanged,
    this.selecteditem,
    this.onsave,
    this.showSearchBox,
    this.height, this.isDense,
  });

  final List<String> items;
  final String? hinttext;
  final String? tittle;
  final String? selecteditem;
  final double? height;
  final bool? showSearchBox;
  final bool? isDense;
  final Function(String?)? onchanged;
  final Function(String?)? onsave;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stxt(
          text:  tittle ?? "", size: f2,color: Get.theme.colorScheme.primary,
        ),
        10.verticalSpace,
        DropdownSearch<String>(

            onSaved: onsave,
            selectedItem: selecteditem,
            popupProps: PopupProps.menu(

              constraints: BoxConstraints(maxHeight: height ?? 180),
              showSelectedItems: true,
              showSearchBox: showSearchBox ?? false,
              // searchFieldProps: TextFieldProps(
              //     decoration: InputDecoration(
              //   constraints: BoxConstraints(maxHeight: 30)
              // )),
              // itemBuilder: (context, item, isSelected) {
              //
              // },
              // title: Text("-----Select Priority-----"),
               listViewProps: ListViewProps(itemExtent:40,),
              // disabledItemFn: (String s) => s.startsWith('I'),
            ),
            items: items,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(

                  isDense:isDense??true,
                  enabledBorder: OutlineInputBorder(
                      gapPadding: 1,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Get.theme.colorScheme.primary)),
                  disabledBorder: OutlineInputBorder(
                      gapPadding: 1,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Get.theme.colorScheme.primary)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                  hintText: "$hinttext",
                  border: OutlineInputBorder(
                      gapPadding: 1,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color(0xffFF0000), width: 5))),
            ),
            onChanged: onchanged

            // selectedItem: "Brazil",
            ),
      ],
    );
  }
}
