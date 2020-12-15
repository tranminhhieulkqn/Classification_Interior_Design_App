import 'dart:async';
import 'dart:io';
import 'package:interior_app/consttants.dart';
import 'package:interior_app/widgets/app_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interior_app/httprequest.dart';
import 'package:interior_app/screens/results/results_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showNavigationBottomBar = false;
  var _loadingScreen = false;
  File _image;
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic> resultPredict = new Map<String, dynamic>();

  Future getImage({ImageSource source}) async {
    var pickedFile;
    switch (source) {
      case ImageSource.camera:
        pickedFile = await _picker.getImage(source: ImageSource.camera);
        break;
      case ImageSource.gallery:
        pickedFile = await _picker.getImage(source: ImageSource.gallery);
        break;
      default:
        print('No image selected.');
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _showNavigationBottomBar = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagebyCamera() async {
    getImage(source: ImageSource.camera);
  }

  Future getImagebyGallery() async {
    getImage(source: ImageSource.gallery);
  }

  Future<void> getResultPredict(File _image) async {
    _loadingScreen = true;
    resultPredict = await getResultPredictbyAPI(_image);
    // print(resultPredict['InceptionV3'][1]);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultsScreen(this._image, resultPredict)),
    ).then(
      (value) => setState(() {
        _loadingScreen = false;
        this._image = null;
        this._showNavigationBottomBar = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: !_loadingScreen
            ? Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/back.png"),
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.topCenter,
                    ),
                  ),
                )),
            Positioned(
              top: MediaQuery.of(context).size.height * (.06),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .37,
                    width: MediaQuery.of(context).size.width,
                    child: ClipPath(
                      clipper: AppClipper(
                          cornerSize: 50,
                          diagonalHeight: 150,
                          roundedBottom: true),
                      child: Container(
                        color: Color(0xFFD3D3D3).withOpacity(.95),
                        padding: EdgeInsets.only(top: 100),
                      ),
                    ),
                  ),
                  Container(
                    height:
                    MediaQuery.of(context).size.height * .37 * 0.97,
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: ClipPath(
                      clipper: AppClipper(
                          cornerSize: 50,
                          diagonalHeight: 150,
                          roundedBottom: true),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .width *
                                      .05),
                              child: Text(
                                "Application",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 30),
                              ),
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height *
                                  .05,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .width *
                                      .05),
                              child: Text(
                                "Interior Design Classification",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * (.45),
              child: Container(
                height: MediaQuery.of(context).size.height * .55,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 15),
                            blurRadius: 30,
                            color: Color(0xFF666666).withOpacity(.11),
                          ),
                        ],
                      ),
                      // color: Colors.red,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: kLightBlackColor,
                        strokeWidth: 5,
                        dashPattern: [20, 10],
                        radius: Radius.circular(30),
                        padding: EdgeInsets.all(6),
                        child: Container(
                            height: MediaQuery.of(context).size.height *
                                .55 *
                                .85,
                            width:
                            MediaQuery.of(context).size.width * .85,
                            child: (_image == null)
                                ? Row(
                              children: <Widget>[
                                Expanded(
                                    child: Opacity(
                                      opacity: .8,
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            "assets/icons/Camera.svg",
                                            height: 85,
                                            width: 80,
                                            // color: iconColor,
                                          ),
                                        ),
                                        onTap: getImagebyCamera,
                                      ),
                                    )),
                                Expanded(
                                    child: Opacity(
                                      opacity: .8,
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            "assets/icons/Gallery.svg",
                                            height: 70,
                                            width: 80,
                                            // color: iconColor,
                                          ),
                                        ),
                                        onTap: getImagebyGallery,
                                      ),
                                    )),
                              ],
                            )
                                : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)),
                                  image: DecorationImage(
                                    image: FileImage(_image),
                                    // fit: BoxFit.cover
                                  )),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Visibility(
                  visible: _showNavigationBottomBar,
                  child: Container(
                    // padding:
                    //     EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    height: MediaQuery.of(context).size.height * .12,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                .08,
                            width: MediaQuery.of(context).size.width *
                                0.35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Text(
                              "CLEAN",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              print('Hello');
                              _showNavigationBottomBar = false;
                              print(_image.runtimeType);
                              _image = null;
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                .08,
                            width: MediaQuery.of(context).size.width *
                                0.35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Text(
                              "PREDICT",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              getResultPredict(_image);
                            });
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        )
            : SpinKitSquareCircle(
          color: Colors.black,
          size: MediaQuery.of(context).size.width * .2,
        ),
      ),
    );
  }
}
