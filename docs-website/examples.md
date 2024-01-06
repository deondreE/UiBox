# UiBox

UiBox is heavily inspired by [Shadcn Ui](https://ui.shadcn.com/docs/components/accordion) from the web world. So Every component you see shared here, is also copyable straight from this website. We encourage the use of our components, but also easily provide the code for them, so you can customize as needed.

> Code implmentations can be found inside the details blocks.

> We are soon to support android for all of our components as well.

## Components

**Progress Bar**

> Image Here...

::: tip
Please use a VStack to make it look much nicer.
:::

```swift
VStack {
  UiBox.ProgressBar()
}
```

:::details
  [Code Implementation](https://github.com/deondreE/UiBox/blob/main/Sources/UiBox/ProgressBar.swift)
:::

---

**Button**

> Image Here...

Usage:
```swift
UiBox.Button()
```

:::details
  [Code Implementation](https://github.com/deondreE/UiBox/blob/main/Sources/UiBox/UiBoxButton.swift)
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

:::details
  [Code Implementation](https://github.com/deondreE/UiBox/blob/main/Sources/UiBox/ComboBox.swift)
:::

**Calendar View**

This is a simple calendar view that looks very nice.

Usage:
```swift
UiBox.CalendarView()
```

:::details
  [Code Implementation](https://github.com/deondreE/UiBox/blob/main/Sources/UiBox/Calendar.swift)
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
