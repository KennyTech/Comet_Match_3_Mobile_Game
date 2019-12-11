import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:finalproject/localstorage/DBUtils.dart';
import 'package:finalproject/localstorage/character.dart';


class CharactersModel {
  Future<void> insertCharacter(Database db, Character character) async {
    if(db == null) {
      db = await DBUtils.init();
    }
    await db.insert('characters', character.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //when it unlocks the character make it self unlocking??
  Future<void> updateCharacter(Database db, Character character) async {
    if(db == null) {
      db = await DBUtils.init();
    }
    await db.update('characters', character.toMap(), where: 'id = ?', whereArgs: [character.id]);
  }

  Future<void> deleteCharacterById(Database db, int id) async {
    if(db == null) {
      db = await DBUtils.init();
    }
    await db.delete('characters', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Character>> getAllCharacters(Database db) async {
    if(db == null) {
      db = await DBUtils.init();
    }
    final List<Map<String, dynamic>> maps = await db.query('characters');
    List<Character> characters = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++){
        characters.add(Character.fromMap(maps[i]));
      }
    }
    return characters;
  }
}