# anime_pin_code_field

Pin code field.
a pin code field for flutter, animated and customizable pin code field with 4 digits.

<img src="https://user-images.githubusercontent.com/32927238/110198529-7e394580-7e53-11eb-8239-7e3a8cce4d5f.gif" width="32%">

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
