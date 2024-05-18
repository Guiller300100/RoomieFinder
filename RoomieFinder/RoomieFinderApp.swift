//
//  RoomieFinderApp.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI
import Firebase

@main
struct RoomieFinderApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            LoginView(LoginViewModel())
                .environmentObject(GlobalViewModel.shared)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {

        print("CerrandoApp")

        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                // Cerrar sesión exitosamente
                print("Sesión cerrada exitosamente.")
            } catch let error as NSError {
                // Manejar el error
                print("Error al cerrar sesión: \(error.localizedDescription)")
            }
        }
    }
}
