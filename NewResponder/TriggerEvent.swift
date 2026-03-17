//
//  TriggerEvent.swift
//  NewResponder
//
//  Created by aram.azbekyan on 16.03.2026.
//

import SwiftUI

struct TriggerEventKey: EnvironmentKey {
	static let defaultValue: (Event) -> Void = { _ in
		print("ERROR! No implementation for TriggerEventKey.")
	}
}

extension EnvironmentValues {
	var triggerEvent: (Event) -> Void {
		get {
			self[TriggerEventKey.self]
		} set {
			self[TriggerEventKey.self] = newValue
		}
	}
}
