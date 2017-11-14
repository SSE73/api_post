module Api
  module V1
    class PostsController < ::Api::V1::ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        # posts = Post.all.map {|post| {id: post.id, title: post.title, created_at: post.created_at}}
        # render json: posts.to_json

        posts = Post.all
        render json: posts, each_serializer: PostSerializer  # each_serializer - если используется коллекция объектов

      end

      def show
        render(json: @post,serializer: PostDetailSerializer)
      end

      def create
        post = Post.new(post_params)
        post.user = current_user
        if post.save
          render(json: post,serializer: PostDetailSerializer)
        else
          render json: post.errors.full_messages, status: 422
        end
      end

      def update
        if @post.update(post_params)
          render(json: @post,serializer: PostDetailSerializer)
        else
          render json: @post.errors.full_messages
        end
      end

      def destroy
        @post.destroy
        render(json: @post, serializer: PostDetailSerializer)
      end

      private

      def set_post
        @post = Post.find params[:id]
      end

      def post_params
        params.require(:post).permit(:title, :body)
      end

      def current_user
        User.first
      end
    end
  end
end
