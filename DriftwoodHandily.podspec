Pod::Spec.new do |s|
  s.name                    = 'DriftwoodHandily'
  s.version                 = '5.1.5'
  s.summary                 = 'Shortcutting for Driftwood.'
  s.homepage                = 'https://github.com/wlgemini/DriftwoodHandily'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'wlgemini' => 'wangluguang@live.com' }
  s.source                  = { :git => 'https://github.com/wlgemini/DriftwoodHandily.git', :tag => s.version.to_s }
  
  s.swift_version           = '5.1'

  s.ios.deployment_target   = '8.0'
  s.osx.deployment_target   = '10.11'
  s.tvos.deployment_target  = '9.0'
  
  s.source_files            = 'DriftwoodHandily/*.swift'
end
