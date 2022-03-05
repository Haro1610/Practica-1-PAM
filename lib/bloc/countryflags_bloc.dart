import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'countryflags_event.dart';
part 'countryflags_state.dart';

class CountryflagsBloc extends Bloc<CountryflagsEvent, CountryflagsState> {
  CountryflagsBloc() : super(CountryflagsInitial()) {
    on<CountryflagsEvent>(_request);
  }
  final String url = "https://flagcdn.com/en/codes.json";

  void _request(CountryflagsEvent event, Emitter emisor) async {
    var mapCountry = await _readJson();
    mapCountry != null
        ? emisor(CountryflagsSuccess(successMsg: mapCountry))
        : emisor(CountryflagsError(errorMsg: "No flags"));
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
