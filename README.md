# Responder Chain in SwiftUI

This is a demo app that showcases the "Chain of Responsibility" pattern used in SwiftUI.

## A little background
In the large-scale projects there are situations where we need to react on an event in a distanced module.
There exist many patterns for solving that problem - some of them good, some are really bad - but what I see common in all of them is that they all couple the event processing unit with the UI (or viewmodel / service) that sends an event.
In the UIKit world we've got [Responder Chain](https://developer.apple.com/documentation/uikit/using-responders-and-the-responder-chain-to-handle-events), which works perfectly when it comes to UI event processing.
In SwiftUI we don't have anything as handy and out-of-the box as the responder chain in UIKit, and so there goes this approach.

## Usage
Primary usage of this approach consists of a few steps:

1. Setting up a responder object for incoming events

```swift
import SwiftUI

@main
struct MyApp: App {
  @StateObject private var responderChain = ResponderChain()
  <...>

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(responderChain)
        // <...>
    }
  }
}
```

2. Rewriting triggerEvent env variable to call the associated method in the responder object

```swift
@main
struct MyApp: App {
  // <...>
  var body: some Scene {
    ContentView()
      // <...>
      .environment(\.triggerEvent) { event in
        responderChain.send(event)
      }
  }
}
```

3. Registering any view / screen as a responder

```swift
ScreenA()
  .registerResponder { event in
    // <...>
  }
```

registerResponder view modifier accepts closure in the format "(EventType) -> Bool". The Bool return value is required since it determines whether the next responder needs to be called or not.

Use it to pass a handler for this specific view.

4. Calling triggerEvent closure from any view in the hierarchy

```swift
struct ScreenB: View {
  @Environment(\.triggerEvent) var triggerEvent
  var body: some View {
    Button("card was tapped") {
      triggerEvent(.userCardWasTapped)
    }
  }
}
```
