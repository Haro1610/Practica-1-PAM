import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
    on<QuoteEvent>(_request);
  }
  final String url = "https://zenquotes.io/api/random";

  void _request(QuoteEvent event, Emitter emisor) async {
    var mapQuote = await _readJson();
    mapQuote != null
        ? emisor(QuoteSuccess(successMsg: mapQuote))
        : emisor(QuoteError(errorMsg: "No quote"));
  }

  Future _readJson() async {
    try {
      Response res = await get(Uri.parse(url));
      if (res.statusCode == HttpStatus.ok) {
        //print(jsonDecode(res.body)[0]);
        return jsonDecode(res.body)[0];
      }
    } catch (e) {
      print(e);
    }

    // TODO: implement event handler
  }
}
