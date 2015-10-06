Pod::Spec.new do |s|
    s.name         = "NotificationKit"
    s.version      = "0.1.0"
    s.summary      = "A simple type-safe NSNotificationCenter library."
    s.license      = { :type => 'MIT', :file => './LICENSE' }
    s.homepage     = "https://github.com/tarunon/NotificationKit"
    s.source       = { :git => 'https://github.com/tarunon/NotificationKit.git', :branch => 'master'}
    s.author       = { "tarunon" => "croissant9603[at]gmail.com" }
    s.source_files = 'NotificationKit/*.{swift,h}'
    s.platform     = :ios, '8.0'
    s.requires_arc = true
end