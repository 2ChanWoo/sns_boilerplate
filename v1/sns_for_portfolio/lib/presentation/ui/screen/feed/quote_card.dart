import 'package:flutter/material.dart';
import 'package:sns_for_portfolio/app/theme/app_theme.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    required this.statement,
    required this.isFavorite,
    this.author,
    this.top,
    this.bottom,
    this.onTap,
    this.onFavorite,
    Key? key,
  }) : super(key: key);

  final String statement;
  final String? author;
  final bool isFavorite;
  final Widget? top;
  final Widget? bottom;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  @override
  Widget build(BuildContext context) {
    final top = this.top;
    final bottom = this.bottom;
    final theme = context.theme;
    final author = this.author;
    return Card(
      margin: const EdgeInsets.all(0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                if (top != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                    ),
                    child: top,
                  ),
                const Spacer(),
                IconButton(
                  onPressed: onFavorite,
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                statement,
                style: theme.quoteTextStyle.copyWith(
                  fontSize: 22,
                ),
              ),
            ),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                ),
                child: bottom,
              ),
            const SizedBox(
              height: 16,
            ),
            if (author != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  right: 12,
                ),
                child: Text(author),
              ),
          ],
        ),
      ),
    );
  }
}
