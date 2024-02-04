import 'package:equatable/equatable.dart';

import 'package:deeplinking/model/json_model.dart';

enum CatStatus { loading, loaded }

class CatStates extends Equatable {
  const CatStates({
    this.status = CatStatus.loading,
    this.catList = const [],
  });

  final CatStatus status;
  final List<ModelClass> catList;

  @override
  List<Object?> get props => [status, catList];

  CatStates copyWith({
    CatStatus? status,
    List<ModelClass>? catList,
  }) {
    return CatStates(
      status: status ?? this.status,
      catList: catList ?? this.catList,
    );
  }
}
