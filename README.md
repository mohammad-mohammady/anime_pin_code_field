# anime_pin_code_field

Pin code field.
a pin code field for flutter, animated and customizable pin code field with 4 digits.

<img src="demo.mp4" width="32%">

| Property | Description |
| --- | --- |
| `width` | Width of widget |
| `height` | Height of widget |
| `inputBoxColor` | Background color of widget |
| `cursorColor` | Color of cursor |
| `onSubmitClick` | When user tap on submit button onSubmitClick will call  |
| `textEditingController` | Text controller of pin code  |



Usage
-----

```dart
AnimePinCodeField(
    onSubmitClick: (pinCode) {
      print('pin code is: $pinCode');
    },
  )
```