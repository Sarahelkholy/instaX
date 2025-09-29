import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

class CreatePostScreen extends StatefulWidget {
  final MyUser myUser;
  const CreatePostScreen(this.myUser, {super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late Post post;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    post = Post.empty;
    post.myUser = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state is CreatePostSuccess) {
          Navigator.pop(context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  post.post = _controller.text;
                });
                context.read<CreatePostBloc>().add(CreatePost(post));
              }
            },
            child: const Icon(CupertinoIcons.add),
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            foregroundColor: Colors.white,
            title: const Text("Create a Post !"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: "Enter Your Post Here...",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
