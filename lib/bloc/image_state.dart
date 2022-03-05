part of 'image_bloc.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageSuccess extends ImageState {
  final Map successMsg;
  ImageSuccess({required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}

class ImageError extends ImageState {
  final String errorMsg;
  ImageError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
