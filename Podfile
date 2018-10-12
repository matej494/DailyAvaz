# Uncomment the next line to define a global platform for your project
  platform :ios, '9.0'

def shared_pods

    pod 'SnapKit', '~> 4.0.0'
    pod 'SwiftLint'
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
    pod 'Alamofire', '~> 4.7'
    pod 'Kingfisher', '~> 4.0'

end

target 'DailyAvaz' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!

    # Pods for DailyAvaz
    shared_pods

end

target 'DailyAvazTests' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    shared_pods
    # Pods for testing
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
    pod 'Cuckoo'
    pod 'Quick'
    pod 'Nimble'
end