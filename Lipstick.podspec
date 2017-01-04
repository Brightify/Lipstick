Pod::Spec.new do |s|
  s.name             = "Lipstick"
  s.version          = "0.5.0"
  s.summary          = "Helpers for UIKit to make styling easier."
  s.description      = <<-DESC
                        Lipstick is small library which aim to improve usage of UIKit (UIColor, CGRect ...). Consists mostly from convenience inits , helper methods and so on. Main motivation behind this library is protocol `Stylable` which allows to easily apply styles to `UIView` (See Usage/Stylable).
                       DESC

  s.homepage         = "https://github.com/brightify/Lipstick"
  s.license          = 'MIT'
  s.author           = { "Tadeas Kriz" => "tadeas@brightify.org", "Filip Dolnik" => "filip@brightify.org" }
  s.source           = {
      :git => "https://github.com/brightify/Lipstick.git",
      :tag => s.version.to_s
  }

  s.platform     = :ios, '8.0'
  s.source_files = 'Source/**/*.swift'
  s.frameworks = 'UIKit'
  s.requires_arc = true
end
