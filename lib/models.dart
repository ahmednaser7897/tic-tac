import 'dart:math';

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
  static List<int> playerX = [];
  static List<int> playerO = [];
}
extension ContainsAll on List{
  bool containsAll(int x,int y, {z}){
    if(z==null){
      return contains(x)&&contains(y);
    }else{
      return contains(x)&&contains(y)&&contains(z);
    }
  }
  
}
class Game {
  
  String checkWinner() {
    String winner="";
    if(Player.playerX.containsAll(0, 1, z: 2)){
      winner="X";
    }
    if(Player.playerX.containsAll(3, 4, z:5)){
      winner="X";
    }
    if(Player.playerX.containsAll(6, 7, z:8)){
      winner="X";
    }
    if(Player.playerX.containsAll(0, 4, z: 8)){
      winner="X";
    }
    if(Player.playerX.containsAll(2, 4, z: 6)){
      winner="X";
    }
    if(Player.playerX.containsAll(0, 3, z:6)){
      winner="X";
    }
    if(Player.playerX.containsAll(1, 4, z:7)){
      winner="X";
    }
    if(Player.playerX.containsAll(2, 5, z:8)){
      winner="X";
    }



    if(Player.playerO.containsAll(0, 1, z:2)){
      winner="O";
    }
    if(Player.playerO.containsAll(3, 4, z:5)){
      winner="O";
    }
    if(Player.playerO.containsAll(6, 7, z:8)){
      winner="O";
    }
    if(Player.playerO.containsAll(0, 4, z:8)){
      winner="O";
    }
    if(Player.playerO.containsAll(2, 4, z:6)){
      winner="O";
    }
     if(Player.playerO.containsAll(0, 3, z:6)){
      winner="O";
    }
    if(Player.playerO.containsAll(1, 4, z:7)){
      winner="O";
    }
    if(Player.playerO.containsAll(2, 5, z:8)){
      winner="O";
    }


    return winner;

  }

  void playGame(int index, String player) {
    if (player == "X") {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  Future<void> autoPlay(String player) async{
    int indix = 0;
    List<int> empty = [];
    for (int i = 0; i < 9; i++) {
      if (!Player.playerO.contains(i) && !Player.playerX.contains(i)) {
        empty.add(i);
      }
    }
    Random r=Random();
    if(empty.isNotEmpty){
      int rand=r.nextInt(empty.length);
      indix=empty[rand];
      playGame(indix, player);
    }
  }
}
