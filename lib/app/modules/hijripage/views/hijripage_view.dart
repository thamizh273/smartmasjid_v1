import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/views/home_view.dart';
import 'package:smartmasjid_v1/widgets/Sbottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../widgets/custom_card.dart';
import '../../../../widgets/space.dart';
import '../../../routes/app_pages.dart';


class HijripageView extends StatefulWidget {
  final Function(DateTime date)? onChanged;
  const HijripageView({Key? key, this.onChanged}) : super(key: key);

  @override
  State<HijripageView> createState() => _HijriCalendarState();
}



class _HijriCalendarState extends State<HijripageView> {
  final double appBarHeight = 80.0;

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  DateTime focusedDay = DateTime.now();
  final Map<String, dynamic> map = {};
  bool loading = true;
  bool year = false;


  @override
  Widget build(BuildContext context) {
    final HijriCalendar hijri = HijriCalendar.fromDate(focusedDay);
    return Scaffold(
      // appBar: RoundedAppBar(),
      // appBar: CustomAppbar(tittle: 'Hijri Calendar',),
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(200.0),
        child: AppBar(
          leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop(MaterialPageRoute(builder: (_) => HomeView()));
              },
              child: SvgPicture.asset("assets/svg/backnew.svg", fit: BoxFit.scaleDown)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/hijri.png'),
                    fit: BoxFit.fill
                )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.vertical(
                bottom: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0)),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromRadius(100.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${hijri.hDay -1}', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),),
                  Space(16),
                  Container(
                    width: 3, // Set the desired width of the divider
                    height: 50, // Set the desired height of the divider
                    color: Colors.white, // Set the desired color of the divider
                  ),
                  Space(16),
                  Text('${hijri.toFormat('MMMM \nyyyy')} ', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
          ),
        ),
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
          return Column(
            children: [
              // Image.asset("assets/images/hijri.png"),
              // Space(16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Space(16),
                    // counter("", focusedDay.month),
                    // counters("", focusedDay.year, year: true)
                  ],
                ),
              ),
              Space(8),
              SHijiriCalender(onChanged: (d){
                focusedDay = d;
              },),
            ],
          );
        }, child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset("assets/svg/masjidbot.svg"),
            Space(8),
            GestureDetector(
                onTap: (){
                  Get.toNamed(Routes.QURANPAGE);
                },
                child: SvgPicture.asset("assets/svg/quranbot.svg")),
            Space(8),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).pop(MaterialPageRoute(builder: (_) => HomeView()));
                },
                child: SvgPicture.asset("assets/svg/homebot.svg")),
            Space(8),
            SvgPicture.asset("assets/svg/mediabot.svg"),
            Space(8),
            SvgPicture.asset("assets/svg/donatebot.svg"),
          ],
        ),
      ),)
    );
  }

  Widget counter(String label, int value, {bool year = false} ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  $label  ',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        CustomCard(
          child: Row(
            children: [
              GestureDetector(
                  onTap: (){
                    setState(() {
                      focusedDay = DateTime(focusedDay.year - 1, focusedDay.month, focusedDay.day);
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/douarrowleft.svg")),
              Space(16),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      if(year){
                        focusedDay = DateTime(focusedDay.year - 1, focusedDay.month,);
                      } else {
                        focusedDay = DateTime(focusedDay.year, focusedDay.month - 1,);
                      }
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/singarrowleft.svg")),
              Space(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${DateFormat.MMMM().format(focusedDay)}',
                    style: TextStyle(
                        color:Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Space(8),
                  Container(
                    width: 3, // Set the desired width of the divider
                    height: 25, // Set the desired height of the divider
                    color: Theme.of(context).primaryColor, // Set the desired color of the divider
                  ),
                  Space(8),
                  Text(
                    '${focusedDay.year}',
                    style: TextStyle(
                        color:Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
              ),
              Space(40),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      if(year){
                        focusedDay = DateTime(focusedDay.year + 1, focusedDay.month,);
                      } else {
                        focusedDay = DateTime(focusedDay.year, focusedDay.month + 1,);
                      }
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/sinarrowright.svg")),
              Space(8),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      focusedDay = DateTime(focusedDay.year + 1, focusedDay.month, focusedDay.day);
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/douarrowright.svg")),
            ],
          ),
          border: true,
        )
      ],
    );
  }
  Widget counters(String label, int value, {bool year = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  $label  ',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        CustomCard(
          child: Row(
            children: [
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       if(year){
              //         focusedDay = DateTime(focusedDay.year - 1, focusedDay.month,);
              //       } else {
              //         focusedDay = DateTime(focusedDay.year, focusedDay.month - 1,);
              //       }
              //       widget.onChanged?.call(focusedDay);
              //     });
              //   },
              //   icon: Icon(Icons.chevron_left,color: Theme.of(context).textTheme.bodySmall?.backgroundColor,),
              //   constraints: BoxConstraints(maxHeight: 32, maxWidth: 32),
              //   padding: EdgeInsets.all(0),
              // ),
              Text(
                '${value.toString().padLeft(2, '0')}',
                style: TextStyle(
                    color:Theme.of(context).textTheme.bodySmall?.backgroundColor,
                    fontWeight: FontWeight.w600),
              ),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       if(year){
              //         focusedDay = DateTime(focusedDay.year + 1, focusedDay.month,);
              //       } else {
              //         focusedDay = DateTime(focusedDay.year, focusedDay.month + 1,);
              //       }
              //       widget.onChanged?.call(focusedDay);
              //     });
              //   },
              //   icon: Icon(Icons.chevron_right,color: Theme.of(context).textTheme.bodySmall?.backgroundColor,),
              //   constraints: BoxConstraints(maxHeight: 32, maxWidth: 32),
              //   padding: EdgeInsets.all(0),
              // ),
            ],
          ),
          border: true,
        )
      ],
    );
  }

}

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 200.0;// You can adjust the height as needed


  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      decoration: new BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/hijri.png'),
            fit: BoxFit.fill
        ),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          new BoxShadow(blurRadius: 10.0)
        ],
        borderRadius: new BorderRadius.vertical(
            bottom: new Radius.elliptical(
                MediaQuery.of(context).size.width, 100.0)),
      ),
    );
  }
}


