## **Flutter API Integration Demo**  

This project is a simple Flutter application that demonstrates how to integrate and use third-party APIs for user authentication. The retrieved data from the API is then used to populate a local database. The primary goal of this project is to gain a better understanding of working with APIs in a real-world application and how to handle the authentication process efficiently.  

## **Features**  
- User login via an API call  
- Storage of retrieved user data in a local database  
- Input validation for username and password fields  
- Error handling for incorrect login attempts

## **Technologies & Frameworks Used**  
- **Flutter** – UI framework for building cross-platform applications  
- **Dart** – Programming language for Flutter  
- **SQLite** – Database for storing user information    

## **Installation & Setup**  
### **Prerequisites**  
Ensure you have the following installed:  
- Flutter SDK (Latest Stable Version)  
- Dart SDK  
- Android Studio or VS Code with Flutter Plugin  
- A simulator/emulator or a physical device  

### **Clone the Repository**  
```sh
git clone https://github.com/YOUR_USERNAME/flutter-login-api.git
cd flutter-login-api
```

### **Install Dependencies**  
```sh
flutter pub get
```

### **Run the Application**  
```sh
flutter run
```

## **Usage**  
1. Enter a valid username and password  
2. The app will send the login credentials to the API  
3. If authenticated, the API returns user data, which is stored in the database  
4. The app navigates to the home screen upon successful login  
5. If authentication fails, an error message is displayed  

## **License**  
This project is open-source and available under the MIT License.
