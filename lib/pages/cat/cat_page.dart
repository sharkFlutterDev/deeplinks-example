import 'package:deeplinking/model/json_model.dart';
import 'package:deeplinking/pages/cat/cat_cubit.dart';
import 'package:deeplinking/pages/cat/cat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatPage extends StatelessWidget {
  final int? catId;
  const CatPage({Key? key, this.catId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatCubit(context),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: const Color(0xFFfafafa),
        body: BlocBuilder<CatCubit, CatStates>(
          builder: (context, state) {
            return FutureBuilder(
              future: getDetailData(catId!, context),
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return createDetailView(context, snapshot);
                    }
                }
              },
            );
          },
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.favorite_border, color: Color(0xFF5e5e5e)),
          Spacer(),
        ],
      ),
    );
  }
}

Widget createDetailView(BuildContext context, AsyncSnapshot snapshot) {
  ModelClass values = snapshot.data;
  return DetailScreen(
    catDetails: values,
  );
}

class DetailScreen extends StatefulWidget {
  final ModelClass catDetails;

  const DetailScreen({
    required this.catDetails,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(
            widget.catDetails.url.toString(),
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            color: const Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "ID",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF565656),
                  ),
                ),
                Text(
                  widget.catDetails.id.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFfd0100),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Color(0xFF999999))
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            color: const Color(0xFFFFFFFF),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF565656),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<ModelClass> getDetailData(int id, BuildContext context) async {
  final ModelClass cat = context.read<CatCubit>().getDetailData(id);
  return cat;
}
