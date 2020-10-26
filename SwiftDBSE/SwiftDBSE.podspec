Pod::Spec.new do |s|

  s.name         = "SwiftDBSE"
  s.version      = "1.0.0"
  s.summary      = "D.B Steinman estimation of (n) term polynomial."
  s.description  = "D.B Steinman estimation of (n) term polynomial..."
  s.homepage     = "https://github.com/NathanBarta/SwiftDBSE"
  s.license      = "GNU v3.0"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author    = "NathanBarta"
  s.platform     = :ios, "12.0"
#  s.ios.deployment_target = "12.0"
#  s.osx.deployment_target = "10.15"
#  s.watchos.deployment_target = "2.0"
#  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/NathanBarta/SwiftDBSE.git", :tag => "1.0.0" }
  s.source_files  = "SwiftDBSE/**/*.{h,m}"

end
