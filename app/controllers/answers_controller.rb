class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts "in answer create"
    answer = Answer.new(answer_params)
    if answer.save
      puts "answer created"
      return
    end

    puts "answer not created"
  end

  def answer_params
    params.require(:answer).permit(:user_id,:question_id,:description)
  end

  def answers_from_question
    puts "answers_from_question"
    question = Question.find(params[:question_id])
    if( question )
      puts "question find"
      answers = question.answers
      puts " answer length #{answers.length}"
      puts answers.to_json
      render json: question.answers.to_json
      return
    end
    puts params
  end

end
