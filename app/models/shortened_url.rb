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
      write_attribute :shortened, bijective_encode(ShortenedUrl.count() + 1000)
  end
    
  ALPHABET =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
    # make your own alphabet using:
    # (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle.join

  def bijective_encode(i)
    # from http://refactormycode.com/codes/125-base-62-encoding
    # with only minor modification
    return ALPHABET[0] if i == 0
    s = ''
    base = ALPHABET.length
    while i > 0
      s << ALPHABET[i.modulo(base)]
      i /= base
    end
    s.reverse
  end
  
end
