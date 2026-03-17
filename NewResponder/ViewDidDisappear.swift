//
//  ViewDidDisappear.swift
//  NewResponder
//
//  Created by aram.azbekyan on 17.03.2026.
//

import SwiftUI

struct ViewDidDisappearModifier: UIViewControllerRepresentable {
	let onDidDisappear: () -> Void

	func makeUIViewController(context: Context) -> UIViewController {
		return MyViewController(onDidDisappear: onDidDisappear)
	}

	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

	class MyViewController: UIViewController {
		let onDidDisappear: () -> Void

		init(onDidDisappear: @escaping () -> Void) {
			self.onDidDisappear = onDidDisappear
			super.init(nibName: nil, bundle: nil)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		deinit {
			onDidDisappear()
		}
	}
}

extension View {
	func onDidDisappear(_ perform: @escaping () -> Void) -> some View {
		background(ViewDidDisappearModifier(onDidDisappear: perform).frame(width: 0, height: 0))
	}
}
