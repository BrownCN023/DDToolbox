#
#  Be sure to run `pod spec lint DDToolbox.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "DDToolbox"
s.version      = "0.1.3"
s.summary      = "辅助开发工具类"
s.homepage     = "https://github.com/BrownCN023/DDToolbox"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "liyebiao1990" => "347991555@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/BrownCN023/DDToolbox.git", :tag => s.version }

s.public_header_files = "DDToolbox/DDToolbox.h"
s.source_files = "DDToolbox/DDToolbox.h"
#s.resource     = "DDToolbox/Resources/*"
#s.source_files =  "DDToolbox/*.h","DDToolbox/**/*.{h,m}"

#二级目录
s.subspec "Categories" do |categories|
categories.source_files = "DDToolbox/Categories/*.{h,m}"
#categories.dependency 'DDToolbox/Other'
end
s.subspec "ListComponent" do |listcomponent|
listcomponent.source_files = "DDToolbox/ListComponent/*.{h,m}"
end
s.subspec "LoopView" do |loopview|
loopview.dependency 'DDToolbox/Other'
loopview.source_files = "DDToolbox/LoopView/*.{h,m}"
end
s.subspec "Other" do |other|
other.source_files = "DDToolbox/Other/*.{h,m}"
end
#二级目录

s.requires_arc = true
s.frameworks = "UIKit", "Foundation"
s.dependency "Masonry", "~> 1.1.0"

end
