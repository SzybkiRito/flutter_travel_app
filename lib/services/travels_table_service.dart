import 'package:travel_planning_app/controllers/database_controller.dart';
import 'package:travel_planning_app/controllers/user_controller.dart';

class TravelsTableService {
  Future<int> saveNewTravel({
    required String desitination,
    required DateTime startDate,
    required DateTime endDate,
    required String tripData,
  }) async {
    final database = await DatabaseController().open();

    final id = await database.insert(
      'travels',
      {
        'user_email': await UserController.getCurrentUserId(),
        'destination': desitination,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'data': tripData,
      },
    );
    await DatabaseController().close(database);

    return id;
  }

  Future getAllTravelsOfUser({required String? userEmail}) async {
    final database = await DatabaseController().open();

    final travels = await database.query(
      'travels',
      where: 'user_email = ?',
      whereArgs: [userEmail],
    );

    await DatabaseController().close(database);

    return travels;
  }
}
