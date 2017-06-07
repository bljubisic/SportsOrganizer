# Podfile
platform :ios, '10.3'
use_frameworks!

target 'SportsOrganizer' do
    pod 'Starscream'
    pod 'SnapKit'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'ProtocolBuffers-Swift'
end

target 'SportsOrganizerTests' do
    pod 'Starscream'
    pod 'SnapKit'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'ProtocolBuffers-Swift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
