#
# Be sure to run `pod lib lint HHSimpleTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HHSimpleTool'
  s.version          = '1.3.1'
  s.summary          = 'A short description of HHSimpleTool.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hutaol/HHSimpleTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henry' => '1325049637@qq.com' }
  s.source           = { :git => 'https://github.com/hutaol/HHSimpleTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'HHSimpleTool/Classes/**/*'
  s.resources   = 'HHSimpleTool/Assets/*'

  # s.resource_bundles = {
  #   'HHSimpleTool' => ['HHSimpleTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'Toast', '~> 4.0.0'
  s.dependency 'SPAlertController', '~> 4.0.0'
  s.dependency 'MBProgressHUD', '~> 1.2.0'
  s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  s.dependency 'YBPopupMenu', '~> 1.1.9'
  s.dependency 'LSTPopView', '~> 0.3.10'
  
end
