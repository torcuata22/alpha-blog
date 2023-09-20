require 'test_helper'

class CategoryTest<ActiveSupport::TestCase
  test "categroy should be valid" do
    @category = Category.new(name: "Sports")
  end
end