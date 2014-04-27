Pod::Spec.new do |s|
  s.name         = "ABIntentions"
  s.version      = "1.0.0"
  s.summary      = "Collection of iOS intentions. Inspired by http://chris.eidhof.nl/posts/intentions.html"
  s.homepage     = "https://github.com/k06a/ABIntentions"
  s.license      = 'MIT'
  s.author       = { "Anton Bukov" => "k06aaa@gmail.com" }
  s.source       = { :git => "https://github.com/k06a/ABIntentions.git", :tag => '1.0.0' }
  s.platform     = :ios, '6.0'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end
