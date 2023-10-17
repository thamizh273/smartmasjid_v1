import 'package:flutter/material.dart';

void main() {
  runApp(const PullToRefreshApp());
}

class PullToRefreshApp extends StatelessWidget {
  const PullToRefreshApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pull to Refresh Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    // Simulating an API request or data refresh
    await  Future.delayed(const Duration(seconds: 2));

    setState(() {
      // Update the list with new data
      items = List.generate(20, (index) => 'New item  ${index + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull to Refresh'),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refreshData,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}

