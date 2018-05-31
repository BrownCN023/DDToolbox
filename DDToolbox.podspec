#
#  Be sure to run `pod spec lint DDToolbox.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "DDToolbox"
s.version      = "0.0.2"
s.summary      = "辅助开发工具类"
s.homepage     = "https://github.com/BrownCN023/DDToolbox"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "liyebiao1990" => "347991555@qq.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/BrownCN023/DDToolbox.git", :tag => s.version }

s.source_files =  "DDToolbox/*.h","DDToolbox/Core/**/*.{h,m}","DDToolbox/Core/*.h","DDToolbox/UI/**/*.{h,m}"
s.resources    = 'DDToolbox/Resources/*.bundle'
s.requires_arc = true
s.dependency "Masonry", "~> 1.1.0"
s.dependency "AFNetworking", "~> 3.2.1"
s.dependency "SDWebImage", "~> 4.3.3"

end
