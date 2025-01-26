import 'package:flutter/material.dart';
import 'package:test_task/data/models/feed_photo.dart';

class FeedPhotoList extends StatelessWidget {
  final List<FeedPhoto> photos;

  const FeedPhotoList({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final currentPhoto = photos[index];
          final previousPhoto = index > 0 ? photos[index - 1] : null;

          // Check if this is the first item of the group
          final isFirstInGroup = previousPhoto == null ||
              currentPhoto.authorName[0].toUpperCase() !=
                  previousPhoto.authorName[0].toUpperCase();

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 32,
                child: isFirstInGroup
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          currentPhoto.authorName[0].toUpperCase(),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      )
                    : null,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          currentPhoto.source,
                        ),
                      ),
                    ),
                    title: Text(currentPhoto.authorName),
                    subtitle: Text(
                      currentPhoto.alt ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
