class AddAttachmentCoverToGigs < ActiveRecord::Migration
  def self.up
    change_table :gigs do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :gigs, :cover
  end
end
