import 'package:flutter/material.dart';
import '../core/utils/api_helper.dart';
import '../core/utils/app_logger.dart';
import '../models/blog_post_model.dart';
import '../theme/app_theme.dart';

/// Card de exibição de post do blog
///
/// Exibe informações do post incluindo imagem, título, descrição,
/// autor e ações (like, edit). Segue o princípio Single Responsibility.
class PostCard extends StatelessWidget {
  final BlogPostModel post;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onEdit;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onLike,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Priorizar cover se imageUrl estiver vazio
    final imagePath = post.imageUrl?.isNotEmpty == true
        ? post.imageUrl!
        : (post.cover ?? '');

    // Construir URL completa da imagem
    final imageUrl = ApiHelper.getImageUrl(imagePath);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: AppTheme.backgroundColor,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      AppLogger.error(
                        'Erro ao carregar imagem do post',
                        error,
                        stackTrace,
                        'PostCard',
                      );
                      return Container(
                        color: AppTheme.backgroundColor,
                        child: const Icon(
                          Icons.broken_image,
                          size: 48,
                          color: AppTheme.textSecondary,
                        ),
                      );
                    },
                  ),
                ),
              ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    post.title,
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Body preview
                  Text(
                    post.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Author and metadata
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.primaryColor,
                        backgroundImage: post.author.avatar != null
                            ? NetworkImage(
                                ApiHelper.getAvatarUrl(post.author.avatar),
                              )
                            : null,
                        child: post.author.avatar == null
                            ? Text(
                                post.author.name[0].toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.backgroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.author.name,
                              style: const TextStyle(
                                color: AppTheme.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _formatDate(post.createdAt),
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Actions
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: AppTheme.textSecondary,
                        iconSize: 20,
                        onPressed: onLike,
                      ),
                      Text(
                        '${post.likes}',
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '0',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.bookmark_border,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      const Spacer(),
                      if (onEdit != null)
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          color: AppTheme.primaryColor,
                          iconSize: 20,
                          onPressed: onEdit,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min atrás';
    } else {
      return 'Agora';
    }
  }
}
