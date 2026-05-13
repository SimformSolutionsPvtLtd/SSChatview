![Banner](https://raw.githubusercontent.com/SimformSolutionsPvtLtd/SSChatview/master/Assets/SSChatview.png)

# SSChatview
### Bring iMessage-like chat to life with rich features, seamless SwiftUI support and effortless customization.

[![SPM Compatible][spm-image]][spm-url]
[![Pods][cocoa-image]][cocoa-url]
[![SwiftUI][swiftUI-image]][swiftUI-url]
[![Carthage Compatible][carthage-image]][carthage-url]
[![License][license-image]](LICENSE)
[![PRs Welcome][PR-image]][PR-url]
[![Twitter][twitter-image]][twitter-url]

SSChatView is a SwiftUI library that brings an iMessage-style chat experience to your app with ease. It offers a sleek, customizable interface with built-in support for message editing, reactions, multi-selection, and an expandable input field — all designed to seamlessly match your app’s look and feel.

### Table of contents
1. [Key Features](#key-features)
2. [Demo Videos](#demo-videos)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [How to Use](#how-to-use)

## Key Features

✅ iMessage-Inspired SwiftUI Interface  
✅ Interactive Message Actions: Edit, Delete, React and Undo  
✅ Expandable Smart Input Field  
✅ Intelligent Scroll Behavior  
✅ Adaptive Layout for Long Messages  
✅ Fully Customizable Design  

## Demo Videos
| React and Delete Message | Send Message and Scroll to Bottom | Edit Message | 
| :--: | :-----: | :--: | 
| <img width=260px src="https://raw.githubusercontent.com/SimformSolutionsPvtLtd/SSChatview/master/Assets/React_Delete_Message.gif" /> | <img width=260px src="https://raw.githubusercontent.com/SimformSolutionsPvtLtd/SSChatview/master/Assets/Send_ScrollToNew_Message.gif" /> | <img width=260px src="https://raw.githubusercontent.com/SimformSolutionsPvtLtd/SSChatview/master/Assets/Edit_Message.gif" /> | 

## Requirements
- iOS 17.0+
- Xcode 15+

## Installation
### 📦 CocoaPods

SSChatview is available through [CocoaPods][cocoapods-url]. To install it, simply add the following line to your `Podfile`:

```ruby
platform :ios, '17.0'
use_frameworks!

target '<Your Target Name>' do
pod 'SSChatview'
end
```

### 📦 Swift Package Manager

When using Xcode 15 or later, you can install `SSChatview` through [Swift Package Manager][spm-url] by going to your project settings > `Swift Packages` and add the repository by providing the GitHub URL.  
Alternatively, you can go to `File` > `Add Package Dependencies...`

```
dependencies: [
    .package(url: "https://github.com/SimformSolutionsPvtLtd/SSChatview.git", from: "1.0.0")
]
```

### 📦 Carthage
[Carthage][carthage-url] is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. You can install Carthage with [Homebrew][homebrew-url] using the following command:

```
$ brew update
$ brew install carthage
```

To integrate `SSChatview` into your Xcode project using Carthage, add the following line to your `Cartfile`:

```
github "mobile-simformsolutions/SSChatview"
```

Run `carthage` to build and drag the `SSChatview`(Sources/SSChatview) into your Xcode project.

### 📦 Manually
-   Download and drop **SSChatview** folder in your project.
-   Congratulations!

## How to Use
**1**. **Import framework**

Start by importing the library into your SwiftUI file:

```
import SSChatview
```
        
**2**. **Add SSChatScreenView**
 
To display the complete chat experience, embed SSChatScreenView in your SwiftUI view.  
Ensure your view model conforms to SSChatDelegate to handle actions like sending, editing, deleting, undoing, and reacting to messages.

✅ Step 1: Create Initial Messages
Preload the chat with existing or mock messages:

```
import SSChatview

// MARK: - ChatMessagesData
struct ChatMessagesData {
    static let initialMessages: [MessageResponseModel] = [
        MessageResponseModel(
            content: "Hey, how’s it going?",
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1751453887)
        ),
        MessageResponseModel(
            content: "All good!😄",
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1751453887)
        )
    ]
}
```
✅ Step 2: Create a View Model
Implement an ObservableObject that holds your messageArray and conforms to SSChatDelegate:

```
import SSChatview

class ChatViewModel: ObservableObject {
    // MARK: - Variables
    @Published var messageArray: [MessageResponseModel] = ChatMessagesData.initialMessages
}

extension ChatViewModel: SSChatDelegate {
    func didSendMessage(_ message: MessageResponseModel) {
        // Handle new message
    }

    func didEditMessage(messageID: String, editedMessage: String) {
        // Handle message edit
    }

    func didDeleteMessages(_ messageIDs: [String]) {
        // Handle message deletion
    }

    func didReactToMessage(_ messageID: String, reaction: ReactionType) {
        // Handle reaction
    }

    func didUndoMessage(_ messageID: String) {
        // Handle undo
    }
}
```

✅ Step 3: Embed in Your SwiftUI View
Finally, embed SSChatScreenView in your SwiftUI view to display the chat interface:
```
import SSChatview

struct ContentView: View {
    // MARK: - Variables
    @StateObject private var viewModel = ChatViewModel()

    // MARK: - Body
    var body: some View {
        SSChatScreenView(
            delegate: viewModel,
            messageArray: $viewModel.messageArray,
            userName: "John Doe",
            userProfileImage: "profile_image"
        )
    }
}
```

**3**. **Customize the Chat UI (Optional)**
Want full control? Customize the look and behavior using `SSChatConfiguration`.

```
private var chatConfig: SSChatConfiguration {
    SSChatConfiguration(
        colors: CustomColorPalette(),  // Override chat colors
        fonts: CustomFontScheme(),     // Apply custom fonts
        strings: CustomStrings(),      // Change labels/texts
        images: CustomImageAssets()    // Use custom icons
    )
}
```

Inject into the environment:

```
.environment(\.ssChatConfig, chatConfig)
```

### 🧩 Examples of Customization

#### ➡️ Custom Colors
Conform to SSChatColorPalette and override only the colors you need:

```
struct CustomColorPalette: SSChatColorPalette {
    var primaryBackground: Color { Color(appColor.chatBackground.name) }
    var currentUserMessageText: Color { Color.blue }
    // Override others as needed...
}
```

#### ➡️ Custom Fonts
Conform to SSChatFontScheme to use your own font styles:

```
struct CustomFontScheme: SSChatFontScheme {
    var regular: Font { Font.custom("Poppins-Regular", size: 16) }
    var bold: Font { Font.custom("Poppins-Bold", size: 16) }
    // Provide other styles like medium, small...
}
```

#### ➡️ Custom Strings
Conform to SSChatStrings to localize or rename built-in text:

```
struct CustomStrings: SSChatStrings {
    var smsText: String { "Text Message" }
}
```

#### ➡️ Custom Icons
Conform to SSChatImageAssets to swap default icons:

```
struct CustomImageAssets: SSChatImageAssets {
    var send: String { "customSendIcon" }
}
```

💡 Only override what you need. All properties have sensible defaults.

## How to Contribute 🤝 

Whether you’re helping fix bugs, improve documentation, or suggest new features — we’d love your support! :muscle:  
Check out our [**Contributing Guide**](CONTRIBUTING.md) for ideas on contributing.

## Find this example useful? ❤️

Support it by joining [stargazers][stargazers-url] :star: for this repository.

## Bugs and Feedback 🐞

For bugs, feature requests, or discussion please use [GitHub Issues][githubIssues-url].

## Check out our other Libraries 🗂
### [Simform Solutions Libraries →][awesome-mobile-libraries-url]

## MIT License ⚖️

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[spm-image]:https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg
[spm-url]:https://swift.org/package-manager
[cocoa-image]:https://img.shields.io/cocoapods/v/SSChatview.svg?style=flat&label=SSChatview
[cocoa-url]:https://cocoapods.org/pods/SSChatview
[swiftUI-image]:https://img.shields.io/badge/-swiftUI-blue
[swiftUI-url]:https://developer.apple.com/documentation/swiftui
[carthage-image]:https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat
[carthage-url]:https://github.com/Carthage/Carthage
[license-image]:https://img.shields.io/badge/License-MIT-blue.svg
[PR-image]:https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[PR-url]:https://github.com/SimformSolutionsPvtLtd/SSChatview/pulls
[twitter-image]:https://img.shields.io/badge/Twitter-@simform-blue.svg?style=flat
[twitter-url]:https://twitter.com/simform
[cocoapods-url]:https://cocoapods.org
[homebrew-url]:http://brew.sh/
[stargazers-url]:https://github.com/SimformSolutionsPvtLtd/SSChatview/stargazers 
[githubIssues-url]:https://github.com/SimformSolutionsPvtLtd/SSChatview/issues
[awesome-mobile-libraries-url]:https://github.com/SimformSolutionsPvtLtd/Awesome-Mobile-Libraries
