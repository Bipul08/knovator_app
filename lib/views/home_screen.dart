import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../controllers/post_controller.dart';
import '../utils/color_utils.dart';
import '../utils/text_style_utils.dart';
import 'detail_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    await Provider.of<PostController>(context, listen: false).loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posts',
          style: TextStyleManager.titleStyle,
        ),
        backgroundColor: ColorManager.primaryColor,
        elevation: 4,
        centerTitle: true,
      ),
      body: Consumer<PostController>(
        builder: (context, postController, child) {
          if (postController.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primaryColor),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            itemCount: postController.posts.length,
            itemBuilder: (context, index) {
              final post = postController.posts[index];
              final isRead = postController.readPosts.contains(post.id);

              return VisibilityDetector(
                key: Key('post_${post.id}'),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0) {
                    postController.startTimer(post.id);
                  } else {
                    postController.stopTimer(post.id);
                  }
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: isRead ? ColorManager.cardReadColor : ColorManager.cardUnreadColor,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    title: Text(
                      post.title,
                      style: TextStyleManager.postTitleStyle,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Tap to view details",
                        style: TextStyleManager.postSubtitleStyle,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer, color: ColorManager.textSecondaryColor, size: 18),
                        const SizedBox(height: 5),
                        Text(
                          '${postController.timers[post.id]}s',
                          style: TextStyleManager.timerTextStyle,
                        ),
                      ],
                    ),
                    onTap: () async {
                      postController.stopTimer(post.id);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(postId: post.id),
                        ),
                      );
                      postController.startTimer(post.id);
                      postController.markAsRead(post.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

