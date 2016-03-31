Pod::Spec.new do |s|
  s.name             = "Lipstick"
  s.version          = "0.2.0"
  s.summary          = "UIKit styling library written in Swift."
  s.description      = <<-DESC
                        Forget writing styles in CSS and having huge load times for large applications.
                       DESC

  s.homepage         = "https://github.com/SwiftKit/Lipstick"
  s.license          = 'MIT'
  s.author           = { "Tadeas Kriz" => "tadeas@brightify.org" }
  s.source           = {
      :git => "https://github.com/SwiftKit/Lipstick.git",
      :tag => s.version.to_s
  }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*.swift'
  s.frameworks = 'UIKit'
  s.dependency 'SwiftKitStaging'
end
