require 'test_helper'

class TranslationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get translation_index_url
    assert_response :success
  end

end
