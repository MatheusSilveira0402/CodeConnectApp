import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../core/di/service_locator.dart';
import '../core/utils/api_helper.dart';
import '../models/blog_post_model.dart';
import '../cubits/post_form/post_form_cubit.dart';
import '../cubits/post_form/post_form_state.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'camera_capture_screen.dart';

class CriarPostScreen extends StatefulWidget {
  final BlogPostModel? post;

  const CriarPostScreen({super.key, this.post});

  @override
  State<CriarPostScreen> createState() => _CriarPostScreenState();
}

class _CriarPostScreenState extends State<CriarPostScreen> {
  // Usando Service Locator para criar nova instância de PostFormCubit
  late final PostFormCubit _postFormCubit = ServiceLocator.instance
      .createPostFormCubit();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _markdownController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  bool get isEditing => widget.post != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
      _markdownController.text = widget.post!.markdown;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _markdownController.dispose();
    super.dispose();
  }

  Future<void> _showImageSourcePicker() async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_camera_outlined,
                  color: AppTheme.textColor,
                ),
                title: Text(
                  l10n.takePhoto,
                  style: const TextStyle(color: AppTheme.textColor),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: AppTheme.textColor,
                ),
                title: Text(
                  l10n.chooseFromGallery,
                  style: const TextStyle(color: AppTheme.textColor),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _takePhoto() async {
    final l10n = AppLocalizations.of(context);
    final status = await Permission.camera.request();

    if (!status.isGranted) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            status.isPermanentlyDenied
                ? l10n.cameraPermissionPermanentlyDenied
                : l10n.cameraPermissionDenied,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;
    final File? photo = await Navigator.push<File>(
      context,
      MaterialPageRoute(builder: (context) => const CameraCaptureScreen()),
    );

    if (photo != null) {
      setState(() {
        _selectedImage = photo;
      });
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _publishPost() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!isEditing && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.selectCoverImage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    BlogPostModel? result;

    if (isEditing) {
      result = await _postFormCubit.updatePost(
        id: widget.post!.id,
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        markdown: _markdownController.text.trim(),
      );
    } else {
      result = await _postFormCubit.createPost(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        markdown: _markdownController.text.trim(),
        image: _selectedImage!,
      );
    }

    if (!mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing ? l10n.postUpdatedSuccess : l10n.postPublishedSuccess,
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      final state = _postFormCubit.state;
      final message = state is PostFormError
          ? state.message
          : l10n.errorPublishingPost;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _deletePost() async {
    if (!isEditing) return;
    final l10n = AppLocalizations.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final dialogL10n = AppLocalizations.of(dialogContext);
        return AlertDialog(
          title: Text(dialogL10n.confirmDeleteTitle),
          content: Text(dialogL10n.confirmDeletePostMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(dialogL10n.btnCancelar),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(dialogL10n.btnDelete),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirm == true) {
      final success = await _postFormCubit.deletePost(widget.post!.id);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.postDeletedSuccess),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        final state = _postFormCubit.state;
        final message = state is PostFormError
            ? state.message
            : l10n.errorDeletingPost;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? l10n.editPostTitle : l10n.newProjectTitle,
          style: const TextStyle(
            color: AppTheme.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: _deletePost,
            ),
        ],
      ),
      body: BlocBuilder<PostFormCubit, PostFormState>(
        bloc: _postFormCubit,
        builder: (context, state) {
          if (state is PostFormLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryColor,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Picker
                  GestureDetector(
                    onTap: _showImageSourcePicker,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.borderColor),
                        image: _selectedImage != null
                            ? DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : (isEditing && widget.post!.image.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        ApiHelper.getImageUrl(
                                          widget.post!.image,
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null),
                      ),
                      child:
                          _selectedImage == null &&
                              (!isEditing || widget.post!.image.isEmpty)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 48,
                                  color: AppTheme.textColor.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.loadImage,
                                  style: TextStyle(
                                    color: AppTheme.textColor.withValues(
                                      alpha: 0.5,
                                    ),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                  if (_selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Text(
                            _selectedImage!.path.split('/').last,
                            style: TextStyle(
                              color: AppTheme.textColor.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Title Field
                  Text(
                    l10n.projectNameLabel,
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    style: const TextStyle(color: AppTheme.textColor),
                    decoration: InputDecoration(
                      hintText: l10n.projectNameHint,
                      hintStyle: TextStyle(
                        color: AppTheme.textColor.withValues(alpha: 0.3),
                      ),
                      filled: true,
                      fillColor: AppTheme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.fieldTitleRequired;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Description Field
                  Text(
                    l10n.descriptionLabel,
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _bodyController,
                    style: const TextStyle(color: AppTheme.textColor),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: l10n.descriptionHint,
                      hintStyle: TextStyle(
                        color: AppTheme.textColor.withValues(alpha: 0.3),
                      ),
                      filled: true,
                      fillColor: AppTheme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.fieldDescriptionRequired;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Tags/Markdown Field
                  Text(
                    l10n.tagsLabel,
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _markdownController,
                    style: const TextStyle(color: AppTheme.textColor),
                    decoration: InputDecoration(
                      hintText: l10n.tagsHint,
                      hintStyle: TextStyle(
                        color: AppTheme.textColor.withValues(alpha: 0.3),
                      ),
                      filled: true,
                      fillColor: AppTheme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.fieldTagsRequired;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      if (isEditing)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _deletePost,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.delete_outline),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.btnDiscard,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (isEditing) const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _publishPost,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: AppTheme.backgroundColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            isEditing ? l10n.btnUpdate : l10n.btnPublicar,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
