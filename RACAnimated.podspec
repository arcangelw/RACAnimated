#
# Be sure to run `pod lib lint RACAnimated.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RACAnimated'
  s.version          = '0.2.0'
  s.summary          = 'Animated bindings for ReactiveCocoa'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  从RxSwiftCommunity中同步相关库到ReactiveSwift/ReactiveCocoa，RACAnimated同步RxAnimated
                       DESC

  s.homepage         = 'https://github.com/arcangelw/RACAnimated'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'arcangelw' => 'wuzhezmc@gmail.com' }
  s.source           = { :git => 'https://github.com/arcangelw/RACAnimated.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '10.0'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |cs|
      s.source_files = 'RACAnimated/Classes/**/*'
  end
  # s.resource_bundles = {
  #   'RACAnimated' => ['RACAnimated/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'ReactiveCocoa', '~> 10.0.0'
  s.swift_version = "5.2"
end
