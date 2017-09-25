# Podfile
platform :ios, '11.0'
use_frameworks!

target 'SportsOrganizer' do
    pod 'Starscream'
    pod 'SnapKit', :git => 'https://github.com/SnapKit/SnapKit.git', :branch => 'swift-4'
    pod 'RxSwift',  :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'swift4.0'
    pod 'RxCocoa',  :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'swift4.0'
    pod 'SwiftProtobuf'
end

target 'SportsOrganizerTests' do
    pod 'Starscream'
    pod 'SnapKit', :git => 'https://github.com/SnapKit/SnapKit.git', :branch => 'swift-4'
    pod 'RxSwift',  :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'swift4.0'
    pod 'RxCocoa',  :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'swift4.0'
    pod 'SwiftProtobuf'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
