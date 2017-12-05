require "test_helper"

class SimpletestTest < Minitest::Spec


  # Simpletest do
  #   test "Struct" do
  #     let(:struct) { Struct.new }

  #     test { assert_instance_of Struct, struct }
  #   end
  # end

  it do

    t = Simpletest do
      test "Struct accessors" do
        struct = Struct.new(:a).new

        test { assert_kind_of Struct, struct }

        test "calling writers mutates" do
          struct[:a] = 1

          assert_equal( {a: 1}, struct.to_h)
        end

        test "reader returns value" do
          assert_equal 2, struct[:a]
        end
      end
    end


  end

end


# 18 failures when only one thing in let didn't work
# i don't want to repeat the first #test in #before just to satisfy the framework. it's not DRY
