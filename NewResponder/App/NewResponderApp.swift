//
//  NewResponderApp.swift
//  NewResponder
//
//  Created by aram.azbekyan on 16.03.2026.
//

import SwiftUI

@main
struct NewResponderApp: App {
	@StateObject private var responderChain = ResponderChain()
	@Environment(\.triggerEvent) private var triggerEvent

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(responderChain)
				.environment(\.triggerEvent) { event in
					responderChain.send(event)
				}
        }
    }
}
