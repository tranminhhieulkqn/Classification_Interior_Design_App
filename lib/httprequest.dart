import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getResultPredictbyAPI(File _image) async {
  Map<String, dynamic> result = new Map<String, dynamic>();
  var request = http.MultipartRequest('POST', Uri.parse('https://cidver2.et.r.appspot.com/'));
  var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
  // get file length
  var length = await _image.length();
  request.files.add(http.MultipartFile('file', stream, length, filename: basename(_image.path)));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String resultStr = await response.stream.bytesToString();
    result = jsonDecode(resultStr);
  }
  else {

  }
  return result;
}