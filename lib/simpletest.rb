require "simpletest/version"

Kernel.module_eval do
  def Simpletest(&block)
    Simpletest.new(&block)
  end
end

require "minitest/spec"

class Simpletest
  # Instance where the assertions for one Simpletest "class" are run.
  module AssertionAdapter
    class Minitest
      include ::Minitest::Assertions

      attr_accessor :assertions # counter for invoked assertions.

      def initialize
        @assertions = 0
      end
    end
  end

  def initialize(&block)
    @assertions_counter = 0
  end

  class Group
    def initialize(description, block)
      @description, @block = description, block
      @childs = []
      @locals = {}
    end

    def test(description="implement me!", &block) # DSL
      @childs += [Group.new(description, block)]
    end

    def let(name, value) # TODO: implement block. make value optional.
      @locals[name] = value
    end

    def run_childs
      @childs.collect { |group| group.( @locals ) }
    end

    def call(*args)
      instance_exec(*args, &@block) # todo: call
      results = run_childs

      [@assertions, *results]
    end

    # FIXME: where does the assertion backend come from?
    def assert_equal(*args, &block)
      adapter = AssertionAdapter::Minitest.new
      adapter.assert_equal(*args, &block) # FIXME: this sucks: Minitest catches the Assertion exception here, instead of properly passing it up the chain.

      pp adapter
      # instead, there should be an API in Minitest so we can pass it results (failures and passes?) and it "does the rest" .
      @assertions ||=[]
      @assertions << @description
    end
  end

  def self.test(description, &block)
    results = Group.new(description, block).()
    pp results
  end
end
