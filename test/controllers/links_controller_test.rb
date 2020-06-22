require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    assert_difference 'Link.count' => 1 do
      post links_path, params: {
        link: { url: 'https://example.com' },
        expire_after: 5
      }
      assert_response :success
    end
  end
end
