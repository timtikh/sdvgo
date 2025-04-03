part of 'translator_cubit.dart';

class TranslatorState extends Equatable {
  final TranslatorStatus status;
  final String? response;
  final String? errorMessage;

  const TranslatorState._({
    required this.status,
    this.response,
    this.errorMessage,
  });

  const TranslatorState.initial() : this._(status: TranslatorStatus.initial);

  const TranslatorState.loading() : this._(status: TranslatorStatus.loading);

  const TranslatorState.withResponse(String response)
      : this._(
          status: TranslatorStatus.withResponse,
          response: response,
        );

  const TranslatorState.error(String message)
      : this._(status: TranslatorStatus.error, errorMessage: message);

  bool get isLoading => status == TranslatorStatus.loading;
  bool get hasError => status == TranslatorStatus.error;

  @override
  List<Object?> get props => [status, response, errorMessage];
}

enum TranslatorStatus {
  initial,
  loading,
  withResponse,
  error,
}
