import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_1/bloc/countryflags_bloc.dart';
import 'package:practica_1/bloc/image_bloc.dart';
import 'package:practica_1/bloc/quote_bloc.dart';
import 'package:practica_1/bloc/time_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      headerHeight: 500,
      appBar: BackdropAppBar(
        title: Text("La frase diaria"),
        backgroundColor: Color.fromARGB(255, 177, 33, 81),
        actions: <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          )
        ],
      ),
      backLayer: BlocConsumer<CountryflagsBloc, CountryflagsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CountryflagsSuccess) {
            var contryKey = ['ad', 'mx', 'pe', 'ca', 'ar'];
            return Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: contryKey.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = contryKey.elementAt(index);
                  return ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.network(
                          "https://flagcdn.com/16x12/" + key + ".png"),
                    ),
                    onTap: () {
                      print(state.successMsg[key]);
                      BlocProvider.of<TimeBloc>(context).indicePais = index;
                      BlocProvider.of<TimeBloc>(context).add(TimeManageJson());
                      BlocProvider.of<ImageBloc>(context)
                          .add(ImageManageJson());
                    },
                    title: Text(state.successMsg[key],
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            );
          } else if (state is CountryflagsError) {
            return Text(state.errorMsg);
          } else {
            return Text("");
          }
        },
      ),
      frontLayer: Container(
        child: image_st(),
      ),
    );
  }

  Widget image_st() {
    return Stack(alignment: Alignment.topCenter, // Center of Top
        children: <Widget>[
          Container(
              child: BlocConsumer<ImageBloc, ImageState>(
                  builder: ((context, state) {
                    if (state is ImageSuccess) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(state.successMsg['download_url']),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Color.fromARGB(255, 18, 73, 117).withOpacity(0.6),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      );
                    } else if (state is ImageError) {
                      return Text(state.errorMsg);
                    } else {
                      return Text("");
                    }
                  }),
                  listener: (context, state) {})),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            BlocConsumer<TimeBloc, TimeState>(
                builder: ((context, state) {
                  if (state is TimeSuccess) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        state.successMsg['datetime'].substring(11, 19),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                        ),
                      ),
                    );
                  } else if (state is TimeError) {
                    return Text(state.errorMsg);
                  } else {
                    return Text("");
                  }
                }),
                listener: (context, state) {})
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            BlocConsumer<QuoteBloc, QuoteState>(
                builder: ((context, state) {
                  if (state is QuoteSuccess) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        state.successMsg['q'] + '\n' + state.successMsg['a'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    );
                  } else if (state is QuoteError) {
                    return Text(state.errorMsg);
                  } else {
                    return Text("");
                  }
                }),
                listener: (context, state) {})
          ]),
        ]);
  }
}
