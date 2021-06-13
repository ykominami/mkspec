module Mkspec
  module Misc
    require 'pp'

    def dump_var(name , value)
      pp "#{name.to_s}="
      pp value
    end
  end
end