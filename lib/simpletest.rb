require "simpletest/version"

Kernel.module_eval do
  def Simpletest(&block)
    Simpletest.new(&block)
  end
end

require "minitest/spec"

class Simpletest
  include Minitest::Assertions
  def assertions
    @assertions_counter
  end
  def assertions=(i)
    @assertions_counter = i
  end

  def initialize(&block)
    @assertions_counter = 0

    instance_exec(&block)
  end

  def test(what="", &block)
    block.call
  end
end
