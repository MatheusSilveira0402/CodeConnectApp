import 'package:equatable/equatable.dart';
import '../../models/blog_post_model.dart';

sealed class PostFormState extends Equatable {
  const PostFormState();

  @override
  List<Object?> get props => [];
}

class PostFormInitial extends PostFormState {
  const PostFormInitial();
}

class PostFormLoading extends PostFormState {
  const PostFormLoading();
}

class PostFormSuccess extends PostFormState {
  final BlogPostModel? post;
  const PostFormSuccess(this.post);

  @override
  List<Object?> get props => [post];
}

class PostFormError extends PostFormState {
  final String message;
  const PostFormError(this.message);

  @override
  List<Object?> get props => [message];
}
