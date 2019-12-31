#
#  Be sure to run `pod spec lint DDToolbox.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "DDToolbox"
s.version      = "0.1.0"
s.summary      = "辅助开发工具类"
s.homepage     = "https://github.com/BrownCN023/DDToolbox"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "liyebiao1990" => "347991555@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/BrownCN023/DDToolbox.git", :tag => s.version }

#s.public_header_files = "DDToolbox/DDToolbox.h"
#s.source_files = "DDToolbox/DDToolbox.h"
s.source_files =  "DDToolbox/**/*.{h,m}"
#s.resource     = "DDToolbox/Resources/*"


s.requires_arc = true
s.frameworks = "UIKit", "Foundation"

s.dependency "Masonry", "~> 1.1.0"

end
