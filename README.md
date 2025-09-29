# InstaX

A Flutter social app (instaX)

Small description: instaX is a Flutter social app built with BLoC state management. The app is connected to Firebase for authentication and data storage. 

---

## ✨ Features

- **Firebase Authentication (Email / Google)**

- **FireStore (users/ posts)**

- **BLoC for state management**
 
---


## 🖼️ Screenshots

| Sign Up | Login | Home | create Post |
|---------|------|-------|-----------------|
| <img width="1080" height="2400" alt="Screenshot_1759139322" src="https://github.com/user-attachments/assets/b22a9da6-d1bd-43e9-bf50-8c8fd5572b35" />|<img width="1080" height="2400" alt="Screenshot_1759139272" src="https://github.com/user-attachments/assets/405a079a-105b-4821-870c-e0dd4cc19ae1" />|<img width="1080" height="2400" alt="Screenshot_1759140017" src="https://github.com/user-attachments/assets/8b22f0d5-b398-440c-accd-52179eb8cd2c" />|<img width="1080" height="2400" alt="Screenshot_1759139986" src="https://github.com/user-attachments/assets/e99a27e5-4b77-4813-b386-591f0b5d2251" />|


---

## 🛠️ Firebase setup

Create a Firebase project in the Firebase console.

Enable Authentication providers you need (Email/Password, Google).

Create Firestore database (start in test mode during development).

Configure Firebase Storage rules for images.

Download google-services.json (Android) and GoogleService-Info.plist (iOS) and place them in the respective platform folders.

Ensure FlutterFire CLI is configured and flutterfire configure has been run (or manually add Firebase config).


---

## 🛠️ Project structure

```

lib/
├── blocs/
│   ├── authentication_bloc/             
│   ├── create_post_bloc/          
│   ├── get_post_bloc/              
│   ├── mu_user_bloc/            
│   ├── sign_in_bloc/            
│   └── sign_up_bloc/             
│
├── common_widgets/
│   ├── my_text_field/      
│   └── strings/      
│
├── screens/   
│   ├── authentication/      
│   └── home/      
│
├── app_view.dart
├── app.dart
├── simple_bloc_observer.dart
└── main.dart

packages/
├── post_repository/
│   ├── lib/               
│   │   ├── src/  
│   │   │   ├── entities/               
│   │   │   ├── models/ 
│   │   │   ├── firebaser_post_repository.dart              
│   │   │   └── post_repo.dart 
│   │   └── post_repository.dart   
│   │
│   └── pubspec.yaml              
│
└── user_repository/
     ├── lib/               
     │    ├── src/  
     │    │   ├── entities/               
     │    │   ├── models/ 
     │    │   ├── firebaser_user_repository.dart              
     │    │   └── user_repo.dart 
     │    └── user_repository.dart   
     │
     └── pubspec.yaml         
```


---
