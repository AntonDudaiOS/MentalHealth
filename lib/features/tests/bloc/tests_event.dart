abstract class TestEvent {}

class LoadTests extends TestEvent {
  final String filePath;

  LoadTests(this.filePath);
}
