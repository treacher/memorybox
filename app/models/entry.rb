class Entry < ActiveRecord::Base
	acts_as_paranoid column: 'deleted', column_type: 'boolean'

	[:media_url, :media_identifier, :media_format, :media_type].each do |attribute|
  	validates :"#{attribute}", presence: true
	end

  belongs_to :memory_box

  default_scope order('created_at DESC')

end