class SHijiriCalender extends StatefulWidget {
  final Function(DateTime date)? onChanged;
  final double? height;
  const SHijiriCalender({Key? key, this.onChanged, this.height}) : super(key: key);

  @override
  State<SHijiriCalender> createState() => _SHijiriCalenderState();
}

class _SHijiriCalenderState extends State<SHijiriCalender> {
  DateTime focusedDay = DateTime.now();
  final Map<String, dynamic> map = {};
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Theme.of(context).colorScheme.secondary, width: 0.5);
    final HijriCalendar hijri = HijriCalendar.fromDate(focusedDay);
    final HijriCalendar startHijri =
    HijriCalendar.fromDate(DateTime(focusedDay.year, focusedDay.month, 1));
    final HijriCalendar endHijri = HijriCalendar.fromDate(
        DateTime(focusedDay.year, focusedDay.month + 1, 0));

    return Container(
      margin: EdgeInsets.all(8),
      //border: true,
      //radius: 5,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 4))
          ],
          border:
          Border.all(color: Theme.of(context).colorScheme.secondary, width: 0.5)
        // border: Border(
        //     top: border,
        //     left: border,
        //     right: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 0.5),
        //     bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 0.5),
        // )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [

          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
            decoration: BoxDecoration(
                color: Color(0xffD8E4E8),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondary, width: 0.1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Text(
                //   '${startHijri.toFormat('MMMM yyyy')} - ${endHijri.toFormat('MMMM yyyy')}',
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w600),
                // ),
                //const Space(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   '${DateFormat('MMMM yyyy', EasyLocalization.of(context)?.locale.languageCode).format(focusedDay)}',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w600),
                    // ),
                    // Spacer(),
                    counter('', focusedDay.month),
                    // const Space(8),
                    // counter('Year', focusedDay.year, year: true),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: widget.height ?? MediaQuery.of(context).size.width,
            child: TableCalendar(
              shouldFillViewport: true,
              availableCalendarFormats: {CalendarFormat.month: 'Month'},
              firstDay: DateTime(1900),
              lastDay: DateTime(2100),
              weekendDays: [],
              focusedDay: focusedDay,
              currentDay: focusedDay,
              headerVisible: false,
              calendarBuilders: CalendarBuilders(todayBuilder: (c, d, _) {
                return cellBuilder(d, selected: true);
              }, defaultBuilder: (c, d, _) {
                return cellBuilder(d);
              }),
              // eventLoader: (DateTime? d) {
              //   final list =
              //       map[AppUtils.postgresDate(d?.toIso8601String())] ?? [];
              //   return list;
              // },
              // calendarBuilders: CalendarBuilders(markerBuilder: (c, d, l) {
              //   if(loading) return CupertinoActivityIndicator();
              //   return Padding(
              //     padding: const EdgeInsets.only(bottom: 8),
              //     child: Wrap(
              //       spacing: 4,
              //       runSpacing: 4,
              //       children: List.generate(l.length, (i) {
              //         final e = l[i];
              //         return CustomCard(
              //           child: Text('event'),
              //           padding:
              //           EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //           color: Theme.of(context).dividerColor,
              //         );
              //       }),
              //     ),
              //   );
              // }),
              calendarStyle: CalendarStyle(
                markersAutoAligned: false,
                outsideDaysVisible: false,
                rowDecoration: BoxDecoration(
                  border: Border(
                    bottom: border,
                    top: border,
                  ),
                ),
                todayDecoration: BoxDecoration(
                  border: Border(
                    right: border,
                  ),
                  color: Theme.of(context).dividerColor,
                ),
                cellPadding: EdgeInsets.all(0),
                cellMargin: EdgeInsets.all(0),
                outsideDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    right: border,
                    left: border,
                  ),
                ),
                disabledDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    right: border,
                    left: border,
                  ),
                ),
                selectedDecoration: BoxDecoration(
                  border: Border(
                    right: border,
                    left: border,
                  ),
                  color: Theme.of(context).dividerColor,
                ),
                defaultDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    right: border,
                    left: border,
                  ),
                ),
                todayTextStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),

              headerStyle: HeaderStyle(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(5)),
                  titleTextStyle:
                  TextStyle(color: Colors.white, fontSize: 20),
                  leftChevronIcon: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                  rightChevronIcon: const Icon(Icons.keyboard_arrow_right_rounded,
                      color: Colors.white, size: 32),
                  headerMargin: EdgeInsets.symmetric(vertical: 16)),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 13, fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                    border: Border(
                      bottom: border,
                      top: border,
                      //right: border,
                    )),
              ),

              daysOfWeekHeight: 24,
              sixWeekMonthsEnforced: false,
              onDaySelected: (e, d) {
                setState(() {
                  focusedDay = d;
                  widget.onChanged?.call(focusedDay);
                });
              },
              onPageChanged: (d) {
                setState(() {
                  focusedDay = d;
                  widget.onChanged?.call(focusedDay);
                });

                //getAgendas();
              },
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //       color: Theme.of(context).colorScheme.secondary,
          //       borderRadius: const BorderRadius.only(
          //         bottomLeft: Radius.circular(5),
          //         bottomRight: Radius.circular(5),
          //       ),
          //       border: Border.all(
          //           color: Theme.of(context).colorScheme.secondary, width: 0.5)),
          //   child: Row(
          //     children: [
          //       Text(
          //         '${hijri.hDay -1} ${hijri.toFormat('MMMM, yyyy')} AH',
          //         style: const TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.w600),
          //       ),
          //       Spacer(),
          //       Text(
          //         '${focusedDay.day.toString().padLeft(2, '0')} ${DateFormat('MMMM yyyy', EasyLocalization.of(context)?.locale.languageCode).format(focusedDay)}',
          //         style: const TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.w600),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget cellBuilder(DateTime d, {bool selected = false}) {
    final HijriCalendar hijri = HijriCalendar.fromDate(DateTime(d.year, d.month, d.day -1));


    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor.withOpacity(0.5)
                : Colors.transparent,
            border:
            Border.all(color: Theme.of(context).colorScheme.secondary, width: 0.5)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // if (hijri.hDay == 1)
            //   Container(
            //     width: double.maxFinite,
            //     decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            //     padding: const EdgeInsets.symmetric(vertical: 4),
            //     child: Text(
            //       '${hijri.longMonthName} ${hijri.hDay.toString().padLeft(2, '0')}',
            //       maxLines: 3,
            //       style: const TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.w600,
            //           fontSize: 10),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            if (selected)
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(color:  Theme.of(context).primaryColor),
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '${hijri.longMonthName} ${hijri.hDay.toString().padLeft(2, '0')}',
                  maxLines: 3,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              )
            else ...[
              Spacer(),
              Text(
                '${hijri.hDay.toString().padLeft(2, '0')}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10),
              )
            ],
            const Space(8),
            Text(
              '${d.day.toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.backgroundColor,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
          ],
        ));
  }

  Widget counters(String label, int value, {bool year = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  $label  ',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        CustomCard(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if(year){
                      focusedDay = DateTime(focusedDay.year - 1, focusedDay.month,);
                    } else {
                      focusedDay = DateTime(focusedDay.year, focusedDay.month - 1,);
                    }
                    widget.onChanged?.call(focusedDay);
                  });
                },
                icon: Icon(Icons.chevron_left,color: Theme.of(context).textTheme.bodySmall?.backgroundColor,),
                constraints: BoxConstraints(maxHeight: 32, maxWidth: 32),
                padding: EdgeInsets.all(0),
              ),
              Text(
                '${value.toString().padLeft(2, '0')}',
                style: TextStyle(
                    color:Theme.of(context).textTheme.bodySmall?.backgroundColor,
                    fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if(year){
                      focusedDay = DateTime(focusedDay.year + 1, focusedDay.month,);
                    } else {
                      focusedDay = DateTime(focusedDay.year, focusedDay.month + 1,);
                    }
                    widget.onChanged?.call(focusedDay);
                  });
                },
                icon: Icon(Icons.chevron_right,color: Theme.of(context).textTheme.bodySmall?.backgroundColor,),
                constraints: BoxConstraints(maxHeight: 32, maxWidth: 32),
                padding: EdgeInsets.all(0),
              ),
            ],
          ),
          border: true,
        )
      ],
    );
  }
  Widget counter(String label, int value, {bool year = false} ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '  $label  ',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        CustomCard(
          child: Row(
            children: [
              GestureDetector(
                  onTap: (){
                    setState(() {
                      focusedDay = DateTime(focusedDay.year - 1, focusedDay.month, focusedDay.day);
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/douarrowleft.svg")),
              Space(16),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      if(year){
                        focusedDay = DateTime(focusedDay.year - 1, focusedDay.month,);
                      } else {
                        focusedDay = DateTime(focusedDay.year, focusedDay.month - 1,);
                      }
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/singarrowleft.svg")),
              Space(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${DateFormat.MMMM().format(focusedDay)}',
                    style: TextStyle(
                        color:Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Space(8),
                  Container(
                    width: 3, // Set the desired width of the divider
                    height: 25, // Set the desired height of the divider
                    color: Theme.of(context).primaryColor, // Set the desired color of the divider
                  ),
                  Space(8),
                   Text(
                    '${focusedDay.year}',
                    style: TextStyle(
                        color:Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
              ),
              Space(30),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      if(year){
                        focusedDay = DateTime(focusedDay.year + 1, focusedDay.month,);
                      } else {
                        focusedDay = DateTime(focusedDay.year, focusedDay.month + 1,);
                      }
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/sinarrowright.svg")),
              Space(16),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      focusedDay = DateTime(focusedDay.year + 1, focusedDay.month, focusedDay.day);
                      widget.onChanged?.call(focusedDay);
                    });
                  },
                  child: SvgPicture.asset("assets/svg/douarrowright.svg")),
            ],
          ),
          border: true,
        )
      ],
    );
  }
}