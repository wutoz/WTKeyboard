Pod::Spec.new do |s|
  s.name         = "WTKeyboard"
  s.version      = "0.1.0"
  s.summary      = "GUOTAIJUNAN YDPT Lib"
  s.description  = "GJYD components...GUOTAIJUNAN YDPT Lib"
  s.homepage     = "http://www.wutongr.com"
  s.license      = 'MIT'
  s.author       = { "wutongr" => "zc_and_zc@aliyun.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/wutongr/WTKeyboard.git", :tag => "v0.1.0" }
  s.requires_arc = true
  s.source_files = 'WTKeyboard/WTKeyboard/{WTKeyboard}*.{h,m}'
  s.resources    = 'WTKeyboard/WTKeyboard/Resources/*.png'
  s.frameworks   = 'QuartzCore'

end