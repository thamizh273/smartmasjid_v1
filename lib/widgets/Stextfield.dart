import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/routes/export.dart';
import '../utils/color_utils.dart';

// class Safa_textfield extends StatelessWidget {
//   const Safa_textfield({
//     super.key,
//     this.label,
//     this.width,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.hint, this.controller, this.obscureText,
//   });
//
//   final String? label;
//   final String? hint;
//   final double? width;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool? obscureText;
//   final TextEditingController? controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         label == null
//             ? Container()
//             : Stxt(
//           text: label!,
//           size: 14,
//           weight: FontWeight.bold,
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         SizedBox(
//           width: MediaQuery
//               .of(context)
//               .size
//               .width * (width ?? 1),
//           child: Container(
//             padding: const EdgeInsets.all(1),
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   const Color(0xffD9D9D9),
//                   const Color(0xffD9D9D9).withOpacity(.1)
//                 ]),
//                 borderRadius: BorderRadius.circular(5)),
//             child: Container(
//               decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                       colors: [Color(0xff818F93), Color(0xff3B555C)]),
//                   borderRadius: BorderRadius.circular(5)),
//               child: TextField(
//                 controller: controller,
//                 obscureText: obscureText ?? false,
//                 style: TextStyle(
//                     color: Theme
//                         .of(context)
//                         .colorScheme
//                         .secondary,
//                     fontWeight: FontWeight.w500),
//                 decoration: InputDecoration(
//
//                     prefixIcon: prefixIcon,
//                     suffixIcon: suffixIcon,
//                     hintText: hint,
//
//                     // filled: true,
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                         borderRadius: BorderRadius.circular(5)),
//                     isDense: true,
//                     contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
//               ),
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
// }

class Safa_textfield extends StatefulWidget {
  Safa_textfield(
      {super.key,
      this.controller,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.width,
      this.obscureText,
      this.keyboardType,
      this.label,
      this.fillColor,
      this.length, this.readOnly, this.height, this.contentPad,
       // this.onChanged
      });

  final TextEditingController? controller;

  final String? hint;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final double? contentPad;
  final double? height;
  final bool? obscureText;
  final bool? readOnly;
  final int? length;
  final Color? fillColor;
  final TextInputType? keyboardType;
  //final Function(String?)? onChanged;


  @override
  State<Safa_textfield> createState() => _Safa_textfieldState();
}

class _Safa_textfieldState extends State<Safa_textfield> {
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    myFocusNode.removeListener(_onFocusChange);
    myFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {}); // Trigger a rebuild when focus changes
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      width: MediaQuery.of(context).size.width * (widget.width ?? 1),
      height: widget.height,
      // decoration:  BoxDecoration(
      //     gradient: LinearGradient(colors: [
      //       hexStringToColor("818F93"),
      //       hexStringToColor("3B555C"),
      //     ]),
      //     borderRadius: BorderRadius.circular(8)),
      child: TextField(
      //  onChanged: (value) => widget.onChanged!(value),
          readOnly:widget.readOnly??false ,
        focusNode: myFocusNode,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        obscureText: widget.obscureText ?? false,
        maxLength: widget.length ?? null,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600),
        controller: widget.controller,
// textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintStyle: TextStyle(),
          counterText: "",
          // labelText: widget.label,
          label:widget.label!=null? Container(
            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: myFocusNode.hasFocus ? Get.theme.primaryColor: null),
            child: Stxt(
              text: '${widget.label}',color: myFocusNode.hasFocus ?Colors.white:null,
              size: f2,
            ),
          ):null,
          // labelStyle: TextStyle( backgroundColor: myFocusNode.hasFocus?Colors.grey.shade300:null),
          hintText: widget.hint,
          filled: true,
          fillColor: widget.fillColor ?? Colors.grey.shade400,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
              color: myFocusNode.hasFocus?Get.theme.primaryColor:Colors.grey,
// Change the border color for focused state
              width: 2.0, // Change the border width for focused state
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: widget.contentPad?? 12),
        ),
      ),
    );
  }
}
