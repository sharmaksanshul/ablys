class AddIsNccMemberToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_ncc_member, :boolean, :default => false

  	phone = ["9314016972", "9769588007", "9214065151", "7597346846", "9414284692", "9400959303", 
  	"9821153356", "9917171316", "9967203755", "9414421360", "9783149445", "9414317760", 
  	"9510825830", "9414933212", "9785225625", "9982213147", "9529662916", "9448369066", 
  	"9274502611", "9571788482", "9250001023", "9799109615", "9828089097", "9845172480",
  	"9860293939", "9300081800", "9837875049", "9928680317", "9900899569", "9911693551", 
  	"9013607754", "7597003513", "9460288027", "8734059618", "9829980367"]

  	User.where(:phone => phone).update_all(:is_ncc_member => true)
  end
end
