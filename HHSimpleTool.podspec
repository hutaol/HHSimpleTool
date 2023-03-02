#
# Be sure to run `pod lib lint HHSimpleTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HHSimpleTool'
  s.version          = '1.5.0'
  s.summary          = '简单的工具类'

  s.description      = <<-DESC
  简单的工具类
                       DESC

  s.homepage         = 'https://github.com/hutaol/HHSimpleTool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henry' => '1325049637@qq.com' }
  s.source           = { :git => 'https://github.com/hutaol/HHSimpleTool.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  
  s.default_subspec = 'Default'
  
  s.subspec 'Default' do |de|
    de.resources    = 'HHSimpleTool/Assets/*'
    de.source_files = 'HHSimpleTool/Classes/*.{h,m}', 'HHSimpleTool/Classes/Alert/*.{h,m}', 'HHSimpleTool/Classes/Toast/*.{h,m}', 'HHSimpleTool/Classes/Vender/*.{h,m}'
  end
  
  s.subspec 'Country' do |c|
    c.resources     = 'HHSimpleTool/Country/*.json'
    c.source_files  = 'HHSimpleTool/Country/*.{h,m}'
  end
  
  # 分类切换滚动视图
  s.subspec 'Category' do |p|
    p.dependency 'JXCategoryView', '~> 1.6.1'
  end
  
  # 多页面嵌套，悬浮
  s.subspec 'Pager' do |p|
    p.dependency 'JXCategoryView', '~> 1.6.1'
    p.dependency 'JXPagingView/Pager', '~> 2.1.2'
  end
  
  

  # s.resource_bundles = {
  #   'HHSimpleTool' => ['HHSimpleTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  
  s.dependency 'SPAlertController', '~> 4.0.0'
  s.dependency 'MBProgressHUD', '~> 1.2.0'
  s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  s.dependency 'YBPopupMenu', '~> 1.1.9'
  s.dependency 'LSTPopView', '~> 0.3.10'
  
end
