class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :status, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def pet_count
    pets.count
  end

  def app_pet(pet_id)
    ApplicationPet.where("pet_id = ? AND application_id = ?", "#{pet_id}" ,"#{id}").first
  end
end
