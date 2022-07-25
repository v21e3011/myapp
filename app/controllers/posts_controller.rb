class PostsController < ApplicationController
    def index
        @posts = Post.all.order(created_at: 'desc')
    end
    
    def show
        @post = Post.find(params[:id])
    end
    def create
        #    render plain: "受信パラメータ：#{params}"
        @post = Post.new(post_params.merge({user_id: session[:user_id]}))
        authorize @post
        if @post.save
            redirect_to posts_path
        else
            render "new"
        end
    end
    
    def new
        @post = Post.new
        authorize @post
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to posts_path
        else
            render "edit"
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
    
private
    def post_params
        params.require(:post).permit(:title, :body)
    end

end
