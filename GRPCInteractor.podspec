Pod::Spec.new do |s|

    s.name = 'GRPCInteractor'
    s.module_name = 'GRPCInteractor'
    s.version = '1.0.0'
    s.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    s.summary = 'pod to consume GRPC from KMM'
    s.homepage = 'https://github.com/daniellfalcao/grpc-interactor-pod'
    s.authors  = { 'The GRPCInteractor contributors' => '' }

    s.swift_version = '5.2'
    s.ios.deployment_target = '15.0'
    s.source = { :git => "https://github.com/daniellfalcao/grpc-interactor-pod.git", :tag => s.version }

    s.source_files = 'GRPCInteractor/*.{swift,c,h}'

end