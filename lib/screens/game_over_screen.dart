import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameOverScreen extends StatefulWidget {
  final FlappyBirdGame game;

   GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {


   int? lives;

   @override
  void initState() {
    // TODO: implement initState

     getLives();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score: ${widget.game.bird.score}',
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontFamily: 'Game',
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(Assets.gameOver),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text("Lives ${lives}",style:  GoogleFonts.roboto(fontSize: 30,color: Colors.white),),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  if(lives!<=0){
                    Fluttertoast.showToast(
                        msg: "Out of lives go to home page ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else{
                    onRestart();
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Restart',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  goToHome(context: context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Home',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );

  void onRestart() {
    widget.game.bird.reset();
    widget.game.overlays.remove('gameOver');
    widget.game.resumeEngine();
  }

  Future<void> getLives() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lives = prefs.getInt('lives') ?? 0; // Use null-aware operator to handle null values
    setState(() {
     if(lives!>=1){
       lives=lives!-1;
       setLives(lives: lives!);
     }
    });
  }

  setLives({required int lives}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lives', lives);
  }

  void goToHome({ required BuildContext context}) {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
}
