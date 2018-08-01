class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @center_id = params[:center_id]


    if @center_id.present?
      @comments = Comment.where(center_id: @center_id)
    else  
      @comments = Comment.all
      @center_id = 1
    end  
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @center_id = params[:center_id]
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
    @center_id = params[:center_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    respond_with(@comment)
  end

  def update
    @center_id = params[:center_id]
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @center_id = params[:center_id]
    @comments = Comment.where(center_id: @center_id)
    @comment.destroy
    render 'index'
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:center_id, :coment)
    end
end
