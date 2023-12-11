class Link < ApplicationRecord
    belongs_to :user
    has_many :accesses, dependent: :destroy

    validates :name, presence: true
    validates :url, presence: true, format: { with: URI::regexp(%w[http https]), message: 'must be a valid URL' }
    validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: 'can only contain letters, numbers, underscores, and hyphens' }
    validates :link_type, presence: true, inclusion: { in: %w[Regular Temporary Private Ephemeral], message: 'must be one of: Regular, Temporary, Private, Ephemeral' }
    validates :expires_at, presence: true, if: -> { link_type == 'Temporary' }
    validates :password, presence: true, if: -> { link_type == 'Private' }

    before_validation :generate_unique_slug
    
    def self.link_types
        {
          'Regular' => 'Regular',
          'Temporary' => 'Temporary',
          'Private' => 'Private',
          'Ephemeral' => 'Ephemeral'
        }
    end

    private

    def generate_unique_slug
        self.slug ||= SecureRandom.hex(4)
    end

end
