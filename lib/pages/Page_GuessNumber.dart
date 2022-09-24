import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homework3/game_console.dart';
import 'package:homework3/utills/helpers.dart';

class Guess_Number extends StatefulWidget {
  const Guess_Number({Key? key}) : super(key: key);

  @override
  State<Guess_Number> createState() => _Guess_NumberState();
}

class _Guess_NumberState extends State<Guess_Number> {
  var _input = '';
  var _feedback = 'ทายเลข 1 - 100';
  var count = 0;

  @override
  void _handleclickButton(int num) {
    setState(() {
      if (num == -1) {
        _input = _input.substring(0, _input.length - 1);
      }
      else if (num == -2) {
        _input = '';
      }
      else {
        _input = _input + num.toString();
      }
    });
  }

  var game = Game(maxRandom: 100);

  void _handleclickGuess() {
    var guess = int.tryParse(_input);
    if (guess == null) {
      showMyDialog(context, 'ERROR', 'กรุณากรอกตัวเลข');
    }
    else {
      var result = game.doGuess(guess);
      if (result == Result.tooHigh) {
        count++;
        setState(() {
          _feedback = '$_input : มากเกินไป';
          _input = '';
        });
      }
      else if (result == Result.tooLow) {
        count++;
        setState(() {
          _feedback = '$_input : น้อยเกินไป';
          _input = '';
        });
      }
      else {
        count++;
        setState(() {
          _feedback = '$_input : ถูกต้อง 🎉 (ทาย $count ครั้ง)';
          _input = '';
        });
      }
    }
  }

  Widget _buildNumberButton(int num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () {
            setState(() {
              if (num == -1) {
                _input = _input.substring(0, _input.length - 1);
              } else {
                if (_input.length < 3) {
                  _input = _input + num.toString();
                }
              }
              if (num == -2) {
                _input = "";
              }
            });
          },
          customBorder: CircleBorder(),
          child: Container(
              width: 70.0,
              height: 30.0,

              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: num != -1 || num != -2
                    ? Border.all(
                  color: Colors.black12,
                  width: 1.0,
                )
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      if(num == -1)
                        Icon(Icons.backspace_outlined,
                          color: Colors.purple,
                        )

                      else
                        if(num >= 0)
                          Text(
                              num.toString(),
                              style: GoogleFonts.firaCode(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.purple,
                              )
                          )
                        else
                          if(num == -2)
                            Icon(Icons.close,
                              color: Colors.purple,
                            )
                    ],
                  )
                ],
              )
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GUESS THE NUMBER'),
          backgroundColor: Colors.purple,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.shade100,
                    blurRadius: 5.0,
                    //spreadRadius: 2.0,
                    offset: Offset(8.0, 8.0),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 570,
                      ),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                            child: Image.asset("assets/images/guess_logo.png",
                                width: 100),
                          )),
                      Column(
                        children: [
                          Text("GUESS",
                              style: TextStyle(
                                  fontSize: 30, color: Colors.purple.shade100)),
                          Row(
                            children: [
                              Text("THE NUMBER",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.purple)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(_input,
                      style: GoogleFonts.firaCode(
                          fontSize: 40,
                          fontWeight: FontWeight.normal)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(_feedback,
                      style: GoogleFonts.firaCode(
                        fontSize: 20,
                        fontWeight: FontWeight.normal)),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNumberButton(1),
                          _buildNumberButton(2),
                          _buildNumberButton(3),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNumberButton(4),
                          _buildNumberButton(5),
                          _buildNumberButton(6),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNumberButton(7),
                          _buildNumberButton(8),
                          _buildNumberButton(9),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNumberButton(-2),
                          _buildNumberButton(0),
                          _buildNumberButton(-1),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _handleclickGuess,
                            child: Text("GUESS"),
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.purple)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              height: 800.0,
              width: 1500.0,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
            ),
          ],
        )

    );
  }


}
