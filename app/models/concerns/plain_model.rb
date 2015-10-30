class PlainModel < ActiveType::Object
  def save
    if valid?
      run_callbacks :save do
        true
      end
    else
      false
    end
  end
end
