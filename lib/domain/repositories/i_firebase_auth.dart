abstract class FireBaseAuth {
  Future login({required String email, required String password});

  Future registration({required String email, required String passwords});

  Future getUserCollection();
}
