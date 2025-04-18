#
#  Be sure to run `pod spec lint SSChatview.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name         = "SSChatview"
  spec.version      = "0.0.1"
  spec.summary      = "A highly customizable SwiftUI chat view supporting 1-on-1 chats, group chats, replies, reactions and link previews."

  spec.description  = <<-DESC
                     "A highly customizable SwiftUI chat view supporting 1-on-1 chats, group chats, replies, reactions and link previews."

  spec.homepage     = "https://github.com/SimformSolutionsPvtLtd/SSChatview"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "Palak Doshi" => "palak.d@simformsolutions.com" }
  # spec.social_media_url   = "https://twitter.com/Palak Doshi"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "16.0"
  spec.ios.deployment_target = "16.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/SimformSolutionsPvtLtd/SSChatview.git", :tag => "{spec.version.to_spec}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "Sources/SSChatview/Common/*"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.resources = "Sources/SSChatview/Resources/*.png"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.swift_versions = ['5.0']
  spec.frameworks = ['SwiftUI']

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.requires_arc = true

end
