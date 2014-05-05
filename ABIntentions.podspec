Pod::Spec.new do |s|
  s.name         = "ABIntentions"
  s.version      = "1.0.0"
  s.summary      = "Collection of iOS intentions. Inspired by http://chris.eidhof.nl/posts/intentions.html"
  s.homepage     = "https://github.com/k06a/ABIntentions"
  s.license      = 'MIT'
  s.author       = { "Anton Bukov" => "k06aaa@gmail.com" }
  s.source       = { :git => "https://github.com/k06a/ABIntentions.git", :tag => '1.0.0' }
  s.platform     = :ios, '6.0'
  s.source_files = 'ABIntentions/*.{h,m}'
  s.requires_arc = true
  
  s.subspec 'View' do |core|
    core.source_files = 'ABIntentions/View/*.{m,h}'
  end
  s.subspec 'Button' do |core|
    core.source_files = 'ABIntentions/Button/*.{m,h}'
  end
  s.subspec 'TextField' do |core|
    core.source_files = 'ABIntentions/TextField/*.{m,h}'
  end
  s.subspec 'TableView' do |cells|
      cells.source_files = 'ABIntentions/TableView/*.{m,h}'
  end
  s.subspec 'WebView' do |cells|
      cells.source_files = 'ABIntentions/WebView/*.{m,h}'
  end
  s.subspec 'MapView' do |cells|
      cells.source_files = 'ABIntentions/MapView/*.{m,h}'
  end
end
