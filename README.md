# anime_pin_code_field

Pin code field.
a pin code field for flutter, animated and customizable pin code field with 4 digits.

<img src="https://user-images.githubusercontent.com/32927238/110088697-7adf8480-7d95-11eb-9367-69051b1d4815.gif" width="32%">

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
thanks to https://dribbble.com/Volorf for nice design.
