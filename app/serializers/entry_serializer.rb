class EntrySerializer < ActiveModel::Serializer
  attributes :id, :description, :media_url, :media_identifier, :media_format, :media_type, :created_at, :updated_at
end