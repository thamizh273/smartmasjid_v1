import 'dart:math';

import 'package:flutter/material.dart';


import 'package:get/get_rx/src/rx_stream/rx_stream.dart' hide Node;
import 'package:graphview/GraphView.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/space.dart';
import '../../home/widgets/appBar.dart';

class FullfamilyTreeView extends StatefulWidget  {
  const FullfamilyTreeView({Key? key}) : super(key: key);

  @override
  State<FullfamilyTreeView> createState() => _FullfamilyTreeViewState();
}

class _FullfamilyTreeViewState extends State<FullfamilyTreeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CustomAppbar(tittle: 'Family tree',),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [


            // Wrap(
            //   children: [
            //     Container(
            //       width: 100,
            //       child: TextFormField(
            //         initialValue: builder.siblingSeparation.toString(),
            //         decoration: InputDecoration(labelText: 'Sibling Separation'),
            //         onChanged: (text) {
            //           builder.siblingSeparation = int.tryParse(text) ?? 100;
            //           this.setState(() {});
            //         },
            //       ),
            //     ),
            //     Container(
            //       width: 100,
            //       child: TextFormField(
            //         initialValue: builder.levelSeparation.toString(),
            //         decoration: InputDecoration(labelText: 'Level Separation'),
            //         onChanged: (text) {
            //           builder.levelSeparation = int.tryParse(text) ?? 100;
            //           this.setState(() {});
            //         },
            //       ),
            //     ),
            //     Container(
            //       width: 100,
            //       child: TextFormField(
            //         initialValue: builder.subtreeSeparation.toString(),
            //         decoration: InputDecoration(labelText: 'Subtree separation'),
            //         onChanged: (text) {
            //           builder.subtreeSeparation = int.tryParse(text) ?? 100;
            //           this.setState(() {});
            //         },
            //       ),
            //     ),
            //     Container(
            //       width: 100,
            //       child: TextFormField(
            //         initialValue: builder.orientation.toString(),
            //         decoration: InputDecoration(labelText: 'Orientation'),
            //         onChanged: (text) {
            //           builder.orientation = int.tryParse(text) ?? 100;
            //           this.setState(() {});
            //         },
            //       ),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         final node12 = Node.Id(r.nextInt(100));
            //         var edge = graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
            //         print(edge);
            //         graph.addEdge(edge, node12);
            //         setState(() {});
            //       },
            //       child: Text('Add'),
            //     )
            //   ],
            // ),
            Expanded(
              child: InteractiveViewer(

                  constrained: false,
                  boundaryMargin: EdgeInsets.all(50),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Space(20),
                      Row(
                        children: [
                          for(var k=1;k<=6;k++)
                          Container(height: 30,width: 110,color: Theme.of(context).primaryColor,margin: EdgeInsets.only(right: 85),child: Center(child: Text("$k st Generation",style: TextStyle(color: clr_white,),textAlign: TextAlign.center,)),),

                        ],
                      ),
                      Space(10),
                      GraphView(
                        graph: graph,
                        algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                        paint: Paint()
                          ..color = Colors.green
                          ..strokeWidth = 2
                          ..style = PaintingStyle.stroke,
                        builder: (Node node) {
                          // I can decide what widget should be shown here based on the id
                          var a = node.key!.value as int?;
                          return rectangleWidget(a);
                        },
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
  Random r = Random();

  Widget rectangleWidget(int? a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        width: 110,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child: Center(child: Text('Node ${a}'))),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    final node11 = Node.Id(11);
    final node12 = Node.Id(12);
    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue..strokeWidth=2..style = PaintingStyle.stroke);
    graph.addEdge(node2, node5);
    graph.addEdge(node2, node6);
    graph.addEdge(node6, node7,);
    graph.addEdge(node6, node8,);
    graph.addEdge(node3, node9);
    graph.addEdge(node3, node10);
    graph.addEdge(node4, node11,);
    graph.addEdge(node11, node12);

    builder
      ..siblingSeparation = (50)
      ..levelSeparation = (80)
      ..subtreeSeparation = (50)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT);
  }
}
