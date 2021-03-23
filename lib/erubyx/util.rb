# frozen_string_literal: true

module Erubyx
  class Util
    class << self
      def make_spec_filename(name)
        %(#{name}_spec.rb)
      end
    end
  end
end