#
#  Be sure to run `pod spec lint DDToolbox.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "DDToolbox"
s.version      = "0.0.9"
s.summary      = "辅助开发工具类"
s.homepage     = "https://github.com/BrownCN023/DDToolbox"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "liyebiao1990" => "347991555@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/BrownCN023/DDToolbox.git", :tag => s.version }

s.public_header_files = "DDToolbox/DDToolbox.h"
s.source_files = "DDToolbox/DDToolbox.h"
s.resource     = "DDToolbox/Resources/*"
#s.source_files =  "DDToolbox/*.h","DDToolbox/**/*.{h,m}"

#二级目录
s.subspec "MVP" do |mvp|
mvp.source_files = "DDToolbox/MVP/*.{h,m}"
end
s.subspec "Common" do |common|
common.source_files = "DDToolbox/Common/*.{h,m}"
end
s.subspec "Macro" do |macro|
macro.source_files = "DDToolbox/Macro/*.{h,m}"
end
s.subspec "Model" do |model|
model.source_files = "DDToolbox/Model/*.{h,m}"
end
s.subspec "ViewModel" do |viewmodel|
viewmodel.source_files = "DDToolbox/ViewModel/*.{h,m}"
end
s.subspec "UIComponents" do |components|
components.dependency 'DDToolbox/Macro'
components.dependency 'DDToolbox/Common'
components.dependency 'DDToolbox/ViewModel'
components.source_files = "DDToolbox/UIComponents/*.{h,m}"
end
#二级目录

s.requires_arc = true
s.frameworks = "UIKit", "Foundation"

s.dependency "Masonry", "~> 1.1.0"
s.dependency "SDWebImage", "~> 4.3.3"
s.dependency "DDLoadingView", "~> 0.0.4"
s.dependency "DDModal", "~> 1.0.21"
s.dependency "DDCircleProgressView", "~> 0.0.4"
s.dependency "DDHTTPClient", "~> 0.0.6"

end
