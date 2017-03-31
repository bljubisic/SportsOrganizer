# Podfile
use_frameworks!

target 'SportsOrganizer' do
    pod 'Starscream', '~> 2.0.3'
    pod 'SnapKit'
end

target 'SportsOrganizerTests' do
    pod 'Starscream', '~> 2.0.3'
    pod 'SnapKit'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end