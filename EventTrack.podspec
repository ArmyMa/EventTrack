#
#  Be sure to run `pod spec lint EventTrack.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "EventTrack"
  spec.version      = "0.1"
  spec.summary      = "POC埋点SDK"
  spec.description  = "POC自用埋点SDK"
  spec.homepage     = "https://github.com/ArmyMa/EventTrack"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "ArmyMa" => "army_ma@163.com" }
  spec.source       = { :git => "https://github.com/ArmyMa/EventTrack.git", :tag => spec.version }

  spec.platform     = :ios
  spec.ios.framework = 'UIKit'
  spec.ios.deployment_target     = '10.0'
  spec.swift_version = '5.0'

  spec.source_files  = 'EventTrackSDK/EventTrackSDK/*.{h,m,swift}'
 # spec.dependency "Alamofire"

end
