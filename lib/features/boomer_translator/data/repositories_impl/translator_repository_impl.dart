import 'package:sdvgo/features/boomer_translator/data/datasource/translator_datasource.dart';
import 'package:sdvgo/features/boomer_translator/domain/repositories/translator_repository.dart';

class TranslatorRepositoryImpl implements TranslatorRepository {
  final TranslatorDatasource _translatorDatasource;

  TranslatorRepositoryImpl({required TranslatorDatasource translatorDatasource})
      : _translatorDatasource = translatorDatasource;

  @override
  Future<String> translate(String message) async {
    return await _translatorDatasource.translate(message);
  }
}
