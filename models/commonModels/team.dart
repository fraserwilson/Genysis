import '../managerModels/manager.dart';
import 'player.dart';

class Team{

  final String name;
  final Player players;
  final Manager manager;
  final int rating;

  Team(this.name,this.players,this.manager,this.rating);
  

}