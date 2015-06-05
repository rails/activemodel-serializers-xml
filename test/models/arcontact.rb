class ARContact < ActiveRecord::Base
  include ActiveModel::Serializers::Xml

  belongs_to :alternative, :class_name => 'ARContact'
  serialize :preferences
end

class ContactSti < ActiveRecord::Base
  def type; 'ContactSti' end
end
