// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct PromiseView<ContentView: View>: View {
    
    private var anyView: AnyView
    private var content: ContentView
    
    /// Initializer
    /// - Parameter content: The computed property body: some View returns the anyView. This is the view that SwiftUI will use when rendering the PromiseView.
    public init(_ content: ContentView) {
        self.content = content
        self.anyView = AnyView(content)
    }
    
    public var body: some View {
        anyView
    }
}

extension PromiseView {
    
    /// The then method allows you to conditionally transform the current PromiseView based on a boolean condition.
    /// - Parameters:
    ///   - condition: A Bool value that determines which closure to execute.
    ///   - then: A closure that takes the current PromiseView (Self) and returns some view. This closure is executed if condition is true.
    ///   - elseClosure: A closure (labelled with else) that takes the current PromiseView and returns some view. It is executed if condition is false.
    /// - Returns: The method returns a new PromiseView wrapping an AnyView.
    public func then(
        _ condition: Bool,
        then: (Self) -> some View,
        else elseClosure: (Self) -> some View
    ) -> PromiseView<AnyView> {
        let view: AnyView = condition
            ? AnyView(then(self))
            : AnyView(elseClosure(self))
        return PromiseView<AnyView>(view)
    }
    
    /// - Parameters:
    ///   - condition: A Bool value that determines which closure to execute.
    ///   - then: A closure that takes the current PromiseView (Self) and returns some view. This closure is executed if condition is true.
    /// - Returns: The method returns a new PromiseView wrapping an AnyView.
    public func then(
        _ condition: Bool,
        then: (Self) -> some View
    ) -> PromiseView<AnyView> {
        let view: AnyView = condition ? AnyView(then(self)) : AnyView(self)
        return PromiseView<AnyView>(view)
    }
    
    /// This method simply returns the original content view (content) of type ContentView.
    /// - Returns: content
    public func asView() -> ContentView {
        return content
    }
}

extension View {
    
    /// This extension provides helper methods to easily convert any view into the wrapped forms:
    /// This method returns the view itself. It is essentially a no-op but provides a consistent interface when chaining view transformations.
    ///
    ///  ex)
    ///  PromiseView(Text("123")) // => PromiseView<Text>
    ///     .asView()             // => Text
    ///
    /// - Returns: ConentView
    public func asView() -> Self { self }
    
    /// This method wraps the view in a PromiseView. It makes it easy to start using the PromiseView functionality on any view by converting it into a PromiseView.
    ///
    ///  ex)
    ///  PromiseView(Text("123")) // => PromiseView<Text>
    ///     .asView()             // => Text
    ///     .asPromiseView()      // => PromiseView<Text>
    ///
    /// - Returns: PromiseView
    public func asPromiseView() -> PromiseView<Self> {
        PromiseView(self)
    }
}

#Preview("Default View") {
    PromiseView(Text("123"))
}

#Preview("true View") {
    PromiseView(Text("123"))
        .then(true,
            then: { $0.background(Color.red) },
            else: { $0.background(Color.blue) }
        )
}

#Preview("flase View") {
    PromiseView(Text("123"))
        .then(false,
            then: { $0.background(Color.red) },
            else: { $0.background(Color.blue) }
        )
}
