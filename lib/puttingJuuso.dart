import 'package:flutter/material.dart';

class Putting extends StatefulWidget {
  @override
  _PuttingState createState() => _PuttingState();
}

class _PuttingState extends State<Putting> {
  List<bool> selections = List.generate(5, (index) => false);
  bool isRingSelected = false;
  String selectedRing = null;

  void callback(String ring, int index) {
    setState(() {
      selections = List.generate(5, (index) => false);
      for (var i = index; i < 5; i++) {
        selections[i] = !selections[i];
      }
      isRingSelected = true;
      selectedRing = ring;
      print(selectedRing);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          color: Colors.blue,
          child: Text('test'),
        ),
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(),
            child: Stack(children: [
              Stack(
                children: [
                  Transform(
                    transform: Matrix4.translationValues(
                        0, -MediaQuery.of(context).size.width / 2, 0),
                    child: Transform.scale(
                      scale: 1.4,
                      child: RingBuilder(
                          callback: callback,
                          context: context,
                          ringValue: [
                            '>10m',
                            '8–10m',
                            '6–8m',
                            '4–6m',
                            '<4m',
                          ],
                          isSelected: selections),
                    ),
                  )
                ],
              ),

              // Went In and Next Putt buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: isRingSelected ? () {} : null,
                            style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 16,
                                )),
                                side: MaterialStateProperty.all(BorderSide(
                                    width: 1,
                                    color: isRingSelected
                                        ? Colors.blue[400]
                                        : Colors.black26)),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width / 2 - 40,
                                    MediaQuery.of(context).size.width / 4 -
                                        20))),
                            child: Text('WENT IN')),
                        ElevatedButton(
                            onPressed: isRingSelected ? () {} : null,
                            style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 16,
                                )),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width / 2 - 40,
                                    MediaQuery.of(context).size.width / 4 -
                                        20))),
                            child: Row(
                              children: [
                                Text('NEXT PUTT'),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }
}

typedef Callback = void Function(String test, int index);

class RingBuilder extends StatelessWidget {
  final Callback callback;
  final List<String> ringValue;
  final BuildContext context;
  final List<bool> isSelected;

  RingBuilder({
    @required this.callback,
    @required this.ringValue,
    @required this.context,
    @required this.isSelected,
  });

  List<Widget> buildRingStack(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    List<Widget> _rings = [];
    int ringCount = ringValue.length;

    for (var i = 0; i < ringCount; i++) {
      _rings.add(Ring(
        ringText: ringValue[i],
        size: _screenWidth - i * _screenWidth / ringCount / 1.1,
        isActive: isSelected[i],
        callback: callback,
        index: i,
      ));
    }

    return _rings;
  }

  Widget basketFigure(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    int ringCount = ringValue.length;
    double size = _screenWidth - ringCount * _screenWidth / ringCount / 1.1;

    return IgnorePointer(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5, color: Colors.yellow[500])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Stack(
        alignment: Alignment.center,
        children: List.unmodifiable(() sync* {
          yield* buildRingStack(context);
          yield basketFigure(context);
        }()),
      ),
    );
  }
}

class Ring extends StatelessWidget {
  final Callback callback;
  final String ringText;
  final double size;
  final bool isActive;
  final int index;

  Ring(
      {@required this.callback,
      @required this.ringText,
      @required this.size,
      @required this.isActive,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? Colors.blue[500] : Colors.white,
      shape: CircleBorder(),
      elevation: isActive ? 3 : 1,
      child: GestureDetector(
        onTap: () {
          callback(ringText, index);
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  ringText,
                  style:
                      TextStyle(color: isActive ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
