import 'package:equatable/equatable.dart';

class AddUserState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const AddUserState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  AddUserState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return AddUserState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}