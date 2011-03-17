class TestUser
                               
  def TestUser.create_random_user 
    {
      :username => "Webypqa_#{Time.now.to_i.to_s(36)}#{5.times.map{(rand(26) + 97).chr}.join}",
      :email    => "#{username}@example.com"
    }
  end
end
