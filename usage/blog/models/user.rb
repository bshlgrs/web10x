require './lib/web_10x'

class User < Web10xUser
  soft_deleteable by: [:self, :admin]

  include Versioned

  define_attributes do |s|
    s.attribute(:username, :nonempty_string) do |a|
      a.uniqueness_constraint(key: :user_names, normalization: :downcase)
      a.visible_to :everyone
      a.changeable_by :admins
    end

    s.attribute :is_admin, :boolean do |a|
      a.default false # throw error if no default given
      a.visible_to :admins
      a.changeable_by :admins
      a.versioning :on
    end

    s.attribute :description, :text do |a|
      a.visible_to :users
      a.changeable_by :self, :admins

      a.render_as :markdown
    end

    s.attribute :hellbanned, :boolean do |a|
      a.visible_to :admins
      a.changeable_by :admins
    end
  end

  def showable_to
    if self.hellbanned
      [:admins, User.where(:hellbanned), :self]
    else
      :everyone
    end
  end

  has_many :posts
end
