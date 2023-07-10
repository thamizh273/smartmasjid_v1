




  import 'package:flutter/material.dart';

class Stxt extends StatelessWidget {
    const Stxt({Key? key,   this.weight, this.color,  this.textAlign, required this.text, required this.size,  }) : super(key: key);
    final String text;

    final FontWeight? weight;
    final Color? color;
    final double size;
    final TextAlign? textAlign;


    @override
    Widget build(BuildContext context) {
      return Text(text,style: TextStyle(fontWeight: weight,color: color,fontSize: size, fontFamily:'Rubik' ,),textAlign:textAlign ,);
    }
  }
