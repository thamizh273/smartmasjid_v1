


import 'package:carousel_slider/carousel_slider.dart';

import '../../../routes/export.dart';


class Events extends StatelessWidget {
  const Events({
    super.key,
    required CarouselController carouselController,
  }) : _carouselController = carouselController;

  final CarouselController _carouselController;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Events",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Stxt(text: "3 Upcoming Events near you", size: 11)
                ],
              ),
              TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EventsPage(),
                    //     ));
                  },
                  child: const Stxt(
                    text: 'View all', size: f1,
                    // "View all",
                    // style: TextStyle(fontWeight: FontWeight.w600),
                  )),
            ],
          ),
          CarouselSlider(
              carouselController: _carouselController,
              items: ['fadjr', 'dhuhr', 'asr', 'magrib', 'isha'].map((e) {
                return Card(
                  surfaceTintColor: themeData.primaryColor,
                  shadowColor: themeData.primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/event_img.png',
                          fit: BoxFit.cover,
                          height: 85,
                          width: 140,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Islam, modernity, and women’s justice',
                          style: TextStyle(
                              fontSize: f0,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                size: f2,
                              ),
                              Stxt(
                                text: " Masjid-e-noorania",
                                size: f0,
                              )
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.access_time_sharp,
                              size: f1,
                            ),
                            Stxt(
                              text: " 26 May 2023 - 6 Pm",
                              size: f0,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                // enlargeStrategy: CenterPageEnlargeStrategy.height,
                // enlargeCenterPage: true,
                // enlargeFactor: .4,
                disableCenter: true,
                enableInfiniteScroll: true,
                initialPage: 1,
                height: 180,
                viewportFraction: 0.4,
              )),
        ],
      ),
    );
  }
}