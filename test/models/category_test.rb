require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  def setup 
    @category = Category.create(name:"Sports")
  end

  test "Category must have a name" do 
    @category = Category.new(name:"Tech")
    assert(@category.valid?)
  end
  
  test "Category must have a valid name" do 
    @category = Category.new(name:" ")
    assert_not(@category.valid?)
  end

  test "Category name must be unique" do 
    @category = Category.new(name:"Sports")
    assert_not(@category.valid?)
  end

  test "Category name length should not be more than 25" do 
    @category.name = "a"*26
    assert_not(@category.valid?)
  end

  test "Category name length should not be less than 3" do 
    @category.name = "a"
    assert_not(@category.valid?)
  end
  # test "the truth" do
  #   assert true
  # end
end
