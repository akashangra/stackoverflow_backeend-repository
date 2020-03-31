class VotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts "in votes create"
    vote = Vote.new(vote_params)
    if vote.save

      @vote = {}
      @vote["like_count"] = vote.votable.votes.where(vote_sign:1).count
      @vote["dislike_count"] = vote.votable.votes.where(vote_sign:2).count
      @vote["current_vote_sign"] = vote[:vote_sign];
      @vote["current_vote_id"] = vote[:id];

      puts "vote created"
      render json: @vote.to_json

      return
    end





    puts "vote not created"
  end

  def update
    puts "in votes update"

    vote = Vote.find(params[:id])
    if( vote && vote.update_attributes( vote_params ) )
      @vote = {}
      @vote["like_count"] = vote.votable.votes.where(vote_sign:1).count
      @vote["dislike_count"] = vote.votable.votes.where(vote_sign:2).count
      @vote["current_vote_sign"] = vote[:vote_sign];
      @vote["current_vote_id"] = vote[:id];

      puts "updated"
      render json: @vote.to_json
      return

    else
      puts vote.errors.messages
    end
  end

  def destroy

    puts "in votes destroy"

    vote = Vote.find(params[:id])
    if( vote  )
      @vote = {}
      @vote["votable_id"]=vote[:votable_id]
      votable = vote.votable

      vote.destroy
      @vote["like_count"] = votable.votes.where(vote_sign:1).count
      @vote["dislike_count"] = votable.votes.where(vote_sign:2).count
      puts "deleted"
      render json: @vote.to_json
    else
      puts vote.errors.messages
    end
  end

  def vote_params
    params.require(:vote).permit(:user_id,:vote_sign,:votable_type,:votable_id)
  end

end
