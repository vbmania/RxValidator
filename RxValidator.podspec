Pod::Spec.new do |spec|
  spec.name             = 'RxValidator'
  spec.version          = '0.0.6'
  spec.summary          = 'Simple, Extensable, Flexable Validation Checker'
  spec.homepage         = 'https://github.com/vbmania/RxValidator'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'GeumSang Yoo' => 'vbmania@me.com' }
  spec.source           = { :git => 'https://github.com/vbmania/RxValidator.git', :tag => 'v' + spec.version.to_s }
  spec.source_files     = 'Sources/**/*.swift'
  spec.frameworks       = 'UIKit', 'Foundation'
  spec.requires_arc     = true
  spec.swift_version 	= '4.1'

  spec.dependency 'RxSwift', '>= 4.1.0'
  spec.dependency 'RxCocoa', '>= 4.1.0'


  spec.ios.deployment_target = '8.0'
  spec.watchos.deployment_target = '2.0'
  spec.tvos.deployment_target = '9.0'

end
