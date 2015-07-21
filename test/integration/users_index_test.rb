require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
  	@admin = users(:ania)
    @non_admin = users(:maciek)
  end

  test "index including pagination and delete links" do
  	log_in_as @admin
  	get users_path
  	assert_template 'users/index'
  	assert_select 'div.pagination'
    first_page_of_pagination = User.paginate(page: 1)
    first_page_of_pagination.each do |user|
  		assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
  	end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as @non_admin
    get user_path(@non_admin)
    assert_select 'a[href=?]', user_path(@non_admin), text: "delete", count: 0
  end
end
