import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeInitial()) {
    on<TimeEvent>(_request);
  }

  var husoHorario = [
    "http://worldtimeapi.org/api/timezone/Europe/Andorra",
    "http://worldtimeapi.org/api/timezone/America/Mexico_City",
    "http://worldtimeapi.org/api/timezone/America/Lima",
    "http://worldtimeapi.org/api/timezone/America/Vancouver",
    "http://worldtimeapi.org/api/timezone/America/Argentina/Buenos_Aires",
  ];

  var indicePais = 0;

  void _request(TimeEvent event, Emitter emisor) async {
    var mapTime = await _readJson();

    mapTime != null
        ? emisor(TimeSuccess(successMsg: mapTime))
        : emisor(TimeError(errorMsg: "No Time"));
  }

  Future _readJson() async {
    try {
      Response res = await get(Uri.parse(husoHorario[indicePais]));
      if (res.statusCode == HttpStatus.ok) {
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }

    // TODO: implement event handler
  }
}
