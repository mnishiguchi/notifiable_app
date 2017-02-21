class User::Import
  include ActiveModel::Model
  attr_accessor :file,           # A temporary file object that Rails creates when a file is uploaded.
                :imported_count  # Count the number of records that were imported from the file.

  def import
    @imported_count = 0

    # Reject if the file attribute is nil or empty.
    if file.blank?
      errors.add(:base, "No file is specified") and return
    end

    CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
      # Crete a user in memory.
      user = User.assign_from_row(row)

      # Try to save it in the database.
      if user.save
        @imported_count += 1
      else
        # The magic variable $. keeps track of the last line read in a file.
        errors.add(:base, "Line #{$.} - #{user.errors.full_messages.join(', ')}")
      end
    end
  end

  # Returns true on success or false on failure.
  def save
    import
    errors.none?
  end
end
