#
#  Be sure to run `pod spec lint EventTrack.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "EventTrack"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of EventTrack."
  spec.homepage     = "https://github.com/ArmyMa/EventTrack.git"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author       = { "ArmyMa" => "army_ma@163.com" }
  spec.source       = { :git => "https://github.com/ArmyMa/EventTrack.git", :tag => "#{spec.version}" }

  spec.platform     = :ios
  spec.ios.deployment_target     = '11.0'
  spec.swift_version = '5.0'

  # spec.source_files  = "EventTrack/*.{h,m}"

 # spec.dependency "Alamofire"

end
