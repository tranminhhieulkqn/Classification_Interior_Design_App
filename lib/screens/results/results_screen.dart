import 'dart:async';
import 'dart:io';
import 'package:interior_app/consttants.dart';
import 'package:interior_app/widgets/app_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:interior_app/widgets/results_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ResultsScreen extends StatefulWidget {
  final File image;
  final Map<String, dynamic> resultPredict;

  ResultsScreen(this.image, this.resultPredict);

  @override
  _ResultsScreenState createState() => new _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<String> _Models = ["Xception", "InceptionV3", "DenseNet201"];
  String _selectedModel = "Xception";

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> Models) {
    List<DropdownMenuItem<String>> items = List();
    for (String company in Models) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(String selectedModel) {
    setState(() {
      _selectedModel = selectedModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context);
      },
      child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: size.height,
                            width: size.width,
                            color: Colors.white,
                          ),
                          Container(
                            height: size.height,
                            width: size.width,
                            color: Colors.white,
                          ),
                          Container(
                            height: size.height,
                            width: size.width,
                            color: Colors.white,
                          ),
                          Opacity(
                            opacity: .7,
                            child: Container(
                              height: size.height,
                              width: size.width,
                              decoration: BoxDecoration(
                                // borderRadius:
                                // BorderRadius.all(Radius.circular(30)),
                                  image: DecorationImage(
                                      image: FileImage(widget.image),
                                      fit: BoxFit.cover)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: size.height * .7,
                        width: size.width,
                        child: ClipPath(
                          clipper: AppClipper(
                              cornerSize: 50,
                              diagonalHeight: 150,
                              roundedBottom: false),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 100),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: size.height * .43,
                        right: size.width * .05,
                        child: Container(
                            alignment: Alignment.center,
                            height: size.width * (1.6 / 3),
                            width: size.width * (1.6 / 3),
                            child: DottedBorder(
                                borderType: BorderType.RRect,
                                color: Colors.black,
                                strokeWidth: 5,
                                dashPattern: [20, 10],
                                radius: Radius.circular(30),
                                padding: EdgeInsets.all(6),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        image: DecorationImage(
                                            image: FileImage(widget.image),
                                            fit: BoxFit.cover)))))),
                    Positioned(
                        top: size.height * .47,
                        left: size.width * .04,
                        child: Container(
                            alignment: Alignment.center,
                            height: size.height * .1,
                            width: size.width * (1 / 3),
                            child: DottedBorder(
                                borderType: BorderType.RRect,
                                color: Colors.black,
                                strokeWidth: 2,
                                dashPattern: [3, 3],
                                radius: Radius.circular(10),
                                padding: EdgeInsets.all(6),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height * .1,
                                  width: size.width * (1 / 3),
                                  child: Text(
                                    '${widget.resultPredict['${_selectedModel} Predicted']}',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    ),
                                    softWrap: true,
                                  ),
                                )
                            )
                        )
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: size.width,
                          width: size.width,
                          child: ResultsChart(model: _selectedModel, result: widget.resultPredict,),
                        )),
                    Positioned(
                      top: size.height * .05,
                      right: size.width * .05,
                      child: Card(
                        child: Container(
                          // alignment: Alignment.center,
                          // width: size.width,
                            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.6),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                              // Not necessary for Option 1
                              value: _selectedModel,
                              icon: Icon(Icons.arrow_drop_down_outlined, color: kLightBlackColor, textDirection: TextDirection.ltr,),
                              iconSize: 30,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                              underline: SizedBox(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedModel = newValue;
                                });
                              },
                              items: _Models.map((model) {
                                return DropdownMenuItem(
                                  child: new Text(model),
                                  value: model,
                                );
                              }).toList(),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}