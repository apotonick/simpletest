require "test_helper"

class SimpletestTest < Minitest::Spec


  # Simpletest do
  #   test "Struct" do
  #     let(:struct) { Struct.new }

  #     test { assert_instance_of Struct, struct }
  #   end
  # end

  it do
    Simpletest.test "bla" do #|*|
      struct = Struct.new(:a).new
      # assert_equal 11

      test { |struct| assert_equal Struct, struct }

      test "calling writers mutates" do #|struct|
        struct[:a] = 1

        assert_equal( {a: 1},  struct.to_h)
        assert_equal( [[:a,1]], struct.to_a)
      end

      test "reader returns value" do |struct|
        assert_equal 2#, struct[:a]
      end
    end
  end

  # it do

  #   t = Simpletest do
  #     test "Struct accessors" do
  #       struct = Struct.new(:a).new
  #       # let(:struct) { Struct.new(:a).new }

  #       test { |struct| assert_kind_of Struct, struct }

  #       test "calling writers mutates" do |struct|
  #         struct[:a] = 1

  #         assert_equal( {a: 1}, struct.to_h)
  #       end

  #       test "reader returns value" do |struct|
  #         assert_equal 2, struct[:a]
  #       end
  #     end
  #   end

  #   assert false


  # end

end


# 18 failures when only one thing in let didn't work
# i want the order of the tests, because it's a scenario or story to tell - and massively helps when designing APIs. also, reading.
# i don't want to repeat the first #test setup (eg `struct = Struct.new(:a).new`) in #before just to satisfy the framework. it's not DRY
# the more indentations, the harder to read


=begin
 the idea in Minitest is that each it block is a method `MyTest#test_01`
 this is then run in Minitest#run_one_method with the following invocation
   result = MyTest.new(:test_01).run
  where only that one test method is run. why not a callable object per test case? this would also allow better access control of what to pass in.
 the result is then
  #<SimpletestTest:0x0000000179d988
   @NAME="test_0001_anonymous",
   @assertions=1,
   @failures=[#<Minitest::Assertion: Expected false to be truthy.>],
   @time=3.4210970625281334e-05>


=end
