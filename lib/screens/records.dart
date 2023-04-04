import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListofRecords extends StatelessWidget {
  const ListofRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DISMAP',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  size: 30,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            CustomCard(
              brgy: 'Sample1',
              date: '53546',
              message: 'sdfkjsdfsf',
              image1:
                  'https://foodtank.com/wp-content/uploads/2015/11/biologicalpestcontrol-770x461.jpg',
              image2:
                  'https://www.nri.org/images/images/nri-news/2012/armyworm_crop_damage_full.jpg',
              image3:
                  'https://foodtank.com/wp-content/uploads/2015/11/biologicalpestcontrol-770x461.jpg',
            ),
            SizedBox(height: 10),
            CustomCard(
              brgy: 'Sample2',
              date: '53546',
              message: 'sdfkjsdfsf',
              image1:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSvpl0PX0rtRnWIpqlgS0UOVep3PZWY0Rr3Q&usqp=CAU',
              image2:
                  'https://media.istockphoto.com/id/1280681233/photo/agronomist-examining-damaged-corn-leaf-corn-leaves-attacked-by-worms-in-maize-field.jpg?s=612x612&w=0&k=20&c=BnDgXuDraoxkgnOH-cJMw4birhYagjUd6VnXWEVp4oA=',
              image3:
                  'https://www.shutterstock.com/image-photo/maize-damaged-by-caterpillar-european-260nw-2023207979.jpg',
            ),
            SizedBox(height: 10),
            CustomCard(
              brgy: 'Sample3',
              date: '53546',
              message: 'sdfkjsdfsf',
              image1:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4o4nzWJXPjaVRWyOhGdvLCr24Mv0YPXfX3Q&usqp=CAU',
              image2:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbZgzxkzF3jnYo_mcRny3RVuHOHc3ecKl1-xsX90Z0WfHp0kisG22jgqdvunGHBFTjvRQ&usqp=CAU',
              image3:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa02bOA7DbH4XufnQQuapVwVr6Nm67nNIU5tXod-kWKbxdzm090NzNyABx2e938lho9r0&usqp=CAU',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String brgy;
  final String date;
  final String message;
  final String image1;
  final String image2;
  final String image3;
  const CustomCard({
    required this.brgy,
    required this.date,
    required this.message,
    required this.image1,
    required this.image2,
    required this.image3,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Barangay: $brgy',
              style: TextStyle(fontSize: 22),
            ),
            Text('Date: $date', style: TextStyle(fontSize: 22)),
            Text('Message: $message', style: TextStyle(fontSize: 22)),
            Text('Images:', style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  '$image1',
                  width: 100,
                ),
                Image.network(
                  '$image2',
                  width: 100,
                ),
                Image.network(
                  '$image3',
                  width: 100,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
