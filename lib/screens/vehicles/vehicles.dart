import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skills_test/model/vehicle_model.dart';
import 'package:flutter_skills_test/resources/vehicle_api.dart';
import 'package:flutter_skills_test/screens/vehicles/widgets/car_detail_edit.dart';
import 'package:flutter_skills_test/screens/vehicles/widgets/car_detail_row.dart';
import 'dart:math' as math;

import 'package:flutter_skills_test/screens/vehicles/widgets/custom_icon_button.dart';

class Vehicles extends StatefulWidget {
  static String tag = "/vehicles";

  @override
  _VehicleState createState() => _VehicleState();
}

class _VehicleState extends State<Vehicles> {
  TextEditingController _carModel = TextEditingController();
  TextEditingController _carColor = TextEditingController();
  TextEditingController _carModelYear = TextEditingController();
  TextEditingController _carVin = TextEditingController();
  TextEditingController _carPrice = TextEditingController();

  var vehicleList;
  var dataLength;
  var currentIndex = 0;
  @override
  void initState() {
    super.initState();
    vehicleList = VehicleApi().fetchVehicleList();
  }


  void increment(int n) {
    setState(() {
      if(n==0){
        dataLength = 0;
      } else if (currentIndex == n - 1) {
        currentIndex = 0;
      } else {
        currentIndex++;
      }
    });
  }

  void decrement(int n) {
    setState(() {
      if(n==0){
        dataLength=0;
      } else if (currentIndex == 0) {
        currentIndex = n - 1;
      } else {
        currentIndex--;
      }
    });
  }

  _showDialog(int index, List<Vehicle> data) {
    _carModel.text = data[index].carModel;
    _carColor.text = data[index].carColor;
    _carModelYear.text = data[index].carModelYear.toString();
    _carVin.text = data[index].carVin;
    _carPrice.text = data[index].price;
    bool _availability = data[index].availability;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder:(context, setState) {return AlertDialog(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text("${data[index].car}"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CarDetailEdit(label: "Car Model", controller: _carModel),
                    CarDetailEdit(label: "Color", controller: _carColor),
                    CarDetailEdit(label: "Year", controller: _carModelYear),
                    CarDetailEdit(label: "VIN", controller: _carVin),
                    CarDetailEdit(label: "Price", controller: _carPrice),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Availability :", style: Theme.of(context).textTheme.subtitle1,), ),
                        Expanded(
                          flex: 0,
                          child: Checkbox(value: _availability, onChanged: (bool value){

                            setState(() {
                              _availability = value;
                            });
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop('Cancel'),
                ),
                TextButton(
                  child: Text("Done"),
                  onPressed: () {
                    setState((){
                      data[index].carModel = _carModel.text;
                      data[index].carColor = _carColor.text;
                      data[index].carModelYear =int.parse(_carModelYear.text);
                      data[index].carVin = _carVin.text;
                      data[index].price = _carPrice.text;
                      data[index].availability = _availability;
                    });
                    increment(index);
                    decrement(index);
                    Navigator.of(context).pop('Done');},
                ),
              ],
            );}
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Vehicles Catalog'),
        ),
        //Replace the body to implement your own screen design
        body: Center(
          child: FutureBuilder(
            future: vehicleList,
                builder: (context, AsyncSnapshot<List<Vehicle>> snapshot){
              if(snapshot.hasData){
                var data = snapshot.data;
                dataLength = data.length;
                return dataLength == 0
                    ? Text('No Vehicles Found!!', style: TextStyle(fontSize: 30.0))
                    : Padding(
                  padding: const EdgeInsets.only(
                      top: 16, right: 8, left: 8, bottom: 0),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Vehicle Image
                            Container(
                              height: size.height / 5,
                              width: size.width / 2,
                              color: Color(
                                  (math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                            ),

                            //Icon button row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomIconButton(
                                  icon: Icons.keyboard_arrow_left_sharp,
                                  onPressed: () {
                                    decrement(dataLength);
                                  },
                                ),
                                Text(
                                  "${data[currentIndex].car}",

                                  style: TextStyle(fontSize: 30),
                                ),
                                CustomIconButton(
                                  icon: Icons.keyboard_arrow_right_sharp,
                                  onPressed: () {
                                    increment(dataLength);
                                  },
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 60,
                            ),
                            // Vehicle details
                            CarDetailRow(
                                label: "Car Model",
                                data: data[currentIndex].carModel),
                            CarDetailRow(
                                label: "Color",
                                data: data[currentIndex].carColor),
                            CarDetailRow(
                                label: "Year",
                                data:
                                data[currentIndex].carModelYear.toString()),
                            CarDetailRow(
                                label: "VIN",
                                data:
                                data[currentIndex].carVin.substring(0, 6)),
                            CarDetailRow(
                                label: "Price",
                                data: "\$${data[currentIndex].price}"),
                            CarDetailRow(
                                label: "Availability",
                                data:
                                data[currentIndex].availability.toString()),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showDialog(currentIndex, data);
                              },
                              child: Container(
                                height: size.height / 16,
                                width: size.width / 2.5,
                                color: Theme.of(context).primaryColor,
                                child: Center(
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 26),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  data.removeAt(currentIndex);
                                  dataLength = data.length;
                                  currentIndex = 0;
                                });
                              },
                              child: Container(
                                height: size.height / 16,
                                width: size.width / 2.5,
                                color: Theme.of(context).primaryColor,
                                child: Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 26),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
                },
              ),
        ));
  }
}
