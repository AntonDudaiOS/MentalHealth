abstract class TestListEvent {}

class LoadTestList extends TestListEvent {
  final String filePath;

  LoadTestList(this.filePath);
}
