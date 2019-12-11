/*
* PlayersModel handles the SQLite database creation and the logic for adding, editing, and deleting players using async functions. 
*
* Functions:
* getAllPlayers()            // Returns list of all players
* insertPlayer(Player player)  // Adds new player
* updatePlayer(Player player)  // Updates a player
* deletePlayerById(int id)   // Delete player with provided id
*
*/

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:finalproject/localstorage/player.dart';

class PlayersModel {

	static PlayersModel _databaseHelper;
	static Database _database;

	String playersTable = 'players_table';
	String columnID = 'id';
	String columnName = 'name';
	String columnHighScore = 'highscore';
  String columnRecentScores = 'recentscores';

	PlayersModel._createInstance();

	factory PlayersModel() {

		if (_databaseHelper == null) {
			_databaseHelper = PlayersModel._createInstance();
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

  // Initialize the SQLite database
	Future<Database> initializeDatabase() async {
		// Get database
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'playerstest32.db';

		// Create datapath at path
		var playersDatabase = await openDatabase(path, version: 1, onCreate: createDatabase);
		return playersDatabase;
	}

  // Create the SQLite database
	void createDatabase(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $playersTable($columnID INTEGER PRIMARY KEY, $columnName TEXT, '
		  '$columnHighScore TEXT, $columnRecentScores TEXT)');
		}

	// Get all players using async
	Future<List<Map<String, dynamic>>> getAllPlayers() async {
		Database db = await this.database;
		var result = await db.query(playersTable, orderBy: '$columnID ASC');
		return result;
	}

  // Delete all players
	Future<int> deleteAllPlayers() async {
		var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $playersTable'); // Delete all SQLite
		return result;
	}

  // Delete selected player by id
	Future<int> deletePlayerById(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $playersTable WHERE $columnID = $id'); // Delete matching id query SQLite
		return result;
	}

	// Insert player
	Future<int> insertPlayer(Player player) async {
		Database db = await this.database;
		var result = await db.insert(playersTable, player.toMap());
		return result;
	}

	// Update player
	Future<int> updatePlayer(Player player) async {
		var db = await this.database;
		var result = await db.update(playersTable, player.toMap(), where: '$columnID = ?', whereArgs: [player.id]);
		return result;
	}

	// Count players
	Future<int> getPlayerCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $playersTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get player list
	Future<List<Player>> getPlayerList() async {

		var playerMapList = await getAllPlayers();
		int count = playerMapList.length;

		List<Player> playerList = List<Player>();

		for (int i = 0; i < count; i++) {
			playerList.add(Player.fromMap(playerMapList[i]));
		}

		return playerList;
	}

}