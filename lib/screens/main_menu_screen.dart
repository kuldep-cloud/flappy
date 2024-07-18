import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuScreen extends StatefulWidget {
  final FlappyBirdGame game;
  static const String id = 'mainMenu';

  const MainMenuScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {

  int lives=0;

  @override
  void initState() {
    // TODO: implement initState
getLives();
    super.initState();

  }

  Future<void> getLives() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lives = prefs.getInt('lives') ?? 0; // Use null-aware operator to handle null values
  }

  setLives({required int lives}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lives', lives);
  }

  @override
  Widget build(BuildContext context) {
    widget.game.pauseEngine();
    getLives();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          widget.game.overlays.remove('mainMenu');
          widget.game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Assets.message),
        ),
      ),
    );
  }
}
