import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/features/boomer_translator/domain/cubits/translator_cubit.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class BoomerTranslatorWidget extends StatefulWidget {
  const BoomerTranslatorWidget({super.key});

  @override
  State<BoomerTranslatorWidget> createState() => _BoomerTranslatorWidgetState();
}

class _BoomerTranslatorWidgetState extends State<BoomerTranslatorWidget> {
  late Future<bool> _hasPermission;
  bool _isListening = false;
  String _resultString = '';
  late final TranslatorCubit _translatorBloc;
  late final SpeechToText _stt;
  String? translatedText;

  Future<void> handleText() async {
    if (_resultString.isEmpty) {
      return;
    }
    await _translatorBloc.requestTranslation(_resultString);
  }

  void _toggleListening(SpeechToText stt) async {
    if (_isListening) {
      await stt.stop();
    } else {
      await stt.listen(
        onResult: (result) => setState(() {
          _resultString = result.recognizedWords;
        }),
        localeId: 'ru_RU',
        pauseFor: const Duration(seconds: 3),
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _stt = ScopeProvider.of<AppScopeContainer>(context, listen: false)!
        .speechToTextDep
        .get;
    _hasPermission = _stt.initialize(
      onStatus: (status) {
        if (status == 'listening') {
          _isListening = true;
        }
        if (status == 'notListening') {
          _isListening = false;
        }
        if (status == 'done') {
          handleText();
        }
        setState(() {});
      },
    );
    _translatorBloc =
        ScopeProvider.of<AppScopeContainer>(context, listen: false)!
            .translatorCubitDep
            .get;
  }

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
        builder: (context, scope) {
      return BlocConsumer<TranslatorCubit, TranslatorState>(
        bloc: _translatorBloc,
        listener: (context, state) {
          if (state.status == TranslatorStatus.withResponse) {
            translatedText = state.response;
          }
        },
        builder: (context, state) => FutureBuilder<bool>(
            future: _hasPermission,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Image.asset('assets/images/sad_fish(maybe).jpeg');
                }
                return snapshot.data!
                    ? ColoredBox(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).boomerTranslator,
                                textScaler: TextScaler.linear(2.0),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: SingleChildScrollView(
                                    child: Text(translatedText ?? ''),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _toggleListening(_stt);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.mic,
                                      color: _isListening
                                          ? Colors.red
                                          : Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Image.asset('assets/images/sad_fish(maybe).jpeg');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      );
    });
  }
}
