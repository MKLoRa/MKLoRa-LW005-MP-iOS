#
# Be sure to run `pod lib lint MKLoRaWAN-MP.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-MP'
  s.version          = '1.0.0'
  s.summary          = 'A short description of MKLoRaWAN-MP.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aadyx2007@163.com/MKLoRaWAN-MP'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/aadyx2007@163.com/MKLoRaWAN-MP.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'MKLoRaWAN-MP/Classes/**/*'
  
  s.resource_bundles = {
    'MKLoRaWAN-MP' => ['MKLoRaWAN-MP/Assets/*.png']
  }

  s.dependency 'MKBaseModuleLibrary'
  s.dependency 'MKCustomUIModule'
  s.dependency 'MKBaseBleModule'
  
  s.dependency 'HHTransition'
  s.dependency 'MLInputDodger'
  s.dependency 'iOSDFULibrary'
  s.dependency 'CTMediator'
  
end
