Pod::Spec.new do |s|

  s.name         = "WHC_AutoLayoutKit"
  s.version      = "2.8.3"
  s.summary      = "Service to update constraints, convenient and quick dynamic UI layout，服务于更新约束方便快捷动态UI构建的自动布局库，支持Cell高度自动，view高宽自动"

  s.homepage     = "https://github.com/netyouli/WHC_AutoLayoutKit"

  s.license      = "MIT"

  s.author             = { "吴海超(WHC)" => "712641411@qq.com" }

  s.source       = { :git => "https://github.com/netyouli/WHC_AutoLayoutKit.git", :tag => "2.8.3"}

  s.source_files  = "WHC_AutoLayoutKit/WHC_AutoLayout.h"
  s.public_header_files = 'WHC_AutoLayoutKit/WHC_AutoLayout.h'

  s.ios.frameworks = 'Foundation', 'UIKit'
  s.tvos.frameworks = 'Foundation', 'UIKit'
  s.osx.frameworks = 'Foundation', 'AppKit'

  s.ios.deployment_target = '6.0' 
  s.osx.deployment_target = '10.7' 
  s.tvos.deployment_target = '9.0' 

  s.subspec 'Util' do |ss|
    ss.source_files = 'WHC_AutoLayoutKit/Util/*.h'
    ss.public_header_files = 'WHC_AutoLayoutKit/Util/*.h'
  end

  s.subspec 'LayoutView' do |ss|
    ss.dependency 'WHC_AutoLayoutKit/Util'
    ss.source_files = 'WHC_AutoLayoutKit/LayoutView/*.{h,m}'
    ss.public_header_files = 'WHC_AutoLayoutKit/LayoutView/*.h'
  end

  s.subspec 'StackView' do |ss|
    ss.dependency 'WHC_AutoLayoutKit/LayoutView'
    ss.dependency 'WHC_AutoLayoutKit/Frame'
    ss.source_files = 'WHC_AutoLayoutKit/StackView/*.{h,m}'
    ss.public_header_files = 'WHC_AutoLayoutKit/StackView/*.h'
  end

  s.subspec 'LayoutGuide' do |ss|
    ss.dependency 'WHC_AutoLayoutKit/Util'
    ss.source_files = 'WHC_AutoLayoutKit/LayoutGuide/*.{h,m}'
    ss.public_header_files = 'WHC_AutoLayoutKit/LayoutGuide/*.h'
  end

  s.subspec 'Frame' do |ss|
    ss.dependency 'WHC_AutoLayoutKit/Util'
    ss.source_files = 'WHC_AutoLayoutKit/Frame/*.{h,m}'
    ss.public_header_files = 'WHC_AutoLayoutKit/Frame/*.h'
  end

  s.subspec 'AutoCellHeight' do |ss|
    ss.dependency 'WHC_AutoLayoutKit/Util'
    ss.dependency 'WHC_AutoLayoutKit/LayoutView'
    ss.source_files = 'WHC_AutoLayoutKit/AutoCellHeight/*.{h,m}'
    ss.public_header_files = 'WHC_AutoLayoutKit/AutoCellHeight/*.h'
  end
  s.requires_arc = true


end
