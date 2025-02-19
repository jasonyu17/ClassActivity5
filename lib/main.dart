import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}



class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}


class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  final TextEditingController _controller = TextEditingController();
  int happinessLevel = 50;
  int hungerLevel = 50;
  Color petColor = Colors.green;
  String petMood = "Happy";

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showMyDialog(); // Now it's safe to use context
  });
}

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _petColor();
      _petMood();
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
    });
  }

  void _petColor(){
    setState(() {
      if (happinessLevel < 30 ) {
        petColor = Colors.red;
      } 
      else if (happinessLevel < 70) {
        petColor = Colors.yellow;
      }
      else {
        petColor = Colors.green;
      }
    });
  }

  void _petMood(){
    setState(() {
      if (happinessLevel < 30 ) {
        petMood = "Sad";
      } 
      else if (happinessLevel < 70) {
        petMood = "Neutral";
      }
      else {
        petMood = "Happy";
      }
    });
  }

  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel + 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel - 10).clamp(0, 100);
    }
    _petColor();
    _petMood();
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
  }

  void _setPetName(String value) {
    setState(() {
      petName = value;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: petColor,),
              
            ),
            Text('$petMood', style: TextStyle(fontSize: 20.0),),
            
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,  // Context now correctly belongs to _DigitalPetAppState
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Pet Name'),
        actions: <Widget>[
          TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Pet Name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _setPetName,
            ),
        ],
      );
    },
  );
}

}


