 Pod::Spec.new do |s|
    
    # meta infos
    s.name             = "SwiftyToolz"
    s.version          = "1.6.0"
    s.summary          = "Swift Code by Flowtoolz"
    s.description      = "Swift Code by Flowtoolz. Visit https://github.com/flowtoolz for more."
    s.homepage         = "http://flowtoolz.com"
    s.license          = 'MIT'
    s.author           = { "Flowtoolz" => "contact@flowtoolz.com" }
    s.source           = {  :git => "https://github.com/flowtoolz/SwiftyToolz.git",
                            :tag => s.version.to_s }
    
    # compiler requirements
    s.requires_arc = true
    s.swift_version = '5.1'
    
    # minimum platform SDKs
    s.platforms = {:ios => "9.0", :osx => "10.12", :tvos => "9.0"}

    # minimum deployment targets
    s.ios.deployment_target  = '9.0'
    s.osx.deployment_target = '10.12'
    s.tvos.deployment_target = '9.0'

    # sorces
    s.source_files = 'Code/**/*.swift'
end
