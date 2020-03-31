class QuestionsController < ApplicationController

  def data

    puts "in controller questions"
    puts params
    question = Question.find(params[:id])
    if question
      like_count = question.votes.where(vote_sign:1).count
      dislike_count = question.votes.where(vote_sign:2).count
      obj = question.as_json
      obj[:like_count] = like_count
      obj[:dislike_count] = dislike_count
      obj[:votable_id] = question[:id]

      vote = question.votes.where(user_id:params[:user_id])

      puts "vote"
      #puts vote.inspect

      if( vote.present? )
        obj[:current_vote_sign] = vote[0][:vote_sign]
        obj[:current_vote_id] = vote[0][:id]
      end

      render json: obj.to_json

      return
    end
    puts "question not found"

  end

  def index
    question = Question.all
    render json: question.to_json
  end

end
