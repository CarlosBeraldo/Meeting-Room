json.extract! meeting, :id, :start_date, :start_time, :description, :user_id, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
