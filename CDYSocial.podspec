Pod::Spec.new do |spec|
  spec.name         = 'CDYSocial'
  spec.version      = '0.1.0'
  spec.summary      = "Utility classes for sharing to social networks."
  spec.homepage     = "https://github.com/coodly/CDYSocial"
  spec.author       = { "Jaanus Siim" => "jaanus@coodly.com" }
  spec.source       = { :git => "https://github.com/coodly/CDYSocial.git", :tag => "v#{spec.version}" }
  spec.license      = { :type => 'Apache 2', :file => 'LICENSE.txt' }
  spec.requires_arc = true

  spec.subspec 'Core' do |ss|
    ss.platform = :ios, '7.0'
    ss.source_files = 'Core/*.{h,m}'
  end
end
