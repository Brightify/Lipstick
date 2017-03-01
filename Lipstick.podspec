Pod::Spec.new do |spec|
    spec.name             = "Lipstick"
    spec.version          = "0.5.2"
    spec.summary          = "Helpers for UIKit to make styling easier."
    spec.description      = <<-DESC
                          Lipstick is small library which aim to improve usage of UIKit (UIColor, CGRect ...). Consists mostly from convenience inits , helper methods and so on. Main motivation behind this library is protocol `Stylable` which allows to easily apply styles to `UIView` (See Usage/Stylable).
                         DESC

    spec.homepage         = "https://github.com/brightify/Lipstick"
    spec.license          = 'MIT'
    spec.author           = { "Tadeas Kriz" => "tadeas@brightify.org", "Filip Dolnik" => "filip@brightify.org" }
    spec.source           = {
        :git => "https://github.com/brightify/Lipstick.git",
        :tag => spec.version.to_s
    }
    spec.social_media_url = 'https://twitter.com/BrightifyOrg'
    spec.requires_arc = true

    spec.platform = :ios, '8.0'

    spec.frameworks = 'UIKit'

    spec.source_files = 'Source/**/*.swift'
end
