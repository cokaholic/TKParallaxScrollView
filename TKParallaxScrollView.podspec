#
# Be sure to run `pod lib lint TKParallaxScrollView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TKParallaxScrollView"
  s.version          = "1.0.0"
  s.summary          = "TKParallaxScrollView is the interactive moving library for header and middle views on scrollview."

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/TKParallaxScrollView"
  s.license          = 'MIT'
  s.author           = { "cztatsumi-keisuke" => "tatsumi-keisuke@cyber-z.co.jp" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/TKParallaxScrollView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/TK_u_nya'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.{h,m}'
  #s.resource_bundles = {
  #  'TKParallaxScrollView' => ['Pod/Assets/*.png']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
