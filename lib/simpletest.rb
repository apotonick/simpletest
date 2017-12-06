require "simpletest/version"

Kernel.module_eval do
  def Simpletest(&block)
    Simpletest.new(&block)
  end
end

require "minitest/spec"

class Simpletest
  # Instance where the assertions for one Simpletest "class" are run.
  class Test
    include Minitest::Assertions
    def assertions
      @assertions_counter
    end
    def assertions=(i)
      @assertions_counter = i
    end
  end

  def initialize(&block)
    @assertions_counter = 0
  end

  class Group
    def initialize(description, block)
      @description, @block = description, block
      @childs = []
    end

    def test(description="implement me!", &block) # DSL
      @childs += [Group.new(description, block)]
    end

    def run_childs
      @childs.collect { |group| group.() }
    end

    def call
      instance_exec(&@block) # todo: call
      results = run_childs

      [@assertions, *results]
    end

    # FIXME: where does the assertion backend come from?
    def assert_equal(*)
      @assertions ||=[]
      @assertions << @description
    end
  end

  def self.test(description, &block)
    results = Group.new(description, block).()
    pp results
  end
end
