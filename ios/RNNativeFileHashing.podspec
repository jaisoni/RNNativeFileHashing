
Pod::Spec.new do |s|
  s.name         = "RNNativeFileHashing"
  s.version      = "1.0.0"
  s.summary      = "RNNativeFileHashing"
  s.description  = <<-DESC
                  RNNativeFileHashing
                   DESC
  s.homepage     = "https://github.com/jaisoni"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/jaisoni/RNNativeFileHashing.git", :tag => "master" }
  s.source_files  = "RNNativeFileHashing/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React native module for generating hmacsha256 of file"
  #s.dependency "others"

end

  