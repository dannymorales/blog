class PostsController < ApplicationController
	before_action :authenticate, except: [:index, :show]

	def index
		@posts = Post.all.order('created_at DESC')
	end

	def new
		@post = current_user.posts.build
	end

	def create
		
		@post = current_user.posts.build(post_params)
		respond_to do |format|
			if @post.save
				format.html {redirect_to @post, notice: 'post was created'}
				format.json {render :show, status: :created, location: @post}
			else
				format.html {render :new}
				format.json {render json: @post.errors, status: :unprocessable_entity}
			end
		end
	end

	def show
		@post = Post.find(params[:id])
		@post.user
	end

	def edit
		@post = Post.find(params[:id])
		@post.user
	end	
	def update
		@post = Post.find(params[:id])
		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post
		else
			render 'edit'
		end
	end
	def authenticate
		authenticate_user! && current_user.admin?
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to root_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end
end
