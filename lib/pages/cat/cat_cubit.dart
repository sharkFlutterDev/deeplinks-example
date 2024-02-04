import 'package:deeplinking/constant/constant.dart';
import 'package:deeplinking/model/json_model.dart';
import 'package:deeplinking/pages/cat/cat_state.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class CatCubit extends Cubit<CatStates> {
  final BuildContext context;
  CatCubit(this.context) : super(const CatStates()) {
    _onInit();
  }

  Future<void> _onInit() async {
    await _getCatList();
  }

  Future<void> _getCatList() async {
    emit(state.copyWith(status: CatStatus.loading));

    try {
      List<ModelClass> jsonList = (catJson).map((e) => ModelClass.fromJson(e)).toList();

      emit(state.copyWith(catList: jsonList));
      emit(state.copyWith(status: CatStatus.loaded));
    } catch (e) {
      print('Any thing wrong here');
    }
  }

  ModelClass getDetailData(int id) {
    final ModelClass cat = state.catList[id - 1];
    return cat;
  }

  Future<void> createDynamicLink(String link) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: kUriPrefix,
      link: Uri.parse(kUriPrefix + link),
      androidParameters: AndroidParameters(
        packageName: 'com.example.deeplinking',
        fallbackUrl: Uri.parse('https://google.com'),
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.deeplinkings',
        fallbackUrl: Uri.parse('https://google.com'),
      ),
    );

    final Uri shortLink = await dynamicLinks.buildLink(parameters);
    Share.share(shortLink.toString());
  }
}
