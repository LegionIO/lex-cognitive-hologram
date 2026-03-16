# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_hologram/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-hologram'
  spec.version       = Legion::Extensions::CognitiveHologram::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Cognitive Hologram'
  spec.description   = 'Holographic memory model for the LegionIO cognitive architecture — ' \
                       'each fragment contains information about the whole, enabling partial ' \
                       'recall, interference pattern detection, and reconstruction from fragments'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-hologram'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-cognitive-hologram'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-cognitive-hologram'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-cognitive-hologram'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-cognitive-hologram/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{\A(?:test|spec|features)/})
  end
  spec.require_paths = ['lib']
  spec.add_development_dependency 'legion-gaia'
end
