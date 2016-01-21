Pod::Spec.new do |spec|
  spec.name = "StringFilter"
  spec.version = "0.0.1"
  spec.summary = "A swifty text converter."
  spec.homepage = "https://github.com/tnantoka/StringFilter"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { 'tnantoka' => 'tnantoka@bornneet.com' }
  spec.social_media_url = "https://twitter.com/tnantoka"

  spec.platform = :ios, '9.1'
  spec.requires_arc = true
  spec.source = { git: 'https://github.com/tnantoka/StringFilter.git', tag: spec.version, submodules: true }
  spec.source_files = 'StringFilter/**/*.{h,swift}'
end

