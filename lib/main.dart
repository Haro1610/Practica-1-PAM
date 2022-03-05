import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_1/bloc/image_bloc.dart';
import 'package:practica_1/bloc/quote_bloc.dart';
import 'package:practica_1/home_page.dart';
import 'package:practica_1/bloc/countryflags_bloc.dart';
import 'package:practica_1/bloc/time_bloc.dart';
import 'package:practica_1/bloc/image_bloc.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primaryColor: Color.fromARGB(255, 177, 33, 81)),
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                CountryflagsBloc()..add(CountryflagsManageJson())),
        BlocProvider(create: (context) => QuoteBloc()..add(QuoteManageJson())),
        BlocProvider(create: (context) => TimeBloc()..add(TimeManageJson())),
        BlocProvider(create: (context) => ImageBloc()..add(ImageManageJson())),
      ], child: HomePage()),
    );
  }
}

class CountryJsonEvent {}
