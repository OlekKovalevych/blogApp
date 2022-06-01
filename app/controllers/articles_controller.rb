# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[create new updta edit destroy]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :set_user

  # GET /articles or /articles.json
  def index
    @articles = Article.where(user_id: params[:user_id])
  end

  # GET /articles/1 or /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new(user_id: @user.id)
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.jsonS
  def create
    @article = ArticleService.new(article: Article.new(create_article_params)).call
    respond_to do |format|
      if @article.save
        format.html { redirect_to user_articles_url(@user), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to user_articles_url(@user), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to user_articles_url(@user), notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def create_article_params
    article_params.merge(user_id: @user.id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
