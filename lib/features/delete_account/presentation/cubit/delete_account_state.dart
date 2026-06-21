part of 'delete_account_cubit.dart';

enum DeleteAccountStatus { idle, loading, codeSent, deleted, failure }

class DeleteAccountState extends Equatable {
  final DeleteAccountStatus status;
  final String message;

  const DeleteAccountState({
    this.status = DeleteAccountStatus.idle,
    this.message = '',
  });

  DeleteAccountState copyWith({
    DeleteAccountStatus? status,
    String? message,
  }) {
    return DeleteAccountState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
