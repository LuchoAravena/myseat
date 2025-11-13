json.extract! guest, :id, :table_id, :name, :notes, :created_at, :updated_at
json.url guest_url(guest, format: :json)
