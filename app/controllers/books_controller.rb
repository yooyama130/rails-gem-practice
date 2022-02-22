class BooksController < ApplicationController
  def index
    @tags = Book.tag_counts_on(:tags).most_used(20)
    # タグの一覧表示
    if params[:tag]
      @books = Book.tagged_with(params[:tag])
      # タグ検索時にそのタグ付けしているものを表示
    else
      @books = Book.all
    end
  end

  def new
      @book = Book.new
      @tags = ActsAsTaggableOn::Tag.all
  end

  def show
      @book = Book.find(params[:id])
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
        redirect_to books_path
      else
        @tags = ActsAsTaggableOn::Tag.all
        render :new
      end
  end

  # updateは省略

  def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
  end

  private

  def book_params
      #  tag_list: []　を追記 （acts-as-taggable-onのため）
      params.require(:book).permit(:title, :introduction, :tag_list)
  end

end