class Site::CategoriesController < Site::BaseController
  def index
    @categories = @user.categories.desc(:updated_at)
  end

  def show
    @category = @user.categories.find_by :urlname => params[:id]
    @articles = @category.articles.publish.desc(:created_at).page(params[:page]).per(10)
  end

  def feed
    @category = @user.categories.find_by :urlname => params[:id]
    @articles = @category.articles.publish.desc(:created_at).limit(20)
    @feed_title = "#{@category.name} - #{@user.profile.name.present? ? @user.profile.name : @user.name}"
    @feed_link = site_category_url(@category)

    respond_to do |format|
      format.rss { render 'site/articles/feed' }
    end
  end
end