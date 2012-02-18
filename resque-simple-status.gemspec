# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resque-simple-status/version"

Gem::Specification.new do |s|
  s.name        = "resque-simple-status"
  s.version     = Resque::Simple::Status::VERSION
  s.authors     = ["Ken Robertson"]
  s.email       = ["ken@invalidlogic.com"]
  s.homepage    = "http://github.com/krobertson/resque-simple-status"
  s.summary     = %q{Resque plugin to allow a simple method for jobs to report a status that is displayed through the Resque server.}
  s.description = %q{This plugin is intended as a very simplistic way for a job to report a status and simple progress report. One of the intent compared to other similar plugins was to enable it to be used when the code for the job wasn't present to the Resque server web app.}

  s.rubyforge_project = "resque-simple-status"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "resque"
  s.add_runtime_dependency "resque-access_worker_from_job"
end
