require "test_helper"

class DialogueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test fetch_embedding" do
    text = "你好"
    vec = Dialogue.fetch_embedding(text)
    assert_equal vec.size, 1024
  end

  test "test create_q_and_q_embedding" do
    question = "你好"
    answer = "你好"
    dialogue = Dialogue.create(question: question, answer: answer)
    binding.irb
    assert_equal dialogue.items.size, 2
    dialogue.destroy
  end
end
