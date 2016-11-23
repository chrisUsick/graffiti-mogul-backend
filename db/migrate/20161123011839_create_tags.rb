class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :title

      t.binary :thumbnail
      t.st_point :location, geographic: true

      t.timestamps
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
