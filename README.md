# MP Payment Client - Mobile App

This is a mobile application that allows the creation of orders in different stores, managing payments with Mercado Pago. It was developed with Flutter using packages for state management like GetX and http for REST requests.

![UI](https://github.com/jorgemvv01/mp_payment_client/blob/main/mp_client_ui.jpg)

## Minimum Required SDK:

Flutter 3.7.12

## Getting Started

To run the project, follow these steps:


**Step 1:**

Download or clone this repository using the following link:

```
https://github.com/jorgemvv01/mp_payment_client
```

**Step 2:**

Go to the project root and run the following command in the console to get the necessary dependencies:

```
flutter pub get 
```

**Step 3:**

Finally, run the project with the following command:

```
flutter run
```


### Folder Structures
This is the basic folder structure used to develop the project:

```
flutter-app/
|- android
|- ios
|- lib
|- linux
|- macos
|- test
|- web
|- windows
```

This is the base folder structure used to manage a type of hexagonal architecture:

```
lib/
|- domain/
|- infrastructure/
|- presentation/
|- main.dart
```

## Backend - REST API
You can view and download the implementation of the REST API by clicking [here](https://github.com/jorgemvv01/payment_gateway_mercadopago).
