part of 'reels_cubit.dart';

sealed class ReelsState extends Equatable {
  const ReelsState();

  @override
  List<Object> get props => [];
}

final class ReelsInitial extends ReelsState {}

final class ReelsLoading extends ReelsState {}
