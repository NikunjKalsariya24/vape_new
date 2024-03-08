import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:vape/module/home_page/product_details.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  await SharedPrefService.init();


  try {

    await Firebase.initializeApp();
    //await initFcm();
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  SharedPrefService sharedPrefService = SharedPrefService();
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  try {
    String? token = await messaging.getToken();
    if (token != null) {
      sharedPrefService.setDeviceToken(token.toString());
      print("Token: ${sharedPrefService.getDeviceToken()}");
    } else {
      print('Failed to get token');
    }
  } catch (e) {
    print('Error getting token: $e');
  }


  runApp(const MyApp());
}

//  initFcm() async {
//
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   messaging.subscribeToTopic("Chat");
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   messaging.getToken().then((token) => print("FCM Token: $token"));
//   messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
// }
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   await Firebase.initializeApp();
//
//   final String? msgTitle = message.notification!.title;
//   final String? msgBody = message.notification!.body;
//   print("msgTitle${msgTitle}");
//   if (msgTitle != null && msgBody != null) {
//     print("Handling a background message: ${message.messageId}");
//     print("onBackgroundMessage $message");
//   }
//
//
//
// }
//





class MyApp extends StatefulWidget {




  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {


  // void getNotification() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //   FlutterLocalNotificationsPlugin();
  //
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  //   final InitializationSettings initializationSettings =
  //   InitializationSettings(
  //     android: initializationSettingsAndroid,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     flutterLocalNotificationsPlugin.show(
  //       0,
  //       message.notification!.title,
  //       message.notification!.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'Tik_Likes',
  //           'App Name',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //         ),
  //       ),
  //     );
  //   });
  // }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    //  getNotification();
    // TODO: implement initState
    super.initState();
    _initializeNotifications();
    _setUpFirebaseMessaging();
  }
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _setUpFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        String? imageUrl = message.data['image'];
        if (imageUrl != null) {
          await _showNotificationWithImage(
              notification, android, imageUrl, message.data);
        } else {
          await _showNotification(
              notification, android, message.data);
        }
        print("notification.body====${notification.body}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      _handleNotificationTapped(message);
    });
  }

  Future<void> _showNotification(RemoteNotification notification,
      AndroidNotification android, Map<String, dynamic> data) async {
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title ?? '',
      notification.body ?? '',
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'channel.id', 'channel.name',
              importance: Importance.max, priority: Priority.high)),
      payload: json.encode(data),
    );
  }

  Future<void> _showNotificationWithImage(
      RemoteNotification notification,
      AndroidNotification android,
      String imageUrl,
      Map<String, dynamic> data) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'channel.id',
          'channel.name',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigPictureStyleInformation(hideExpandedLargeIcon: true,
            ByteArrayAndroidBitmap(response.bodyBytes),
            //DrawableResourceAndroidBitmap(response.bodyBytes.toString()),
            //hideExpandedLargeIcon: true,
            largeIcon: ByteArrayAndroidBitmap(response.bodyBytes),
            //  FilePathAndroidBitmap(response.bodyBytes.toString()),
            contentTitle: notification.title,
            summaryText: notification.body,
          ),
        );
        var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title ?? '',
          notification.body ?? '',
          platformChannelSpecifics,
          payload: json.encode(data),
        );
      } else {
        print('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading image: $e');
    }
  }

  void _handleNotificationTapped(RemoteMessage message) {
    print("on tap notification");
    try {
      Get.toNamed(Routes.productDetails);
    } catch (e) {
      print("Error navigating to ProductDetails page: $e");
    }
  }

  @override
  Widget build(BuildContext context) {




    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      getPages:Routes.pages,
    );
  }
}

