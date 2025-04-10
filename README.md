<p align="center">
<img src="Assets/SSCoachMarks.png" width="100%" height="100%"/>
</p>

# SSChatview

![SPM Compatible-badge](https://img.shields.io/badge/Swift_Package_Manager-compatible-coolgreen)
[![swiftUI](https://img.shields.io/badge/-swiftUI-blue)](https://developer.apple.com/documentation/swiftui)
[![Version](https://img.shields.io/cocoapods/v/SSChatview.svg?style=flat)](https://cocoapods.org/pods/SSChatview)
[![License](https://img.shields.io/cocoapods/l/SSChatview.svg?style=flat)](https://cocoapods.org/pods/SSChatview)
[![PRs Welcome][PR-image]][PR-url]
[![Twitter](https://img.shields.io/badge/Twitter-@simform-blue.svg?style=flat)](https://twitter.com/simform)

SSChatview  is swiftUI library that allows you to integrate Chat View with highly customization options such as one on one chat, group chat, message reactions, reply messages, link preview and configurations for overall view.

## Features

- [x] View Highlighting
- [x] Customizable Buttons
- [x] Guided Navigation
- [x] Customise background
- [x] Automatic Transition Timer between coach mark views

## Requirements
  - iOS 17.0+
  - Xcode 15+

## Installation
 **CocoaPods**

SSCoachMarks is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SSChatview'
```

**Swift Package Manager**

When using Xcode 15 or later, you can install `SSChatview` by going to your Project settings > `Swift Packages` and add the repository by providing the GitHub URL. Alternatively, you can go to `File` > `Add Package Dependencies...`

         dependencies: [
             .package(url: "https://github.com/SimformSolutionsPvtLtd/SSChatview.git", from: "1.0.0")
         ]

## Usage example
**1**. **Import framework**

        import SSChatview
   
**2**. **Add the modifiers to start the coach mark sequence**
- To display a coach mark with default style, the following modifier needs to be added to the main parent view to initiate the coach mark sequence.
      
         // Main Parent View
        .modifier(CoachMarkView(onCoachMarkFinished: {
            // You can perform any action after completing your coach mark sequence
        }))

-   To display a coach mark with auto-transition, the following modifier needs to be added to the main parent view to initiate the coach mark sequence.
      
        // Main Parent View
        .modifier(CoachMarkView(isAutoTransition: true,
                                autoTransitionDuration: 3,
                                onCoachMarkFinished: {
            // You can perform any action after completing your coach mark sequence
        }))
    - `isAutoTransition`: The default value is false. However, if you want to perform the coach mark sequence with auto-transition, you need to set `isAutoTransition` to true. Additionally, you can specify the duration for automatic transitions between coach marks. The default value of `autoTransitionDuration` is 2 seconds. 

-   To display a coach mark with default style with customization buttons, the following modifier needs to be added to the main parent view to initiate the coach mark sequence.
    
        // Main Parent View
        .modifier(CoachMarkView(onCoachMarkFinished: {
            // You can perform any action after completing your coach mark sequence
        })
        .coachMarkTitleViewStyle(foregroundStyle: .blue, fontSize: 14, fontWeight: .bold)
        .coachMarkDescriptionViewStyle(foregroundStyle: .pink, fontSize: 14, fontWeight: .bold)
        .overlayStyle(overlayColor: .black, overlayOpacity: 0.5)
        .nextButtonStyle(foregroundStyle: .black, backgroundColor: .green, fontSize: 14, fontWeight: .bold)
        .backButtonStyle(foregroundStyle: .black, backgroundColor: .green, fontSize: 14, fontWeight: .bold)
        .doneButtonStyle(foregroundStyle: .black, backgroundColor: .green, fontSize: 14, fontWeight: .bold)
        .skipCoachMarkButtonStyle(foregroundStyle: .black, backgroundColor: .green, fontSize: 14, fontWeight: .bold))

    - `.coachMarkTitleViewStyle`: This modifier is used to applied style all the coach mark views title
    - `.coachMarkDescriptionViewStyle`: This modifier is used to applied style all the coach mark views Description
    - `.overlayStyle`: This modifier is used to define the overlay color and opacity when the coach mark view is displayed. 
    - `.nextButtonStyle`: This modifier is used applied style for next button in all the coach mark views
    - `.backButtonStyle`: This modifier is used applied style for back button in all the coach mark views
    - `.doneButtonStyle`: This modifier is used applied style for done button in all the coach mark views
    - `.skipCoachMarkButtonStyle`: This modifier is used applied style for skip button in the coach mark view

-   To display a coach mark with customization buttons, the following modifier needs to be added to the main parent view to initiate the coach mark sequence.
            
        @State var buttonEventsCoordinator = ButtonEventsCoordinator()
            
        // Main Parent View
        .modifier(CoachMarkView(buttonEventsCoordinator: buttonEventsCoordinator,
                                skipCoachMarkButton: // Here you can add your custom skip button,
                                nextButtonContent: // Here you can add your custom next button,
                                backButtonContent: // Here you can add your custom back button,
                                doneButtonContent: // Here you can add your custom done button,
                                onCoachMarkFinished: {
            // You can perform any action after completing your coach mark sequence
        }))

**3**. **Add the code below to display coach mark views for your components.**
-   If you want to show title & description in your coach mark view then below code is you need to add in your components 
            
        .showCoachMark(order: 0,
                      title: "title of coachMark view", 
                      description: "description of coachMark view", 
                      highlightViewCornerRadius: 5)
        
        // Note: If you assign order 0, the coach mark sequence will start from that view. The coach mark views will be displayed according to the specified sequence.

-   If you want to add your custom view in coach mark view then below code is you need to add in your components 
            
        .showCoachMark(order: 2, highlightViewCornerRadius: 50) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("customBackgroundColor"))
                Text("Custom View")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
        }

        
# Demo Videos
| Default Style | Default Style With Customisation | Auto Transition | Custom Buttons |
| :--: | :-----: | :--: | :--: |
| <img width=260px src="Assets/Default_Style.gif" /> | <img width=260px src="Assets/Default_Style_With_Customization.gif" /> | <img width=260px src="Assets/Auto_Transition.gif" /> | <img width=260px src="Assets/Custom_Buttons.gif" /> |


## How to Contribute 🤝 

Whether you're helping us fix bugs, improve the docs, or a feature request, we'd love to have you! :muscle:
Check out our [**Contributing Guide**](CONTRIBUTING.md) for ideas on contributing.

## Find this example useful? ❤️

Support it by joining [stargazers](https://github.com/SimformSolutionsPvtLtd/SSChatview/stargazers) :star: for this repository.

## Bugs and Feedback

For bugs, feature feature requests, and discussion use [GitHub Issues](https://github.com/SimformSolutionsPvtLtd/SSChatview/issues).


## Check out our other Libraries

<h3><a href="https://github.com/SimformSolutionsPvtLtd/Awesome-Mobile-Libraries"><u>🗂 Simform Solutions Libraries→</u></a></h3>


## MIT License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

[PR-image]:https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat
[PR-url]:https://github.com/SimformSolutionsPvtLtd/SSChatview/pulls
[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[Swift Compatibility-badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSimformSolutionsPvtLtd%2FSSCoachMarks%2Fbadge%3Ftype%3Dswift-versions
[Platform Compatibility-badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSimformSolutionsPvtLtd%2FSSCoachMarks%2Fbadge%3Ftype%3Dplatforms
