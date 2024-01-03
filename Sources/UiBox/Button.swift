import SwiftUI



@available(iOS 17, macOS 14.0, *)
public struct Button: View {
  @Binding var ButtonType: String

    public init(ButtonType: Binding<String>) {
        self._ButtonType = ButtonType
    }
    
  public var body: some View {
    VStack {
      
    }
  }
}
