#
# Be sure to run `pod lib lint PPCThirdPartOperation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PPCThirdPartOperation'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PPCThirdPartOperation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rainyboyer/PPCThirdPartOperation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pen' => 'pengjunhua2005@21cn.com' }
  s.source           = { :git => 'https://github.com/rainyboyer/PPCThirdPartOperation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PPCThirdPartOperation/Classes/**/*.{h,m}'
  
  #s.resource_bundles = {
  #  'PPCThirdPartOperation' => ['PPCThirdPartOperation/Assets/*.png']
  #}

  s.public_header_files = 'PPCThirdPartOperation/Classes/**/*.h'
  s.frameworks = "Foundation","UIKit","MapKit","QuartzCore","CoreText","ImageIO","Security","CoreTelephony","CoreGraphics","SystemConfiguration"
  s.libraries = "iconv", "z","stdc++","sqlite3"

  #s.vendored_libraries = 'PPCThirdPartOperation/Classes/framework/**/*.a'
  s.resources = "PPCThirdPartOperation/Classes/framework/tencent/TencentOpenApi_IOS_Bundle.bundle"
  s.ios.vendored_frameworks = "PPCThirdPartOperation/Classes/framework/tencent/TencentOpenAPI.framework"
  s.public_header_files = "PPCThirdPartOperation/Classes/framework/tencent/TencentOpenAPI.framework/Headers/**/*.h","PPCThirdPartOperation/Classes/**/*.h"

  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'SVProgressHUD', '~> 2.0.3'
  #s.dependency 'TencentOpenApiSDK', '~> 2.9.5'
  
end
