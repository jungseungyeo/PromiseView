# PromiseView

PromiseView is a lightweight and flexible SwiftUI library that enables conditional chaining and view transformation. With PromiseView, you can wrap any SwiftUI view and apply transformations based on conditions, making your view logic more expressive and modular.

## Features

- **Conditional Chaining:**  
  Easily modify or transform your views conditionally using the `then` method.

- **Type Erasure:**  
  Leverages `AnyView` to hide the underlying view types for seamless view composition.

- **SwiftUI Integration:**  
  Works with any view conforming to SwiftUI's `View` protocol with minimal setup, thanks to convenient helper extensions.

## Installation

### Swift Package Manager

Add PromiseView to your project using Swift Package Manager:

1. In Xcode, select **File > Swift Packages > Add Package Dependency...**
2. Enter the repository URL: https://github.com/jungseungyeo/PromiseView
3. Follow the prompts to complete the installation.

## Usage

Here's an example of how to use PromiseView in your SwiftUI project:

```swift
import SwiftUI
import PromiseView

struct ContentView: View {
    var body: some View {
        // Wrapping a SwiftUI view into a PromiseView
        Text("Hello, PromiseView!")
            .asPromiseView()
            .then(true,
                  then: { promise in
                      // Return the original view or a modified version when the condition is true
                      promise.asView()
                  },
                  else: { promise in
                      // Return an alternative view when the condition is false
                      Text("Condition was not met")
                  }
            )
    }
}
```

### How It Works

- **Wrapping a View:**  
    Use asPromiseView() on any SwiftUI view to wrap it as a PromiseView, making it ready for conditional transformations.

- **Conditional Transformation:**  
    The then method checks a Boolean condition. If the condition is true, it applies the then closure; otherwise, it applies the else closure. Both closures receive the current PromiseView instance and return a new view.

- **Type Erasure:**  
    Behind the scenes, PromiseView uses AnyView to hide the original view's type, allowing flexibility in chaining different types of transformations.

## API Reference

### PromiseView
A generic struct that wraps a SwiftUI view.

### Initialization

```swift
public init(_ content: ContentView)
```
- **Parameters:**  
    - **content: The SwiftUI view to be wrapped.**

### Stored Properties

- **content:**
    The original view of type ContentView.

- **anyView:**
    A type-erased wrapper (AnyView) of the original view used for rendering.

### Computed Properties
- **body:**
    Returns the wrapped view (anyView), conforming to the View protocol.

### Methods

- **then(_:then:else:):**
    Conditionally transforms the current PromiseView.
    
```swift
public func then(
    _ condition: Bool,
    then: (Self) -> some View,
    else elseClosure: (Self) -> some View
) -> PromiseView<AnyView>
```

- **Parameters:**
    - **condition: A Boolean value to decide which transformation to apply.**
    - **then: A closure that provides a new view if the condition is true.**
    - **elseClosure: A closure that provides an alternative view if the condition is false.**

- **asView():**
    Returns the originally wrapped view.

```swift
public func asView() -> ContentView
```

### Extensions on View
To seamlessly integrate with SwiftUI, PromiseView provides the following helper methods:

- **asView():**
    A no-op method that returns the view itself.

```swift
public func asView() -> Self { self }
```

- **asPromiseView():**
    Wraps the view into a PromiseView.

```swift
public func asPromiseView() -> PromiseView<Self> {
    PromiseView(self)
}
```

### License
This project is available under the MIT License. See the LICENSE file for more information.
