class SessionsController < ApplicationController
  def create
    messages = params[:messages] || []

    unless messages.size.even?
      render json: {error: "messages size must be odd"}, status: 400
      return
    end

    messages = messages.each_cons(2).map do |q_and_a|
      question = q_and_a.find{|m| m[:role] == "user"}[:content]
      answer = q_and_a.find{|m| m[:role] == "assistant"}[:content]
      {question: question, answer: answer}
    end

    session = Session.new(messages: )
    if session.save
      render json: {session_id: session.id}, status: 200
    else
      render json: {error: session.errors.full_messages}, status: 400
    end

  end

  def show
    session = Session.find(params[:id])
    render json: session.dialogues, status: 200
  end

  def search
    user_input = params[:user_input]
    limit = params[:limit] || 6

    embedding = Dialogue.fetch_embedding(user_input)
    items = Item.where(session_id: params[:session_id]).nearest_neighbors(:embedding, embedding, distance: "cosine")

    dialogues = items.map(&:dialogue)&.uniq&.take(limit)&.reverse&.map(&:to_message)&.flatten
    dialogues&.push({role: "user", content: user_input})

    render json: dialogues, status: 200
  end
end
