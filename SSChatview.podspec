#
#  Be sure to run `pod spec lint SSChatview.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "SSChatview"
  spec.version      = "1.0.0"
  spec.summary      = "A highly customizable SwiftUI chat view which supports feature-rich chat interface."

  spec.description  = <<-DESC
                     SSChatView is a SwiftUI chat framework offering message reactions, editing, selection, custom UI themes, and real-time event simulation.
                     DESC

  spec.homepage     = "https://github.com/SimformSolutionsPvtLtd/SSChatview"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Palak Doshi" => "palak.d@simformsolutions.com" }
  spec.social_media_url   = "https://www.simform.com"

  spec.platform     = :ios, "17.0"
  spec.ios.deployment_target = "17.0"

  spec.source       = { :git => "https://github.com/SimformSolutionsPvtLtd/SSChatview.git", :tag => "{spec.version.to_spec}" }
  spec.source_files  = "Sources/SSChatview/**/*.{swift}"
  spec.resources = "Sources/SSChatview/Resources/**/*"

  spec.swift_versions = ['5.0']
  spec.frameworks = ['SwiftUI']
  
  spec.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Onone' }
  spec.requires_arc = true

end
