class Dialogue < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :session

  after_create :create_q_and_q_embedding

  def to_message
    [
      {role: "user", content: self.question},
      {role: "assistant", content: self.answer}
    ]
  end

  def create_q_and_q_embedding
    questions = Item.text_split(self.question)
    answers = Item.text_split(self.answer)

    questions.each do |question|
      self.items.create(embedding: Dialogue.fetch_embedding(question[:text]), session_id: self.session_id)
    end

    answers.each do |answer|
      self.items.create(embedding: Dialogue.fetch_embedding(answer[:text]), session_id: self.session_id)
    end

  end

  class << self
    def fetch_embedding(text)
      url = "https://api.listenai.com/v1/embedding"
      HTTP.auth("Bearer 06083942-174a-4158-bc84-56db6419f15e").post(url, json: {input: text}).parse["data"]
    end
  end

end
