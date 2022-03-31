import 'package:pigeon/networking/models/comment.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/post.dart';
import '../models/user.dart';
part 'client.g.dart';

@RestApi(baseUrl: "https://gorest.co.in/public/v2/")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET('users')
  Future<List<User>> getUsers();

  @GET('users/{id}')
  Future<User> getUserWithId(@Path("id") int id);

  @GET('comments')
  Future<List<Comments>> getPostComments(@Query("post_id") int postId);

  @GET('comments')
  Future<List<Comments>> getPostCommentsWithQueryMap(
    @Queries() Map<String, dynamic> queries,
  );
  @GET('posts')
  Future<List<Post>> getPosts();

  @POST('users')
  Future<User> createUser(@Body() User user);

  @POST('comments')
  Future<Comments> createComment(@Body() Comments comment);

  @POST('posts')
  Future<Post> createPost(@Body() Post post);

  @PUT("users/{id}")
  Future<User> updateUser(@Path() String id, @Body() User user);

  @PUT("comments/{id}")
  Future<Comments> updateComment(@Path() String id, @Body() Comments post);

  @PUT("posts/{id}")
  Future<Post> updatePost(@Path() String id, @Body() Post post);

  @DELETE('users/{id}')
  Future<void> deleteUser(@Path('id') int id);

  @DELETE('comments/{id}')
  Future<void> deleteComment(@Path('id') int id);

  @DELETE('posts/{id}')
  Future<void> deletePost(@Path('id') int id);
}
