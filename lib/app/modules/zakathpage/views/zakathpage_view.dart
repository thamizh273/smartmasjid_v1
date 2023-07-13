import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/zakathpage_controller.dart';

class ZakathpageView extends GetView<ZakathpageController> {
  const ZakathpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, double> data = {};
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Zakath Calculator",
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text("Cash",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white),),
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Cash in Hand',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['coh'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Cash at Bank (SAV)',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Cash at Bank (CUR)',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['cabc'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Cash at Bank (FD)',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                  child: Text("Gold & Silver",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white),),
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: '24K Gold',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['24kg'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Rate per gram',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: '22K Gold',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['22kg'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Rate per gram',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Silver',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['silv'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Rate per gram',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['silvrpg'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                ],
              ),
              Space(4),
              Text("Please Insert the current estimated value", style: TextStyle(fontWeight: FontWeight.w400),),
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text("Rent & Income",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white),),
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Rent from home',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['rfh'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Rent from land',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Rent from building',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['rfb'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Business Income',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Stock on trade',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                  child: Text("Debts & Liabilities",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white),),
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Debts to family',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['dtf'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Debts to friends',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Debts to Relative',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['dtr'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Debts to others',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
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
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Business Payments',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['bp'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                  Space(16),
                  Container(
                    width: 170,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Other Payments',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey, // Change the border color for focused state
                            width: 2.0, // Change the border width for focused state
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (d){
                        data['op'] = double.tryParse(d) ?? 0.0;
                      },
                    ),
                  ),
                ],
              ),
              Space(16),
              ElevatedButton(
                  onPressed: ()   {
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
                  child: Text("Calculate", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
              Space(30),
            ],
          ),
        ),
      ),
    );
  }
}
