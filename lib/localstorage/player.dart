/*
* The Player class maps to and from the following fields: id, name, high score, recent scores. 
*
* Functions:
*   toMap()   // Returns map of id, name, high score, recent scores, called in PlayersModel to insert and update players
*   fromMap() // Generates player instance of id, name, high score, recent scores, called in PlayersModel to get the Player List
*/

class Player {

	int _id;
  String _name;
  String _highScore;
  String _recentScores;

  // Constructors
	Player(this._name);
	Player.withScores(this._id, this._name, this._highScore, this._recentScores);

  // Getters
	int get id => _id;
	String get name => _name;
	String get highscore => _highScore;
  String get recentscores => _recentScores;

  // Setters
	set name(String newName) {
		this._name = newName;
	}

	set highscore(String newHighScore) {
		this._highScore = newHighScore;
	}

  set recentscores(String newRecentScore) {
		this._recentScores = newRecentScore;
	}

  // Return map of id, name, [high score], [recent scores]
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		map['id'] = _id;
		map['name'] = _name;
		map['highscore'] = _highScore;
		map['recentscores'] = _recentScores;

		return map;
	}

	// Return as variables
	Player.fromMap(Map<String, dynamic> map) {
		this._id = map['id'];
		this._name = map['name'];
		this._highScore = map['highscore'];
    this._recentScores = map['recentscores'];
	}

  @override
  String toString() {
    return 'Player{id: $id, name: $name, highscore: $highscore}';
  }
}