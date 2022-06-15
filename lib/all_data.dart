import 'package:cars/database_helper.dart';
import 'package:cars/show_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyData extends StatefulWidget {
  const MyData({Key? key}) : super(key: key);

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  TextEditingController carName = TextEditingController();
  TextEditingController carMiles = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Entry'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: carName),
            const SizedBox(height: 10),
            TextField(controller: carMiles),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await DataBaseHelper.instance.insertData(
                  {
                    DataBaseHelper.columnName: carName.text,
                    DataBaseHelper.columnMiles: carMiles.text,
                  },
                );
              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShowData(),
                  ),
                );
              },
              child: const Text('Show Data'),
            ),
          ],
        ),
      ),
    );
  }
}
