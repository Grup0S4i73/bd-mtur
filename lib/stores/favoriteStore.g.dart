// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoriteStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on _FavoriteStoreBase, Store {
  late final _$isFavoriteAtom =
      Atom(name: '_FavoriteStoreBase.isFavorite', context: context);

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  late final _$_FavoriteStoreBaseActionController =
      ActionController(name: '_FavoriteStoreBase', context: context);

  @override
  void toogleFavorite() {
    final _$actionInfo = _$_FavoriteStoreBaseActionController.startAction(
        name: '_FavoriteStoreBase.toogleFavorite');
    try {
      return super.toogleFavorite();
    } finally {
      _$_FavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFavorite: ${isFavorite}
    ''';
  }
}
