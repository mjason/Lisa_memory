class Session < ApplicationRecord
  has_many :dialogues, dependent: :destroy
  has_many :items

  after_create :create_dialogues

  def messages=(messages)
    @messages = messages
  end

  def create_dialogues
    self.dialogues.create(@messages)
  end
end
