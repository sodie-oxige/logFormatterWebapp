class AppearPc < ApplicationRecord
  belongs_to :log
  belongs_to :character, class_name: "Character", foreign_key: "pc_id"
end
