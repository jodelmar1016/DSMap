// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:dsmap/screens/map.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dsmap/services/dataService.dart';

// class ListofRecords extends StatefulWidget {
//   const ListofRecords({super.key});

//   @override
//   State<ListofRecords> createState() => _ListofRecordsState();
// }

// class _ListofRecordsState extends State<ListofRecords> {
//   final Stream<QuerySnapshot> collectionReference = DataService.readReports();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'DISMAP',
//           style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Mapping()),
//                   );
//                 },
//                 icon: Icon(
//                   Icons.map_outlined,
//                   size: 30,
//                 )),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: StreamBuilder(
//           stream: collectionReference,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasData) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return CustomCard(
//                       brgy: snapshot.data!.docs[index]['barangay'],
//                       message: snapshot.data!.docs[index]['message'],
//                     );
//                   },
//                 );
//               }
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

// class CustomCard extends StatelessWidget {
//   final String brgy;
//   // final String date;
//   final String message;
//   // final String image1;
//   // final String image2;
//   // final String image3;
//   const CustomCard({
//     required this.brgy,
//     // required this.date,
//     required this.message,
//     // required this.image1,
//     // required this.image2,
//     // required this.image3,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Barangay: $brgy',
//               style: TextStyle(fontSize: 22),
//             ),
//             // Text('Date: $date', style: TextStyle(fontSize: 22)),
//             Text('Message: $message', style: TextStyle(fontSize: 22)),
//             // Text('Images:', style: TextStyle(fontSize: 22)),
//             // SizedBox(height: 10),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //   children: [
//             //     Image.network(
//             //       '$image1',
//             //       width: 100,
//             //     ),
//             //     Image.network(
//             //       '$image2',
//             //       width: 100,
//             //     ),
//             //     Image.network(
//             //       '$image3',
//             //       width: 100,
//             //     )
//             //   ],
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
