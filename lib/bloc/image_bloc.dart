import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>(_request);
  }

  final String url = "https://picsum.photos/v2/list";

  void _request(ImageEvent event, Emitter emisor) async {
    var mapImage = await _readJson();

    mapImage != null
        ? emisor(ImageSuccess(successMsg: mapImage[Random().nextInt(30)]))
        : emisor(ImageError(errorMsg: "No Image"));
  }

  Future _readJson() async {
    try {
      Response res = await get(Uri.parse(url));
      if (res.statusCode == HttpStatus.ok) {
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }

    // TODO: implement event handler
  }
}
