class Movie < ActiveRecord::Base
    
    def find_all_by_director 
    all_directors = []
	self.select(:director).group(:director).each do |mo|
	all_directors << mo.director
	end
		return all_directors
     
 end    
    
end
