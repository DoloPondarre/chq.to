class Link < ApplicationRecord
    belongs_to :user

    validates :name, presence: true
    validates :url, presence: true, format: { with: URI::regexp(%w[http https]), message: 'must be a valid URL' }
    validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: 'can only contain letters, numbers, underscores, and hyphens' }
    validates :link_type, presence: true, inclusion: { in: %w[regular temporal privado efimero], message: 'must be one of: regular, temporal, privado, efimero' }
    validates :expires_at, presence: true, if: -> { link_type == 'temporal' }
    validates :password, presence: true, if: -> { link_type == 'privado' }

    before_validation :generate_unique_slug
    before_save :generate_short_url
    
    def self.link_types
        {
          'Regular' => 'regular',
          'Temporal' => 'temporal',
          'Privado' => 'privado',
          'Efimero' => 'efimero'
        }
    end

    private

    def generate_unique_slug
        self.slug ||= SecureRandom.hex(4)
    end

    def generate_short_url
        self.short_url = "https://chq.to/l/#{slug}" # Modifica según tu patrón de URL corta
    end
end
