class Author < MotionData::ManagedObject
end

class Article < MotionData::ManagedObject
end

class Author
  hasMany :articles, :destinationEntity => Article.entityDescription, :inverse => :author

  property :name, String, :required => true
  property :fee, Float
  attr_accessor :count
  afterSave :after_save
  def self.after_save(notification)
    @count += 1
  end
end

class Article
  hasOne :author, :destinationEntity => Author.entityDescription, :inverse => :articles

  property :title,     String,  :required => true
  property :body,      String,  :required => true
  property :published, Boolean, :default  => false
  property :publishedAt, Time, :default  => false
  property :length, Integer32

  scope :published, where(:published => true)
  scope :withTitle, where( value(:title) != nil ).sortBy(:title, ascending:false)
end
