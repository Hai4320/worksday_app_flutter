import 'package:flutter_test/flutter_test.dart';
import 'package:worksday_app/models/task.dart';
import 'package:intl/intl.dart';

void main() {
  test('test set and show repeat',() async {
    //Arrange
    final time = DateTime.now();
    final task = Task(time.toString(), "test",0,0,0);
    //ACT
    task.setRepeat(-8, [false]);

    //ASSERT
    expect(task.showRepeatDayOfTask() ,DateFormat("dd/MM/yyyy").format(time));
  });
}