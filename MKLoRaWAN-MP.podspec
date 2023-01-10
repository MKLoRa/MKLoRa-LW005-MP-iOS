#
# Be sure to run `pod lib lint MKLoRaWAN-MP.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-MP'
  s.version          = '1.0.1'
  s.summary          = 'A short description of MKLoRaWAN-MP.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MKLoRa/MKLoRa-LW005-MP-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/MKLoRa/MKLoRa-LW005-MP-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  
  s.resource_bundles = {
    'MKLoRaWAN-MP' => ['MKLoRaWAN-MP/Assets/*.png']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-MP/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-MP/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-MP/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-MP/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-MP/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-MP/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'Cell' do |sss|
      sss.subspec 'TextButtonCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Expand/Cell/TextButtonCell/**'
        
        ssss.dependency 'MKBaseModuleLibrary'
        ssss.dependency 'MKCustomUIModule'
      end
    end
    
    ss.subspec 'Defines' do |sss|
      sss.source_files = 'MKLoRaWAN-MP/Classes/Expand/Defines/**'
    end
    
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/AboutPage/Controller/**'
      end
    end
  
    ss.subspec 'BleSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/BleSettingPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/BleSettingPage/Model'
        ssss.dependency 'MKLoRaWAN-MP/Functions/BleSettingPage/View'
      
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/BleSettingPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/BleSettingPage/View/**'
      end
    end
    
    ss.subspec 'CountDownSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/CountDownSettingsPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/CountDownSettingsPage/Model'
      
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/CountDownSettingsPage/Model/**'
      end
    
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/DeviceInfoPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/DeviceInfoPage/Model'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/UpdatePage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/DeviceInfoPage/Model/**'
      end
    
    end
    
    ss.subspec 'DeviceSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/DeviceSettingPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/DeviceSettingPage/Model'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/DeviceInfoPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/DeviceSettingPage/Model/**'
      end
    
    end
    
    ss.subspec 'ElectricitySettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/ElectricitySettingsPage/Controller/**'
      end
    end
    
    ss.subspec 'EnergySettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/EnergySettingsPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/EnergySettingsPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/EnergySettingsPage/Model/**'
      end
    
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/GeneralPage/Controller/**'
            
        ssss.dependency 'MKLoRaWAN-MP/Functions/SwitchSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/ElectricitySettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/EnergySettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/ProtectionSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoadStatusPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/CountDownSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/LEDSettingsPage/Controller'
      end
    end
    
    ss.subspec 'IndicatorColorPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/IndicatorColorPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/IndicatorColorPage/Model'
        ssss.dependency 'MKLoRaWAN-MP/Functions/IndicatorColorPage/View'
      
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/IndicatorColorPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/IndicatorColorPage/View/**'
      end
    end
    
    ss.subspec 'LEDSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LEDSettingsPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/LEDSettingsPage/Model'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/IndicatorColorPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LEDSettingsPage/Model/**'
      end
    
    end
    
    ss.subspec 'LoadStatusPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoadStatusPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoadStatusPage/Model'
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoadStatusPage/View'
      
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoadStatusPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoadStatusPage/View/**'
      end
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoRaApplicationPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoRaApplicationPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoRaApplicationPage/Model/**'
      end
    
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoRaPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoRaPage/Model'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoRaApplicationPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoRaSettingPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoRaPage/Model/**'
      end
    
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoRaSettingPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoRaSettingPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/LoRaSettingPage/Model/**'
      end
    
    end
    
    ss.subspec 'OverProtectionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/OverProtectionPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/OverProtectionPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/OverProtectionPage/Model/**'
      end
    
    end
    
    ss.subspec 'ProtectionSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/ProtectionSettingsPage/Controller/**'
            
        ssss.dependency 'MKLoRaWAN-MP/Functions/OverProtectionPage/Controller'
      end
    
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/ScanPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-MP/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-MP/Functions/TabBarPage/Controller'
      
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/ScanPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/ScanPage/View/**'
        
        ssss.dependency 'MKLoRaWAN-MP/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'SwitchSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/SwitchSettingsPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/SwitchSettingsPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/SwitchSettingsPage/Model/**'
      end
    
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/TabBarPage/Controller/**'
            
        ssss.dependency 'MKLoRaWAN-MP/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/BleSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-MP/Functions/DeviceSettingPage/Controller'
      end
    
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/UpdatePage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MP/Functions/UpdatePage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MP/Classes/Functions/UpdatePage/Model/**'
      end
    
      sss.dependency 'iOSDFULibrary'
    end
  
    ss.dependency 'MKLoRaWAN-MP/SDK'
    ss.dependency 'MKLoRaWAN-MP/CTMediator'
    ss.dependency 'MKLoRaWAN-MP/ConnectModule'
    ss.dependency 'MKLoRaWAN-MP/Expand'
  
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
  
  end
  
end
