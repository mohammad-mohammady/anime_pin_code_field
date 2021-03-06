library anime_pin_code_field;

import 'package:flutter/material.dart';

class AnimePinCodeField extends StatefulWidget {
  /// Width and height of [AnimePinCodeField].
  final double width, height;

  /// [Color] of input box.
  final Color inputBoxColor;

  /// Cursor [Color] of input box.
  final Color cursorColor;

  /// Call when taped on submit button.
  final Function(String pinCode) onSubmitClick;

  /// [TextEditingController] of widget;
  final TextEditingController textEditingController;

  /// Auto Focus
  final bool autoFocus;

  const AnimePinCodeField({
    Key key,
    this.width = 230.0,
    this.height = 60.0,
    this.inputBoxColor = Colors.white,
    this.cursorColor = Colors.red,
    this.onSubmitClick,
    this.textEditingController, this.autoFocus = true,
  }) : super(key: key);

  @override
  _AnimePinCodeFieldState createState() => _AnimePinCodeFieldState();
}

class _AnimePinCodeFieldState extends State<AnimePinCodeField>
    with SingleTickerProviderStateMixin {
  /// Input box width and height,
  /// [_inputBoxWidth] will be 75% of [widget.width] and
  /// [_inputBoxHeight] is [widget.height].
  double _inputBoxWidth;
  double _inputBoxHeight;

  /// Button width will be 25% of [widget.width].
  double _buttonWidth;

  /// Button icon opacity
  double _iconOpacity = 0.0;

  /// Button icon left position
  double _iconLeft = 0.0;

  /// this is (([_inputBoxWidth] / 8) * 2)
  double _digitsDistance;

  /// this is ([_inputBoxWidth] / 8)
  double _digitsPadding;

  /// values of pin code
  int _digitOne, _digitTwo, _digitThree, _digitFour;

  /// Cursor height.
  double _cursorHeight;

  /// Left and right position of cursor container.
  double _leftCursor = 0, _rightCursor;

  /// Current pin code counter.
  /// min = 0, max = 4.
  int _currentPinCounter = 0;

  /// Cursor Animation
  AnimationController _cursorAnimationController;
  Animation<double> _cursorAnimation;

  @override
  void initState() {
    _inputBoxHeight = widget.height;
    _inputBoxWidth = widget.width * .75;
    _buttonWidth = 0;
    _digitsPadding = (_inputBoxWidth / 8);
    _digitsDistance = (_inputBoxWidth / 8) * 2;
    _cursorHeight = widget.height * .9;
    _rightCursor = widget.width;
    _cursorAnimationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _cursorAnimation = CurvedAnimation(
      parent: _cursorAnimationController,
      curve: Curves.easeIn,
    );

    _cursorAnimationController.repeat(reverse: true);
    _cursorAnimationController.forward(from: 1);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _leftCursor = 0;
      _rightCursor = _inputBoxWidth - (_digitsPadding + 4);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Row(
        children: [
          buildInputBox(),
          buildButton(),
        ],
      ),
    );
  }

  Container buildInputBox() {
    return Container(
      width: _inputBoxWidth,
      height: _inputBoxHeight,
      color: widget.inputBoxColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: buildTextField(),
          ),
          Positioned(
              bottom: 0.0,
              top: 0.0,
              left: _digitsPadding,
              child: Center(
                child: staticCursorWidget(digit: _digitOne),
              )),
          Positioned(
              bottom: 0.0,
              top: 0.0,
              left: _digitsPadding + _digitsDistance,
              child: Center(
                child: staticCursorWidget(digit: _digitTwo),
              )),
          Positioned(
              bottom: 0.0,
              top: 0.0,
              left: _digitsPadding + (_digitsDistance * 2),
              child: Center(
                child: staticCursorWidget(digit: _digitThree),
              )),
          Positioned(
              bottom: 0.0,
              top: 0.0,
              left: _digitsPadding + (_digitsDistance * 3),
              child: Center(
                child: staticCursorWidget(digit: _digitFour),
              )),
          AnimatedPositioned(
            onEnd: () {
              setState(() {
                if (_currentPinCounter == 0) {
                  if (_leftCursor == _digitsPadding &&
                      _rightCursor !=
                          _inputBoxWidth -
                              (_digitsPadding + _digitsDistance + 4)) {
                    // if from init to 1 pin cursor and not comeback from 2 cursor
                    // play cursor opacity animation
                    _cursorAnimationController.forward(from: 0.0);
                    _cursorAnimationController.repeat(reverse: true);
                  }
                  if (_leftCursor == _digitsPadding &&
                      _rightCursor ==
                          _inputBoxWidth -
                              (_digitsPadding + _digitsDistance + 4)) {
                    // if from 2 to 1 pin cursor complete comeback animation
                    _leftCursor = _digitsPadding;
                    _rightCursor = _inputBoxWidth - (_digitsPadding + 4);
                  } else {
                    // if from init to 1 pin cursor complete animation to 0
                    _leftCursor = _digitsPadding;
                  }
                } else if (_currentPinCounter == 1) {
                  if (_leftCursor == _digitsPadding + _digitsDistance &&
                      _rightCursor !=
                          _inputBoxWidth -
                              (_digitsPadding +
                                  _digitsDistance +
                                  _digitsDistance +
                                  4)) {
                    // if from 2 to 3 pin cursor and not comeback from 3 cursor
                    // play cursor opacity animation
                    _cursorAnimationController.forward(from: 0.0);
                    _cursorAnimationController.repeat(reverse: true);
                  }
                  _leftCursor = _digitsPadding + _digitsDistance;
                  _rightCursor =
                      _inputBoxWidth - (_digitsPadding + _digitsDistance + 4);
                } else if (_currentPinCounter == 2) {
                  if (_leftCursor ==
                          _digitsPadding + _digitsDistance + _digitsDistance &&
                      _rightCursor !=
                          _inputBoxWidth -
                              (_digitsPadding +
                                  _digitsDistance +
                                  _digitsDistance +
                                  _digitsDistance +
                                  4)) {
                    // if from 3 to 4 pin cursor and not comeback from 4 cursor
                    // play cursor opacity animation
                    _cursorAnimationController.forward(from: 0.0);
                    _cursorAnimationController.repeat(reverse: true);
                  }
                  _leftCursor =
                      _digitsPadding + _digitsDistance + _digitsDistance;
                  _rightCursor = _inputBoxWidth -
                      (_digitsPadding + _digitsDistance + _digitsDistance + 4);
                } else if (_currentPinCounter == 3) {
                  if (_leftCursor ==
                          _digitsPadding +
                              _digitsDistance +
                              _digitsDistance +
                              _digitsDistance &&
                      _rightCursor !=
                          _inputBoxWidth -
                              (_digitsPadding +
                                  _digitsDistance +
                                  _digitsDistance +
                                  _digitsDistance +
                                  _digitsPadding)) {
                    // if from 4 to end pin cursor and not comeback from end cursor
                    // play cursor opacity animation
                    _cursorAnimationController.forward(from: 0.0);
                    _cursorAnimationController.repeat(reverse: true);
                  }
                  _leftCursor = _digitsPadding +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsDistance;
                  _rightCursor = _inputBoxWidth -
                      (_digitsPadding +
                          _digitsDistance +
                          _digitsDistance +
                          _digitsDistance +
                          4);
                } else if (_currentPinCounter == 4) {
                  _leftCursor = _digitsPadding +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsPadding;
                  _rightCursor = _inputBoxWidth -
                      (_digitsPadding +
                          _digitsDistance +
                          _digitsDistance +
                          _digitsDistance +
                          _digitsPadding);
                  _currentPinCounter = 5;
                } else if (_currentPinCounter == 5) {
                  Future.delayed(Duration(milliseconds: 150), () {
                    setState(() {
                      _buttonWidth = widget.width * .25;
                    });
                  });
                }
              });
            },
            duration: Duration(milliseconds: 250),
            top: 0.0,
            bottom: 0.0,
            left: _leftCursor,
            right: _rightCursor,
            child: Center(
              child: FadeTransition(
                opacity: _cursorAnimation,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 550),
                  color: widget.cursorColor,
                  height: _cursorHeight / 2.6,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget staticCursorWidget({int digit}) {
    return _CursorWidget(
      height: _cursorHeight,
      color: widget.cursorColor,
      number: digit,
    );
  }

  /// Main [TextField] that hide to enter numbers.
  TextField buildTextField() {
    return TextField(
      controller: widget.textEditingController,
      onChanged: (text) {
        setState(() {
          switch (text.length) {
            case 0:
              _digitOne = null;
              _digitTwo = null;
              _digitThree = null;
              _digitFour = null;

              if (_leftCursor == _digitsPadding + _digitsDistance) {
                // if comeback from 2 to 1 cursor animation
                _leftCursor = _digitsPadding;
                _rightCursor =
                    _inputBoxWidth - (_digitsPadding + _digitsDistance + 4);
              } else {
                // if from init to 1 cursor animation
                _leftCursor = _digitsPadding;
                _rightCursor = _inputBoxWidth - (_digitsPadding + 4);
              }
              break;
            case 1:
              _digitOne = int.tryParse(text[0]);
              _digitTwo = null;
              _digitThree = null;
              _digitFour = null;
              if (_leftCursor ==
                  _digitsPadding + _digitsDistance + _digitsDistance) {
                // if comeback from 3 to 2 cursor animation
                _leftCursor = _digitsPadding + _digitsDistance;
              } else {
                // if from 1 to 2 cursor animation
                _leftCursor = _digitsPadding + 4;
                _rightCursor =
                    _inputBoxWidth - (_digitsPadding + _digitsDistance + 4);
              }
              break;
            case 2:
              _digitTwo = int.tryParse(text[1]);
              _digitThree = null;
              _digitFour = null;
              if (_leftCursor ==
                  _digitsPadding +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsDistance) {
                // if comeback from 4 to 3 cursor animation
                _leftCursor =
                    _digitsPadding + _digitsDistance + _digitsDistance;
              } else {
                // if from 2 to 3 cursor animation
                _leftCursor = _digitsPadding + _digitsDistance + 4;
                _rightCursor = _inputBoxWidth -
                    (_digitsPadding + _digitsDistance + _digitsDistance + 4);
              }

              break;
            case 3:
              _digitThree = int.tryParse(text[2]);
              _digitFour = null;
              if (_leftCursor ==
                  _digitsPadding +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsPadding) {
                // if comeback from end to 4 cursor animation
                Future.delayed(Duration(milliseconds: 300), () {
                  setState(() {
                    _leftCursor = _digitsPadding +
                        _digitsDistance +
                        _digitsDistance +
                        _digitsDistance;
                  });
                });
              } else {
                // if from 3 to 4 cursor animation
                _leftCursor =
                    _digitsPadding + _digitsDistance + _digitsDistance + 4;
                _rightCursor = _inputBoxWidth -
                    (_digitsPadding +
                        _digitsDistance +
                        _digitsDistance +
                        _digitsDistance +
                        4);
              }

              /// remove submit button
              _buttonWidth = 0;
              _iconOpacity = 0;
              _iconLeft = 0;
              break;
            case 4:
              _digitFour = int.tryParse(text[3]);
              _leftCursor = _digitsPadding +
                  _digitsDistance +
                  _digitsDistance +
                  _digitsDistance +
                  4;
              _rightCursor = _inputBoxWidth -
                  (_digitsPadding +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsDistance +
                      _digitsPadding);
              break;
          }
          _currentPinCounter = text.length;

          _cursorAnimationController.forward(from: 1);
          _cursorAnimationController.stop();
        });
      },
      showCursor: false,
      maxLength: 4,
      enableInteractiveSelection: false,
      textAlign: TextAlign.center,
      autofocus: widget.autoFocus,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        counterText: '',
        border: InputBorder.none,
      ),
      style: TextStyle(fontSize: 0.1),
    );
  }

  /// Submit button.
  Widget buildButton() {
    return AnimatedContainer(
      onEnd: () {
        setState(() {
          _iconOpacity = 1;
          _iconLeft = (widget.width * .125) - 12;
        });
      },
      duration: Duration(milliseconds: 400),
      width: _buttonWidth,
      height: widget.height,
      color: widget.cursorColor,
      child: InkWell(
        onTap: () {
          if (widget.onSubmitClick != null)
            widget.onSubmitClick('$_digitOne$_digitTwo$_digitThree$_digitFour');
        },
        child: Stack(
          children: [
            AnimatedPositioned(
                top: 0,
                bottom: 0,
                left: _iconLeft,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: _iconOpacity,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
                duration: Duration(milliseconds: 200))
          ],
        ),
      ),
    );
  }
}

/// Cursor widget
// ignore: must_be_immutable
class _CursorWidget extends StatefulWidget {
  _CursorWidget(
      {Key key, @required this.height, @required this.color, this.number})
      : super(key: key);

  final double height;
  final Color color;
  int number;

  @override
  __CursorWidgetState createState() => __CursorWidgetState();
}

class __CursorWidgetState extends State<_CursorWidget> {
  bool _initail = true;

  @override
  void didUpdateWidget(covariant _CursorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.number != null) {
      Future.delayed(Duration(milliseconds: 150), () {
        setState(() {
          _initail = false;
        });
      });
    }
    else {
      _initail = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height / 2.7,
      width: widget.number == null ? 4 : null,
      color: widget.number == null
          ? widget.color.withOpacity(.2)
          : Colors.transparent,
      child: AnimatedDefaultTextStyle(
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
        style: _initail
            ? TextStyle(
                color: widget.color, fontWeight: FontWeight.bold, fontSize: 7)
            : TextStyle(
                color: widget.color, fontWeight: FontWeight.bold, fontSize: 17),
        child: Center(
          child: Text(
            widget.number == null ? '' : widget.number.toString(),
          ),
        ),
      ),
    );
  }
}
