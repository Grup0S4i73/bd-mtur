// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listLearningObjectStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListLearningObjectStore on _ListLearningObjectStoreBase, Store {
  late final _$_ListLearningObjectStoreBaseActionController =
      ActionController(name: '_ListLearningObjectStoreBase', context: context);

  @override
  void add(FavoriteStore value) {
    final _$actionInfo = _$_ListLearningObjectStoreBaseActionController
        .startAction(name: '_ListLearningObjectStoreBase.add');
    try {
      return super.add(value);
    } finally {
      _$_ListLearningObjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(FavoriteStore value) {
    final _$actionInfo = _$_ListLearningObjectStoreBaseActionController
        .startAction(name: '_ListLearningObjectStoreBase.remove');
    try {
      return super.remove(value);
    } finally {
      _$_ListLearningObjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setList(List<LearningObjectModel> list,
      List<LearningObjectModel> favorites, String topic_name) {
    final _$actionInfo = _$_ListLearningObjectStoreBaseActionController
        .startAction(name: '_ListLearningObjectStoreBase.setList');
    try {
      return super.setList(list, favorites, topic_name);
    } finally {
      _$_ListLearningObjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFavorites(List<LearningObjectModel> list) {
    final _$actionInfo = _$_ListLearningObjectStoreBaseActionController
        .startAction(name: '_ListLearningObjectStoreBase.setFavorites');
    try {
      return super.setFavorites(list);
    } finally {
      _$_ListLearningObjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ObservableList<FavoriteStore> filter(
      List<FavoriteStore> list, String filterBy, String orderBy) {
    final _$actionInfo = _$_ListLearningObjectStoreBaseActionController
        .startAction(name: '_ListLearningObjectStoreBase.filter');
    try {
      return super.filter(list, filterBy, orderBy);
    } finally {
      _$_ListLearningObjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ObservableList<FavoriteStore> search(
      String query, String filterBy, String orderBy) {
    final _$actionInfo = _$_ListLearningObjectStoreBaseActionController
        .startAction(name: '_ListLearningObjectStoreBase.search');
    try {
      return super.search(query, filterBy, orderBy);
    } finally {
      _$_ListLearningObjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_ListLearningObjectStoreBaseActionController
        .startAction(name: '_ListLearningObjectStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_ListLearningObjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
