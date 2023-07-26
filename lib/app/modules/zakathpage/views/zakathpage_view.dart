import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/views/home_view.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';

import '../../../../widgets/bgcontainer.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/waiting_dialog.dart';
import '../../../routes/app_pages.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/zakathpage_controller.dart';

class ZakathpageView extends StatefulWidget {
  ZakathpageView({Key? key}) : super(key: key);

  @override
  State<ZakathpageView> createState() => _ZakathpageViewState();
}

class _ZakathpageViewState extends State<ZakathpageView> {
  Map<String, double> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "Zakath Calculator",
        ),
        body: FrostedBottomBar(
          width: 330.w,
          opacity: .8,
          sigmaX: 10,
          sigmaY: 10,
          bottomBarColor: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 800),
          hideOnScroll: true,
          body: (BuildContext context, ScrollController controller) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Space(16),
                    Container(
                      height: 30.h,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text(
                          "Cash",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Cash in Hand',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              // set,
                              data['coh'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),

                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Cash at Bank (SAV)',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['cabs'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Cash at Bank (CUR)',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['cabc'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Cash at Bank (FD)',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['cabf'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Container(
                      height: 30.h,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text(
                          "Gold & Silver",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: '24K Gold',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['24kg'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Rate per gram',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['24kgrpg'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: '22K Gold',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['22kg'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Rate per gram',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['22kgrpg'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Silver',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['silv'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Rate per gram',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['silvrpg'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(4),
                    Text(
                      "Please Insert the current estimated value",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Space(16),
                    Container(
                      height: 30.h,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text(
                          "Rent & Income",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Rent from home',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['rfh'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Rent from land',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['rfl'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Rent from building',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['rfb'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Business Income',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['bi'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Stock on trade',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['sot'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Space(16),
                    Container(
                      height: 30.h,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text(
                          "Debts & Liabilities",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Debts to family',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['dtf'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Debts to friends',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['dtfr'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Debts to Relative',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['dtr'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Debts to others',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['dto'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Business Payments',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['bp'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                        Space(16),
                        Container(
                          width: 170,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: 'Other Payments',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Change the border color for focused state
                                  width:
                                      2.0, // Change the border width for focused state
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onChanged: (d) {
                              data['op'] = double.tryParse(d) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Space(16),
                    ElevatedButton(
                        onPressed: () async {
                          showWaitingDialog(context);
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          // if(mounted){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => ZakathSummary(data: data)));
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 40),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4.0,
                        ),
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                    Space(100),
                  ],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/svg/masjidbot.svg"),
                Space(8),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.QURANPAGE);
                    },
                    child: SvgPicture.asset("assets/svg/quranbot.svg")),
                Space(8),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pop(MaterialPageRoute(builder: (_) => HomeView()));
                    },
                    child: SvgPicture.asset("assets/svg/homebot.svg")),
                Space(8),
                SvgPicture.asset("assets/svg/mediabot.svg"),
                Space(8),
                SvgPicture.asset("assets/svg/donatebot.svg"),
              ],
            ),
          ),
        ));
  }

  Widget padding(List<Widget> children) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children,
        ),
      );
}

Widget header(String title, BuildContext context) {
  return Container(
    color: Theme.of(context).primaryColor,
    width: double.maxFinite,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8),
    child: Text(
      title,
      style:
          Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
    ),
  );
}

class ZakathSummary extends StatefulWidget {
  final Map<String, double> data;

  const ZakathSummary({Key? key, required this.data}) : super(key: key);

  @override
  State<ZakathSummary> createState() => _ZakathSummaryState();
}

class _ZakathSummaryState extends State<ZakathSummary> {
  double get(String key) => widget.data[key] ?? 0;

  @override
  Widget build(BuildContext context) {
    final cash = get('coh') + get('cabs') + get('cabc') + get('cabf');
    final rai = get('rfh') + get('rfl') + get('rfb') + get('bi') + get('sot');
    final gas = (get('24kg') * get('24kgrpg')) +
        (get('22kg') * get('22kgrpg')) +
        (get('silv') * get('silvrpg'));
    final dal = get('dtf') +
        get('dtfr') +
        get('dtr') +
        get('dto') +
        get('bp') +
        get('op');

    final total = cash + rai + gas - dal;

    final zakath = (total / 100) * 2.5;

    return Scaffold(
      body: Column(
        children: [
          const Space(16),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(""),
              ),
              const Spacer(),
              // const TitleArt(
              //   'Zakath Calculator',
              //   size: 0.75,
              // ),
              const Spacer(),
              const Space(60)
            ],
          ),
          header("Result", context),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                tableItem(
                    Column(
                      children: [
                        Row(
                          children: [
                            tableItem(Text(
                              'Particulars',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700),
                            )),
                            tableItem(
                                Text(
                                  'Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w700),
                                ),
                                alignment: Alignment.center),
                          ],
                        ),
                        Row(
                          children: [
                            tableItem(Text(
                              'Cash',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                            )),
                            tableItem(
                                SelectableText(
                                  NumberFormat.currency(symbol: '')
                                      .format(cash),
                                ),
                                alignment: Alignment.center),
                          ],
                        ),
                        Row(
                          children: [
                            tableItem(Text(
                              'Gold & Silver',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                            )),
                            tableItem(
                                SelectableText(
                                  NumberFormat.currency(symbol: '').format(gas),
                                ),
                                alignment: Alignment.center),
                          ],
                        ),
                        Row(
                          children: [
                            tableItem(Text(
                              'Rent & Income',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                            )),
                            tableItem(
                                SelectableText(
                                  NumberFormat.currency(symbol: '').format(rai),
                                ),
                                alignment: Alignment.center),
                          ],
                        ),
                        Row(
                          children: [
                            tableItem(Text(
                              'Debts & Liabilities',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                            )),
                            tableItem(
                                SelectableText(
                                  NumberFormat.currency(symbol: '').format(dal),
                                ),
                                alignment: Alignment.center),
                          ],
                        ),
                        Row(
                          children: [
                            tableItem(
                                Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                alignment: Alignment.centerRight),
                            tableItem(
                                SelectableText(
                                  NumberFormat.currency(symbol: '')
                                      .format(total),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                alignment: Alignment.center),
                          ],
                        ),
                        Row(
                          children: [
                            tableItem(
                                Text(
                                  'Zakath (2.5%)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                alignment: Alignment.centerRight),
                            tableItem(
                                SelectableText(
                                    NumberFormat.currency(symbol: '')
                                        .format(zakath),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                alignment: Alignment.center),
                          ],
                        ),
                      ],
                    ),
                    expanded: false,
                    padding: const EdgeInsets.all(0)),
                const Space(10),
                Row(
                  children: [
                    const Spacer(),
                    const Space(16),
                    Expanded(
                        child: Text(
                      'Payable Amount',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.9)),
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tableItem(Widget child,
      {bool expanded = true,
      Alignment alignment = Alignment.centerLeft,
      EdgeInsets padding =
          const EdgeInsets.symmetric(horizontal: 10, vertical: 8)}) {
    final body = Container(
      alignment: alignment,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 0.5),
          color: Theme.of(context).canvasColor),
      padding: padding,
      child: child,
    );
    if (expanded) return Expanded(child: body);
    return body;
  }
}
