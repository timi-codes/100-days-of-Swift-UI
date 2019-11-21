# Day 23: View and Modifiers (Part One)

#📝 Notes

Today we focused on several topics related to views, modifiers and container
- Views and modifiers: Introduction
- Why does SwiftUI use structs for views?
- What is behind the main SwiftUI view?
- Why modifier order matters
- Why does SwiftUI use “some View” for its view type?
- Conditional modifiers
- Environment modifiers
- Views as properties
- View composition
- Custom modifiers
- Custom containers

## Why does SwiftUI use struct for views
Even though there is an element of performance in using Struct over Class. Structs focuses on isolating state in a clean way so every struct class 
provides knows how to do it own logic instead of Class that provides lots of methods and store value from inherited classes.

## What is behind the main SwiftUI view?
There is simply nothing behind the main SwiftUI view. Every view is an isolated piece of UI. `UIHostingController` is the only thing behind our view which is the bridge between our SwiftUI and UIKit.

## Why modifier order matters
Their order matters because every time a modifier is applied in SwiftUi we actually create a new view with that change applied. 
Example the following code will produce a new sets of struct when the modifers are applied
```
Button("Hello World") {
    print(type(of: self.body))
}    
.background(Color.red)
.frame(width: 200, height: 200)
```

`ModifiedContent<ModifiedContent<Button<Text>, _BackgroundModifier<Color>>, _FrameLayout>`

## Why does SwiftUI use “some View” for its view type?
`some View` allows us to say our body would return a type of View which could be Button, Text e.t.c using `some View` is an example of
`opaque return type`

## Conditional modifiers
SwiftUI allows us to conditinally apply a modifier
```
struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            self.useRedText.toggle()            
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}
```

## Environment modifiers
Evironment modifiers allows us apply modifers to Views by adding the modifers to the container instead of individual items in a container View
```
VStack {
    Text("Gryffindor")
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.font(.title)
```

## Views as properties
Views can be declared as stored property. This can be help simplify complex view. However swift does not allow us create stored property that refers to ther store property.
```
struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack {
            motto1
            motto2
        }
    }
}
```

## View composition
Swift allow us to breakdown complex View down into smaller views.
```
struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}
```
Use:
```
struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
        }
    }
}
```

## Custom Modifiers
If we find ourself using a chains of modifier we can write a custom modifiers to simplify this by creating a struct that conforms to `ViewModifier Protocol`
```
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
```
Use:
```
Color.blue
    .frame(width: 300, height: 200)
    .watermarked(with: "Hacking with Swift")
```

## Custom containers
Custom Containers cam be created in Swift UI. See this GridStack Container example which uses VStack and HStack to create a grid view
```
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns){ column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
```
Use:

```
GridStack(rows: 4, columns: 4) { row, col in
    Image(systemName: "\(row * 4 + col).circle")
    Text("R\(row) C\(col)")
}
```

