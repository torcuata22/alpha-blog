require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
    @user = users(:one) 
    login_user(@user)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    login_user(@user)
    assert_difference("Article.count") do
      post articles_url, params: { article: { description: @article.description, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    login_user(@user)
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    login_user(@user)
    patch article_url(@article), params: { article: { description: @article.description, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    login_user(@user)
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  private

def login_user(user)
  post login_path, params: { session: { email: user.email, password: 'password' } }
end


end
