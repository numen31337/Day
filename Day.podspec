Pod::Spec.new do |s|
  s.name         = "Day"
  s.version      = "1.1"
  s.summary      = "Mini lib to represent a Day"
  s.description  = "This is the mini library to represent a Day value with serialization functionality"
  s.homepage     = "https://github.com/numen31337/Day"
  s.license      = "MIT"
  s.author             = { "Alexander Kirsch" => "spam-reporter-3000@alexander-kirsch.com" }
  s.social_media_url   = "http://twitter.com/numen31337"
  s.platform      = :ios, "9.0"
  s.swift_version = "4.2"
  s.source        = { :git => "https://github.com/numen31337/Day.git", :tag => "#{s.version}" }
  s.source_files  = "Day/**/*.{h,m,swift}"
end
