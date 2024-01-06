# UiBox

UiBox is heavily inspired by [Shadcn Ui](https://ui.shadcn.com/docs/components/accordion) from the web world. So Every component you see shared here, is also copyable straight from this website. We encourage the use of our components, but also easily provide the code for them, so you can customize as needed.

> Code implmentations can be found inside the details blocks.

> We are soon to support android for all of our components as well.

## Components

**Progress Bar**

> Image Here...

```swift
VStack { // reccomeded not required.
  UiBox.ProgressBar()
}
```

::: details

Code implementation.

```swift

```

:::

---

**Button**

> Image Here...

Usage:
```swift
UiBox.Button()
```

::: details

Code implementation.

```swift

```
:::

**ComboBox**

ComboBox is a small container, with a search bar at the top and options at the bottom.

Usage:
```swift

  let string = """ 
    [
      {"id": 0, "name": "Option 1"}
    ]
  """

   UiBox.ComboBox(dataString: <some string>)
```

::: details

Code implementation.

```swift
//
//  ComboBox.swift
//  UiBoxTarget
//
//  Created by Deondre English on 1/6/24.
//

import SwiftUI

// Option inside the of Combobox.
@available(iOS 17.0, macOS 14.0, *)
public struct Option: Identifiable, Codable, Hashable {
  public var id: Int
  public var name: String
}

// Search efforts.
@available(iOS 17.0, macOS 14.0, *)
public struct ComboSearchBar: View {
  @State private var searchText: String = ""
  @State private var filteredOptions: [Option] = []
  @Binding private var options: [Option]
  
  public init(options: Binding<[Option]>) {
    self._options =  options
  }
  
  public var body: some View {
    TextField("Search", text: $searchText)
      .padding(.top)
      .padding(.horizontal, 2)
      .padding(.vertical, 2)
      .background(
        Rectangle()
          .fill(Color.black)
          .stroke(Color.gray, lineWidth: 1)
      )
      .foregroundStyle(.white)
      .textInputAutocapitalization(.never)
      .disableAutocorrection(true)
      .onChange(of: searchText) {
        if searchText != "" {
          filterOptions()
        }
      }
  }
  
  // filter the search options, so that they are inorder.
  private func filterOptions() {
    if searchText.isEmpty {
      filteredOptions = options
    } else {
      filteredOptions = options.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
  }
}

@available(iOS 17.0, macOS 14.0, *)
public struct ComboBox: View {
  // defaults
  @State private var selectedOption: Option?
  @State private var options: [Option] = []
  @State private var isDropdownVisible: Bool = false
  @State private var contentHeight: CGFloat = 0
  @State private var buttonPosition: CGPoint = .zero
  
  // init variables.
  private var dataString: String?
  
  public init(dataString: String?) {
    self.dataString = dataString
  }

  public var body: some View {
    VStack {
      Button(action: {
        isDropdownVisible.toggle()
      }) {
        Text(selectedOption?.name ?? "Select an option")
          .foregroundStyle(.black)
      }
      .background(
        GeometryReader {
          Color.clear
            .preference(key: ButtonPositionPreferenceKey.self, value: $0.frame(in: .global).origin)
        }
      )

      Group {
        if isDropdownVisible {
          VStack {
            ComboSearchBar(options: $options)

            // If there is a larger dataset;
            ForEach(options, id: \.id) { option in
              Button(action: {
                if selectedOption == option {
                  selectedOption = Option(id: 0, name: "Select An Option")  // or set to a default option
                } else {
                  selectedOption = option
                }
                isDropdownVisible.toggle()
              }) {
                Text(option.name)
              }
              .background(.black)
              .foregroundStyle(.white)
              .padding(10)
            }
          }
          .onPreferenceChange(HeightPreferenceKey.self) {
            contentHeight = $0
          }
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.black)
              .stroke(Color.gray, lineWidth: 1)
          )
          .cornerRadius(8)
          .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
          // .frame(maxWidth: 250, maxHeight: 165, alignment: .topLeading)
          .frame(height: contentHeight)
          .padding(.horizontal)
          .position(x: buttonPosition.x + 150, y: buttonPosition.y + contentHeight + 100)
        }
      }
      .onAppear {
        if (self.dataString == nil) {
          return
        } else {
          if let jsonData = self.dataString?.data(using: .utf8) {
            do {
              let decodedOptions = try JSONDecoder().decode([Option].self, from: jsonData)
              options = decodedOptions
            } catch {
              print("Error decoding json: \(error)")
            }
          }
        }
        
      }
    }
  }
  
  // Height of the current objects, with the addition to the core object.
  private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value = max(value, nextValue())
    }
  }

  // Return the CGPoint of where the button is located.
  private struct ButtonPositionPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
      value = nextValue()
    }
  }
}

```
:::


## Custom Containers

**Input**

```md
::: info
This is an info box.
:::

::: tip
This is a tip.
:::

::: warning
This is a warning.
:::

::: danger
This is a dangerous warning.
:::

::: details
This is a details block.
:::
```

**Output**

::: info
This is an info box.
:::

::: tip
This is a tip.
:::

::: warning
This is a warning.
:::

::: danger
This is a dangerous warning.
:::

::: details
This is a details block.
:::

## More

Check out the documentation for the [full list of markdown extensions](https://vitepress.dev/guide/markdown).
