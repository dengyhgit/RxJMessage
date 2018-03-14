Pod::Spec.new do |s|

  s.name             = "RxJMessage"
  s.version          = "0.0.1"
  s.summary          = "An Rx wrapper of JMessage"

  s.description      = <<-DESC
    This is an Rx extension that provides an easy and straight-forward way
    to use JMessage's natively reactive function as an Observable
                       DESC

  s.homepage         = "https://github.com/dengyhgit/RxJMessage"
  s.license          = 'MIT'
  s.author           = { "DengYonghao" => "cbyniypeu@163.com" }
  s.source           = { :git => "https://github.com/dengyhgit/RxJMessage.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/*.swift'

  s.frameworks = 'Foundation'
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'JMessage', '~> 3.5.0'

end
