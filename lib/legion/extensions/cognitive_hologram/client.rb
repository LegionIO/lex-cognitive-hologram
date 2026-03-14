# frozen_string_literal: true

module Legion
  module Extensions
    module CognitiveHologram
      class Client
        include Runners::CognitiveHologram

        def initialize(engine: nil, **)
          @default_engine = engine || Helpers::HologramEngine.new
        end

        private

        attr_reader :default_engine
      end
    end
  end
end
