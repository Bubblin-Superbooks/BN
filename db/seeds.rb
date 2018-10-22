class PopulateDb
  def self.seed_db
    clear_db
    create_users
    create_links
    add_comments
    p 'All done'
  end

  private_class_method

  def self.create_users
    12.times do
      User.create(username: Faker::Name.unique.name, password: '1234567890')
    end
  end

  def self.create_links
    User.all.each do |user|
      user.links.create(title: Faker::Hipster.unique.sentence(7, false, 4))
    end
  end

  def self.add_comments
    Link.all.each do |link|
      rand(1..12).times do
        link.comments.create(body: Faker::Hacker.unique.say_something_smart,
                             user: User.all[rand(0..11)])
      end
    end
  end

  def self.clear_db
    User.destroy_all
    Link.destroy_all
    Comment.destroy_all
  end
end

PopulateDb.seed_db