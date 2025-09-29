import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:instax/blocs/get_post_bloc/get_post_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/screens/home/create_post_screen.dart';
import 'package:intl/intl.dart';
import 'package:post_repository/post_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<MyUserBloc, MyUserState>(
        builder: (context, state) {
          if (state.status == MyUserStatus.success) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BlocProvider<CreatePostBloc>(
                      create: (context) => CreatePostBloc(
                          postRepository: FirebasePostRepository()),
                      child: CreatePostScreen(state.user!),
                    ),
                  ),
                );
              },
              child: const Icon(CupertinoIcons.add),
            );
          } else {
            return const FloatingActionButton(
              onPressed: null,
              child: Icon(CupertinoIcons.clear),
            );
          }
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            if (state.status == MyUserStatus.success) {
              return Row(
                children: [Text('Welcome ${state.user!.name}')],
              );
            } else {
              return Container();
            }
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              },
              icon: Icon(
                CupertinoIcons.square_arrow_right,
                color: Theme.of(context).colorScheme.secondary,
              ))
        ],
      ),
      body: BlocBuilder<GetPostBloc, GetPostState>(
        builder: (context, state) {
          if (state is GetPostSuccess) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, int i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.posts[i].myUser.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(state.posts[i].createAt),
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            state.posts[i].post,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is GetPostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("An error has occured"),
            );
          }
        },
      ),
    );
  }
}
