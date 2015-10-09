if ['test'].include? Rails.env
  ReqresRspec.configure do |c|
    c.output_path = 'public/doc' # by default it will use doc/reqres
  end 
end
