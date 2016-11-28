Pod::Spec.new do |s|

  s.name         = "WHC_AutoLayoutKit"
  s.version      = "2.6.3"
  s.summary      = "Had better use the auto layout of open source framework，致力打造使用最简单功能最强大的自动布局开源库，支持Cell和Tableview高度自适应，UILabel,ScrollView,UIView内容自适应."

  s.homepage     = "https://github.com/netyouli/WHC_AutoLayoutKit"

  s.license      = "MIT"

  s.author             = { "吴海超(WHC)" => "712641411@qq.com" }

  s.platform     = :ios
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/netyouli/WHC_AutoLayoutKit.git", :tag => "2.6.3"}

  s.source_files  = "WHC_AutoLayoutKit(OC)/*.{h,m}"

  # s.public_header_files = "Classes/**/*.h"


  s.requires_arc = true


end
