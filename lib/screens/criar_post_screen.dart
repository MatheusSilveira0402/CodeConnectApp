import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../core/di/service_locator.dart';
import '../core/utils/api_helper.dart';
import '../models/blog_post_model.dart';
import '../stores/post_store.dart';
import '../theme/app_theme.dart';

class CriarPostScreen extends StatefulWidget {
  final BlogPostModel? post;

  const CriarPostScreen({super.key, this.post});

  @override
  State<CriarPostScreen> createState() => _CriarPostScreenState();
}

class _CriarPostScreenState extends State<CriarPostScreen> {
  // Usando Service Locator para criar nova instância de PostStore
  late final PostStore _postStore = ServiceLocator.instance.createPostStore();

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

  Future<void> _pickImage() async {
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!isEditing && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione uma imagem de capa'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    BlogPostModel? result;

    if (isEditing) {
      result = await _postStore.updatePost(
        id: widget.post!.id,
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        markdown: _markdownController.text.trim(),
      );
    } else {
      result = await _postStore.createPost(
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
            isEditing
                ? 'Post atualizado com sucesso!'
                : 'Post publicado com sucesso!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_postStore.errorMessage ?? 'Erro ao publicar post'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deletePost() async {
    if (!isEditing) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir este post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (confirm == true) {
      final success = await _postStore.deletePost(widget.post!.id);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post excluído com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_postStore.errorMessage ?? 'Erro ao excluir post'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          isEditing ? 'Editar Post' : 'Novo Projeto',
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
      body: Observer(
        builder: (_) {
          if (_postStore.isLoading) {
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
                    onTap: _pickImage,
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
                                  'Carregar imagem',
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
                  if (!isEditing && _selectedImage == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'imagem_projeto.png',
                        style: TextStyle(
                          color: AppTheme.textColor.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
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
                  const Text(
                    'Nome do projeto',
                    style: TextStyle(
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
                      hintText: 'React easy to here',
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
                        return 'Por favor, insira o título';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Description Field
                  const Text(
                    'Descrição',
                    style: TextStyle(
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
                      hintText:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
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
                        return 'Por favor, insira a descrição';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Tags/Markdown Field
                  const Text(
                    'Tags',
                    style: TextStyle(
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
                      hintText: 'React',
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
                        return 'Por favor, insira as tags';
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_outline),
                                SizedBox(width: 8),
                                Text(
                                  'Descartar',
                                  style: TextStyle(
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
                            isEditing ? 'Atualizar' : 'Publicar',
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
