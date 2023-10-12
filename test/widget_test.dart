import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(
    GetMaterialApp(
      home: PageListView(),
    ),
  );
}



class PageListView extends StatelessWidget {
  final pages = [
    {
      'name': "1",
      'verses': ["1", "2", "3", "4", "5", "6", "7"],
      'no': "1",
    },
    {
      'name': "2",
      'verses': ["8", "9", "10", "11", "12"],
      'no': "2",
    },
    {
      'name': "3",
      'verses': ["13", "14", "15", "16", "17", "18"],
      'no': "3",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page List'),
      ),
      body: ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            final page = pages[index];
            return GestureDetector(
              onTap: () {
                // Handle page item tap here
                _handlePageTap(page);
              },
              child: Column(
                children: [
                  ListTile(
                    title: Text("${page['name']}"),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:"${ page['verses']}".length,
                    itemBuilder: (context, verseIndex) {
                      final verseNumber = "${ page['verses']}"[verseIndex];
                      return GestureDetector(
                        onTap: () {
                          // Handle verse item tap here
                          _handleVerseTap(page, verseNumber, verseIndex);
                        },
                        child: ListTile(
                          title: Text(verseNumber),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        )

    );
  }

  void _handlePageTap(Map<String, dynamic> page) {
    // Access the details of the tapped page, including page number and name
    final pageNumber = page['no'];
    final name = page['name'];

    print("Tapped on page $pageNumber - Name: $name");
  }

  void _handleVerseTap(Map<String, dynamic> page, String verse, int verseIndex) {
    // Access the details of the tapped verse, including verse number, page number, and name
    final pageNumber = page['no'];
    final name = page['name'];

    print("Tapped on verse $verse (Index: $verseIndex) - Page: $pageNumber - Name: $name");
  }
}

