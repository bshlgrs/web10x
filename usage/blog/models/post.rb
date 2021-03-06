require './lib/web_10x'

class Post < Web10xModel
  # soft_deleteable by: [:user, :admin]
  include Versioned
  include ViewStatistics # gives you a view_statistics_store method

  define_attributes do |s|
    s.attribute(:title, :optional_nonempty_string) do |a|
      a.visible_to :user, :admins
      a.changeable_by :user, :admins
    end

    s.attribute(:body, :nonempty_string) do |a|
      a.visible_to :everyone
      a.changeable_by :user, :admins

      a.render_as :markdown
    end

    s.attribute(:is_published, :boolean) do |a|
      a.visible_to :user, :admins
      a.changeable_by :user, :admins
    end
  end

  belongs_to :user
end


