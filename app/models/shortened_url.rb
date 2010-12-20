class ShortenedUrl
  include Mongoid::Document
  
  field :url
  field :shortened
  field :last_hit, :type => DateTime
  field :hits_count, :type => Integer
  
  before_create :create_shortened
  
  def visited!
    write_attribute(:hits_count, self.hits_count.to_i + 1)
    write_attribute(:last_hit, Time.now)
    save!
  end
  
  private
  
  def create_shortened
    if shortened.blank? || already_exists?(shortened)
      shortened_version = random_string(6)
      write_attribute :shortened, shortened_version
    end
  end
  
  def random_string(size)
    string = (1..size).collect { (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }.join

    if already_exists?(string)
      random_string(size)
    else
      string
    end
  end
  
  def already_exists?(string)
    self.class.exists?(:conditions => { :shortened => string })
  end
  
end
