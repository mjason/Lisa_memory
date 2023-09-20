class Item < ApplicationRecord
  belongs_to :dialogue
  belongs_to :session

  has_neighbors :embedding

  class << self
    def text_split(text)
      splitter = Baran::RecursiveCharacterTextSplitter.new(
        chunk_size: 256,
        chunk_overlap: 16,
        separators: ["\n\n", "\n", ",", "", ";", ".", "，", "。", "；", "：", "！", "？", "、", "!", "?"]
      )
      splitter.chunks(text)
    end
  end

end
