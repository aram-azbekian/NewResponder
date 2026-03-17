//
//  ResponderChain.swift
//  NewResponder
//
//  Created by aram.azbekyan on 17.03.2026.
//

import Combine
import SwiftUI

final class ResponderChain: ObservableObject {
	typealias Handler = (Event) -> Bool

	private var order: [UUID] = []
	private var handlers: [UUID: Handler] = [:]

	func register(id: UUID, handler: @escaping Handler) -> Void {
		print("register: \(id)")
		guard handlers[id] == nil else { return }
		handlers[id] = handler
		order.append(id)
	}

	func deregister(id: UUID) -> Void {
		print("deregister: \(id)")
		handlers[id] = nil
		order.removeAll { $0 == id }
	}

	func send(_ event: Event) -> Void {
		for id in order.reversed() {
			if let handler = handlers[id], handler(event) {
				return
			}
		}
		print("There were no handlers for this event: \(event)")
	}
}

struct ResponderChainModifier: ViewModifier {
	@EnvironmentObject private var responderChain: ResponderChain

	private let id = UUID()

	let handler: ResponderChain.Handler

	func body(content: Content) -> some View {
		content
			.onAppear {
				responderChain.register(id: id, handler: handler)
			}
			.onDidDisappear {
				responderChain.deregister(id: id)
			}
	}
}

extension View {
	func registerResponder(handler: @escaping ResponderChain.Handler) -> some View {
		self.modifier(ResponderChainModifier(handler: handler))
	}
}
