//
//  Trarecord.swift
//  Trarecord
//

import SwiftUI

@main
struct Trarecord: App {
    @Environment(\.scenePhase) var scenePhase
    
    var content = ContentView()
    var body: some Scene {
        WindowGroup {
            self.content
        }
        .onChange(of: scenePhase) { _, phase in
            switch phase {
            case .background:
                print(".background")
            case .active:
                print(".active")
                if let bridge = Bridge.instance {
                    bridge.reinit()
                }
            default: break
            }
        }

    }
}
