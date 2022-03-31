import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retrofit/retrofit.dart';

import '../client/client.dart';
import '../models/post.dart';
import '../models/user.dart';

final isLoading = StateProvider((ref) {
  return false;
});

final isObscure = StateProvider((ref) {
  return false;
});
final isObscure1 = StateProvider((ref) {
  return false;
});
final userIdProvider = Provider<int>((ref) {
  final _signUp = Hive.box('SignUp');
  final id = _signUp.get('Id');
  print(id);
  return id;
});
const key =
    'Bearer ff4fd8240cf758b51b2971c3d96736bba5f3b5838be52828a778f60295b4d935';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(); // Provide a dio instance
  dio.options.headers["Authorization"] =
      key; // config your dio headers globally
  return dio;
});

final apiClientProvider =
    Provider<APIClient>((ref) => APIClient(ref.read(dioProvider)));

final usersProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  final APIClient _client = ref.watch(apiClientProvider);
  try {
    List<User> resp = await _client.getUsers();
    return resp;
  } catch (e) {}
  return <User>[];
});

final postProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final APIClient _client = ref.watch(apiClientProvider);
  try {
    List<Post> resp = await _client.getPosts();
    return resp;
  } catch (e) {}
  return <Post>[];
});

//select a individual user form list
class SelectedUser extends StateNotifier<int> {
  SelectedUser() : super(122);
  void update(int id) => state = id;
}

final selectedUserProvider =
    StateNotifierProvider<SelectedUser, int>((ref) => SelectedUser());

final userProvider = FutureProvider.autoDispose<User>((ref) async {
  final APIClient _client = ref.watch(apiClientProvider);
  return await _client.getUserWithId(ref.watch(selectedUserProvider));
});
