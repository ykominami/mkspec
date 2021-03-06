module Erubyx
  class TestGroup
    attr_reader :name, :test_cases, :size, :make_arg

    def initialize(name, make_arg, extra = nil)
      @name = name
      @test_cases = []
      @size = 0
      @make_arg = make_arg
      @extra = extra
    end

    def to_s
      @name
    end

    def add_test_case(tg_name, dir, test_1, test_2, extra = nil)
      @test_cases << TestCase.new(self, tg_name, dir, test_1, test_2, extra)
      @size += 1
    end

    def print
      puts '# TestGroup'
      puts @name
      @test_cases.map(&:print)
    end
  end
end
