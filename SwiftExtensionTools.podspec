#
#  Be sure to run `pod spec lint SwiftExtensionTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name             = "SwiftExtensionTools"
  spec.version          = "0.0.1"
  spec.summary          = "Swift常用小工具"
  spec.description      = "Swift常用小工具,方便开发"
  spec.homepage         = "https://www.jianshu.com/u/cd395981b31d"
  #spec.screenshots     = ""
  spec.license          = { :type => "GNU General Public License v3.0", :file => "LICENSE" }
  spec.author           = { "ZYiDa" => "468466882@qq.com" }
  spec.platform         = :ios, "11.0"
  spec.swift_versions   = "5.0"
  spec.source           = { :git => "https://github.com/ZYiDa/SwiftExtensionTools.git", :tag => "0.0.1" }
  spec.source_files     = "SwiftExtensionTools/*.swift"
  spec.resources        = "SwiftExtensionTools/*.xcassets"
  spec.framework        = "UIKit"
  spec.dependency 'MJRefresh'
  spec.dependency 'MBProgressHUD'
  spec.dependency 'EmptyDataSet-Swift'
  spec.requires_arc     = true
end
