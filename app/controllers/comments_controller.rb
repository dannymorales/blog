class CommentsController < ApplicationController
	before_filter :require_permission, only: :edit

	def new
		@comments = current_user.comments.build
	end
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
	end

	def show
		@comment = Comment.find(params[:id])
		@comment.user = current_user
	end
	def edit
		@comment = Comment.find(params[:id])
		@comment.user
	end

	def update
		@comment = Comment.find(params[:id])
		@comment.update	
	end
	def require_permission
		if current_user != Comment.find(params[:id]).user
		redirect_to root_path
		end	
	end

	private
    def comment_params
      params.require(:comment).permit(:body).merge(:user_id => current_user.id)
    end 
end