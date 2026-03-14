# frozen_string_literal: true

require 'securerandom'

require_relative 'cognitive_hologram/version'
require_relative 'cognitive_hologram/helpers/constants'
require_relative 'cognitive_hologram/helpers/holographic_fragment'
require_relative 'cognitive_hologram/helpers/hologram'
require_relative 'cognitive_hologram/helpers/hologram_engine'
require_relative 'cognitive_hologram/runners/cognitive_hologram'
require_relative 'cognitive_hologram/client'

module Legion
  module Extensions
    module CognitiveHologram
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
