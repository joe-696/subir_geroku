class Publicacion < ApplicationRecord
    has_one_attached :imagen

    validates :titulo, presence: true 
    validates :descripcion, presence: true 
    
    
    def self.search(query)
        where("titulo LIKE ? OR descripcion LIKE ?", "%#{query}%", "%#{query}%")
    end
    has_many :comments, dependent: :destroy
    # publicación puede tener muchos comentarios. 

    belongs_to :category
    belongs_to :user, default: -> {Current.user}

end

