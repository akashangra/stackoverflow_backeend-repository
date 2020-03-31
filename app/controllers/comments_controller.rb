class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts "in comment create"
    comment = Comment.new(comment_params)
    if comment.save
      puts "comment created"
      return
    end

    puts "comment not created"
  end

  def comments_from_question
    puts "comments_from_question"
    question = Question.find(params[:commentable_id])
    if( question )
      puts "question find"
      comments = question.comments
      puts " comments length #{comments.length}"
      puts comments.to_json
      render json: question.comments.to_json
      return
    end
    puts params
  end

  def comment_params
    params.require(:comment).permit(:user_id,:description,:commentable_type,:commentable_id)
  end
end
