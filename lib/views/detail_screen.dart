import 'package:flutter/material.dart';
import '../controllers/post_controller.dart';
import '../models/post_model.dart';
import '../utils/color_utils.dart';
import '../utils/text_style_utils.dart';

class DetailScreen extends StatelessWidget {
  final int postId;

  DetailScreen({required this.postId});

  final PostController _postController = PostController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    _postController.stopTimer(postId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        title: Text(
          'Post Detail',
          style: TextStyleManager.titleStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 5,
      ),
      body: FutureBuilder<Post>(
        future: _postController.getPostDetail(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorManager.secondaryColor),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 20),
                  SizedBox(height: 10),
                  Text(
                    'Error loading post',
                    style: TextStyleManager.errorMessageStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          } else {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      post.title,
                      style: TextStyleManager.titleStyle.copyWith(
                        fontSize: screenWidth * 0.05,
                        color: ColorManager.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Post content
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorManager.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        post.body,
                        style: TextStyleManager.contentTextStyle.copyWith(
                          fontSize: screenWidth * 0.045,
                          height: 1.6,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Action buttons

                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

