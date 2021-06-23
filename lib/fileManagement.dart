import 'dart:convert';
import 'dart:io';

import 'package:friba_performance_tracker/singleRound.dart';
import 'package:path_provider/path_provider.dart';

// This method is used to write a provided string parameter to
// a file in the system.
//
write(String text) async {
  try {
    print("Tallennetaan kierros");
    final Directory directory = await getApplicationDocumentsDirectory();
    final pathToFile = '${directory.path}/playedRounds.json';
    final File file = File(pathToFile);
    final pathToAllStats = '${directory.path}/allStats.json';
    final File allStatsFile = File(pathToAllStats);

    dynamic textAsJson = jsonDecode(text);
    SingleRound jsonAsObject = new SingleRound.fromJson(textAsJson);
    List<Putts> putts = jsonAsObject.putts;

    // Checks if path to all stats file is empty. If it's empty,
    // creates a new file with first round's putting data. If it exists, adds new putting data
    // to old all time putting data.
    //
    if (allStatsFile.existsSync() == false) {
      print("all stats file doesn't exist! creating new file");
      await allStatsFile
          .writeAsString("{\"putts\":" + jsonEncode(putts).toString() + "}");
      print("{\"putts\":" + jsonEncode(putts).toString() + "}");
    } else {
      final existingAllStatsAsString = await readAllStats();
      print(existingAllStatsAsString);
      final existingAllStatsFileAsJson = jsonDecode(existingAllStatsAsString);
      final allStatsObject =
          new SingleRound.fromJson(existingAllStatsFileAsJson);

      for (var i = 0; i < putts.length; i++) {
        allStatsObject.putts[i].made += putts[i].made;
        allStatsObject.putts[i].missed += putts[i].missed;
      }
      await allStatsFile.writeAsString(
          '{"putts":' + jsonEncode(allStatsObject.putts).toString() + '}');
      print('{"putts":' + jsonEncode(allStatsObject.putts).toString() + '}');
    }

    // Checks if path to played rounds file is empty
    //
    if (file.existsSync() == false) {
      print("file doesn't exist!");
      await file.writeAsString("[" + text + "]");
      print("[" + text + "]");
      return;
    }

    print("file exists!");
    String existingFileString = await readRounds();
    final existingFileAsJson = jsonDecode(existingFileString);

    List newList = [];

    if (existingFileAsJson != null) {
      existingFileAsJson.forEach((element) {
        final round = SingleRound.fromJson(element);
        newList.add(round.toJson());
      });
      newList.insert(0, jsonDecode(text));
    }

    //print(jsonEncode(newList).toString());

    await file.writeAsString(jsonEncode(newList).toString());
    print("Kierros tallennettu");
  } catch (e) {
    print('Kierroksen tallentaminen ei onnistunut!');
    print(e);
  }
}

// This method is used to read a file from the system.
//
Future<String> readRounds() async {
  String text;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/playedRounds.json');

    if (file.existsSync() == true) {
      text = await file.readAsString();
      print("file was read");
      return text;
    }
    print("file didnt exist");
    return null;
  } catch (e) {
    print("Couldn't read file");
    print(e);
    return null;
  }
}

// This method is used to read a file from the system.
//
Future<String> readAllStats() async {
  String text;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/allStats.json');

    if (file.existsSync() == true) {
      text = await file.readAsString();
      print("all stats file was read");
      return text;
    }
    print("all stats file didnt exist");
    return null;
  } catch (e) {
    print("Couldn't read all stats file");
    print(e);
    return null;
  }
}

// This method is used to delete every json data file that the app
// has created.
//
Future<bool> deleteEverything() async {
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final pathToFile = '${directory.path}/playedRounds.json';
    final File file = File(pathToFile);

    final pathToAllStats = '${directory.path}/allStats.json';
    final File allStatsFile = File(pathToAllStats);

    if (file.existsSync() == true) {
      file.delete();
      print('deleted file');
      if (allStatsFile.existsSync() == true) {
        allStatsFile.delete();
        print('deleted all stats file');
      }
      return true;
    }

    print('file didnt exist');
    return false;
  } catch (e) {
    print('delete failed');
    print(e);
    return false;
  }
}

// This method is used to delete a single user selected round from
// the playedRounds.json. First it reads the whole file, then finds the rounds stored at
// the provided index, and then deleted this rounds and saves the modified json. The whole
// is deleted if the json doesn't have any rounds after deleting last round.
//
// Also substracts the deleted round's data from all stats file.
//
Future<bool> deleteOneRound(int index) async {
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final pathToFile = '${directory.path}/playedRounds.json';
    final File file = File(pathToFile);

    if (file.existsSync() == true) {
      String existingFileString = await readRounds();
      final existingFileAsJson = jsonDecode(existingFileString);

      List newList = [];
      var test;

      if (existingFileAsJson != null) {
        existingFileAsJson.forEach((element) {
          final round = SingleRound.fromJson(element);
          newList.add(round.toJson());
        });
        test = new SingleRound.fromJson(newList[index]);
        newList.removeAt(index);
      }

      final existingAllStatsAsString = await readAllStats();
      print(existingAllStatsAsString);
      final existingAllStatsFileAsJson = jsonDecode(existingAllStatsAsString);
      final allStatsObject =
          new SingleRound.fromJson(existingAllStatsFileAsJson);

      for (var i = 0; i < allStatsObject.putts.length; i++) {
        allStatsObject.putts[i].made -= test.putts[i].made;
        allStatsObject.putts[i].missed -= test.putts[i].missed;
      }

      final pathToAllStats = '${directory.path}/allStats.json';
      final File allStatsFile = File(pathToAllStats);

      await allStatsFile.writeAsString(
          '{"putts":' + jsonEncode(allStatsObject.putts).toString() + '}');
      print('{"putts":' + jsonEncode(allStatsObject.putts).toString() + '}');

      if (newList.isEmpty) {
        deleteEverything();
        return true;
      }

      await file.writeAsString(jsonEncode(newList).toString());

      print('deleted round');
      return true;
    }

    print('file didnt exist');
    return false;
  } catch (e) {
    print('round delete failed');
    print(e);
    return false;
  }
}
