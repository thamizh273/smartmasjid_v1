import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class Safa_textfield extends StatelessWidget {
  const Safa_textfield({super.key, this.controller, this.hint, this.prefixIcon, this.suffixIcon, this.width, this.obscureText, this.keyboardType});


  final TextEditingController? controller;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final bool? obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.symmetric(vertical: 6.h),
      width: MediaQuery
              .of(context)
              .size
              .width * (width ?? 1),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("818F93"),
            hexStringToColor("3B555C"),
          ]),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(

        keyboardType: keyboardType??TextInputType.text,
        obscureText:obscureText??false ,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600),
        controller: controller,
// textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
         //  labelText: hint,
         // labelStyle: TextStyle(color:  Color(0xffB5C5CA)),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade400,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
// Change the border color for focused state
              width: 2.0, // Change the border width for focused state
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
