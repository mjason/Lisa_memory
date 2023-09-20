class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :dialogue, index: true
      t.references :session, index: true
      t.timestamps
    end
    add_column :items, :embedding, :vector, limit: 1024
    add_index :items, :embedding, using: :hnsw, opclass: :vector_cosine_ops
  end
end
