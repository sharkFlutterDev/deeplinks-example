import 'package:deeplinking/constant/constant.dart';
import 'package:deeplinking/firebase_options.dart';
import 'package:deeplinking/pages/cat/cat_cubit.dart';
import 'package:deeplinking/pages/cat/cat_state.dart';
import 'package:deeplinking/pages/cat/widget/cat_item_design.dart';
import 'package:deeplinking/routes/routes_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteServices.generateRoute,
      home: _MainScreen(),
    );
  }
}

class _MainScreen extends StatefulWidget {
  const _MainScreen();

  @override
  State<_MainScreen> createState() => __MainScreenState();
}

class __MainScreenState extends State<_MainScreen> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    try {
      FirebaseDynamicLinks.instance.onLink.listen((event) {
        final Uri uri = event.link;
        final queryParams = uri.queryParameters;
        if (queryParams.containsKey('id')) {
          String? catId = queryParams['id'];
          Navigator.pushNamed(
            context,
            '/catpage',
            arguments: {'catId': int.parse(catId!)},
          );
        } else {
          Navigator.pushNamed(context, uri.path);
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatCubit(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cats List'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return BlocBuilder<CatCubit, CatStates>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                switch (state.status) {
                  case CatStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (state.catList.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 8.0 / 12.0,
                      children: List<Widget>.generate(state.catList.length, (index) {
                        var item = state.catList[index];
                        return GridTile(
                          child: GridTiles(
                            name: item.name.toString(),
                            imageUrl: item.url.toString(),
                            onShare: () {
                              context
                                  .read<CatCubit>()
                                  .createDynamicLink(kCatLink + item.id.toString());
                            },
                            voidCallback: () {
                              Navigator.pushNamed(
                                context,
                                '/catpage',
                                arguments: {'catId': int.parse(item.id.toString())},
                              );
                            },
                          ),
                        );
                      }),
                    );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
