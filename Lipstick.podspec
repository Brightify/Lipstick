Pod::Spec.new do |s|
  s.name             = "Lipstick"
  s.version          = "0.4.1"
  s.summary          = "Helpers for UIKit to make styling easier."
  s.description      = <<-DESC
                        Multiple methods and helpers that cache fonts and colors by their names and hex strings.
                       DESC

  s.homepage         = "https://github.com/SwiftKit/Lipstick"
  s.license          = 'MIT'
  s.author           = { "Tadeas Kriz" => "tadeas@brightify.org", "Filip Dolnik" => "filip@brightify.org" }
  s.source           = {
      :git => "https://github.com/SwiftKit/Lipstick.git",
      :tag => s.version.to_s
  }

  s.platform     = :ios, '8.0'
  s.source_files = 'Source/**/*.swift'
  s.frameworks = 'UIKit'
  s.requires_arc = true
end
