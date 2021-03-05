# anime_pin_code_field

Pin code field.
a pin code field for flutter, animated and customizable pin code field with 4 digits.

<img src="https://user-images.githubusercontent.com/32927238/110085356-4bc71400-7d91-11eb-8c35-0530e676a7f0.mp4" width="32%">

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
