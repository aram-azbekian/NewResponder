//
//  ContentView.swift
//  NewResponder
//
//  Created by aram.azbekyan on 16.03.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		NavigationStack {
			NavigationLink(value: "screenA", label: { Text("Go Screen A") })
				.navigationDestination(for: String.self) { value in
					if value == "screenA" {
						ScreenA()
							.registerResponder { event in
								guard event == .userCardWasTapped else {
									return false
								}
								print("Successfully processed userCardWasTapped event")
								return true
							}
					} else if value == "screenB" {
						ScreenB()
					} else if value == "screenC" {
						ScreenC()
							.registerResponder { event in
								guard event == .restartButtonWasTapped else {
									return false
								}
								print("Successfully processed restartButtonWasTapped event")
								return true
							}
					} else if value == "screenD" {
						ScreenD()
					} else {
						Text("This is an error screen")
					}
				}
		}
    }
}

#Preview {
    ContentView()
}

struct ScreenA: View {
	var body: some View {
		NavigationLink(value: "screenB", label: { Text("Go Screen B") })
	}
}

struct ScreenB: View {
	@Environment(\.triggerEvent) var triggerEvent
	var body: some View {
		VStack {
			NavigationLink(value: "screenC", label: { Text("Go Screen C") })

			Button("card was tapped") {
				triggerEvent(.userCardWasTapped)
			}

			Button("did swipte reminder") {
				triggerEvent(.didSwipeReminder)
			}

			Button("restard button was tapped") {
				triggerEvent(.restartButtonWasTapped)
			}
		}
	}
}

struct ScreenC: View {
	var body: some View {
		NavigationLink(value: "screenD", label: { Text("Go Screen D") })
	}
}

struct ScreenD: View {
	@Environment(\.triggerEvent) var triggerEvent

	var body: some View {
		VStack {
			Button("card was tapped") {
				triggerEvent(.userCardWasTapped)
			}

			Button("did swipte reminder") {
				triggerEvent(.didSwipeReminder)
			}

			Button("restard button was tapped") {
				triggerEvent(.restartButtonWasTapped)
			}
		}
	}
}
