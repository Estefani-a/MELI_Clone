Pod::Spec.new do |s|
  s.name             = 'AppIosW6CodePatroll'
  s.version          = '0.1.0'
  s.summary          = 'AppIosW6CodePatroll library for ios app.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/mercadolibre/fury_app-ios-w6-code-patroll'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ext_feteruel' => 'ext_feteruel@mercadolibre.com' }
  s.source           = { :git => 'git@github.com:mercadolibre/fury_app-ios-w6-code-patroll.git', :tag => s.version.to_s }
  s.static_framework = true
  s.platform         = :ios, '13.0'

  s.source_files = 'LibraryComponents/Classes/**/*.{h,m,swift}'

  # s.resource_bundles = {
  #   'AppIosW6CodePatrollResources' => ['AppIosW6CodePatroll/Assets/*.png']
  # }
  
  s.dependency 'MLCommons', '~> 1.23'

  

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
