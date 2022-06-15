import 'package:cars/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List<Map<String, dynamic>> carDetails = [];

  getData() async {
    List<Map<String, dynamic>> details =
        await DataBaseHelper.instance.getAllData();
    setState(
      () {
        carDetails = details;
      },
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Show Data'),
          centerTitle: true,
        ),
        body: carDetails.isNotEmpty
            ? ListView.builder(
                itemCount: carDetails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(carDetails[index][DataBaseHelper.columnName]),
                    subtitle:
                        Text(carDetails[index][DataBaseHelper.columnMiles]),
                    trailing: GestureDetector(
                      onTap: () async {
                        print(carDetails[index][DataBaseHelper.isFav]);
                        if (carDetails[index][DataBaseHelper.isFav] == 1) {
                          await DataBaseHelper.instance.update(
                            {
                              DataBaseHelper.columnId : carDetails[index][DataBaseHelper.columnId],
                              DataBaseHelper.isFav : 0
                            },
                          );
                          print(true);
                        } else {
                          await DataBaseHelper.instance.update(
                            {
                              DataBaseHelper.columnId : carDetails[index][DataBaseHelper.columnId],
                              DataBaseHelper.isFav : 1
                            },
                          );
                        }
                        getData();
                      },
                      child: Icon(
                        carDetails[index][DataBaseHelper.isFav] == 0
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'No Data Found.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
