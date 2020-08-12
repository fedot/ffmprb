# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ffmprb/version'

Gem::Specification.new do |spec|
  spec.name          = 'ffmprb'
  spec.version       = Ffmprb::VERSION
  spec.authors       = ["Costa Shapiro"]
  spec.email         = ['costa@mouldwarp.com']

  spec.summary       = "ffmprb is your audio/video manipulation pal, based on https://ffmpeg.org"
  spec.description   = "A video and audio composing DSL (Damn-Simple Language) and a micro-engine for ffmpeg and ffriends"
  spec.homepage      = Ffmprb::GEM_GITHUB_URL

  def self.ignore_match(pattern, path)
    path = '/' + path  unless path =~ %r'^/'
    if File.directory?(path)
      path += '/'  unless path =~ %r'/$'
    end
    if pattern.is_a?(Array)
      pattern
    else
      [pattern]
    end.any? do |pattern|
      pattern = '**/' + pattern  unless pattern =~ %r'^/'
      pattern += '**'  if pattern =~ %r'/$'
      File.fnmatch(pattern, path)
    end
  end

  pattern =
    if (ignore_pattern_lines = File.readlines('.gemignore') rescue nil)
      ignore_pattern_lines.map do |line|
        stripped = line.split(/(?<!\\)#/)[0].strip
        stripped  unless stripped.empty?
      end.compact
    else
      %w[test/ spec/ features/]
    end

  # NOTE dotfiles are ignored by .glob
  spec.files = Dir['**/*'].reject{|path| ignore_match pattern, path}
  # TODO:rm spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # NOTE I'm not happy with this dependency, and there's nothing crossplatform (= for windoze too) at the moment
  spec.add_dependency 'mkfifo', '~> 0.1.1'
  # NOTE make it into an optional dependency? Nah for now
  spec.add_dependency 'thor', '~> 0.19.1'

  spec.post_install_message = "Have fun with your a/v! To enable proc visualisation, install firebase gem and set FFMPRB_PROC_VIS_FIREBASE env."  unless
    Ffmprb::FIREBASE_AVAILABLE
end
