#
# Be sure to run `pod lib lint PMRangeSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PMRangeSlider'
  s.version          = '0.1.2'
  s.summary          = 'PMRangeSlider is a control allowing to set a range of numerical values using a double-thumbs slider.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
PMRangeSlider is a control allowing to set a range of numerical values using a double-thumbs slider.

It uses a delegate pattern to communicate value changes. 
                       DESC

  s.homepage         = 'https://github.com/owlcoding/PMRangeSlider'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pawel Maczewski' => 'pawel@owlcoding.com' }
  s.source           = { :git => 'https://github.com/owlcoding/PMRangeSlider.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pawelmaczewski'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PMRangeSlider/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'BlocksKit', '~> 2.2.5'
end
