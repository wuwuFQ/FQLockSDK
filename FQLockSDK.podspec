#
#  Be sure to run `pod spec lint FQLockSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "FQLockSDK"
  spec.version      = "1.0.1"
  spec.summary      = "手势密码解锁，面容ID解锁，指纹解锁"
  spec.description  = <<-DESC
  FQLockSDK: iOS手势密码解锁，iOS面容ID解锁，iOS指纹解锁，已适配解锁逻辑
                   DESC

  spec.homepage     = "https://github.com/wuwuFQ/FQLockSDK"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "wuwuFQ" => "13301325631@163.com" }
  spec.platform     = :ios, '11.0'   #使用平台

  spec.source       = { :git => "https://github.com/wuwuFQ/FQLockSDK.git", :tag => "#{spec.version}" }

  spec.vendored_frameworks = "FQLockSDK.framework"
  spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }



end
