

require 'nationbuilder'

client = NationBuilder::Client.new('harrycossar', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "find recently created people"

create_recently = {
  tag: "XX %20a XX %20core%20q2%202018"
  }
  
create_recently_1 = client.call(:people_tags, :people, create_recently)
create_recently_2 = NationBuilder::Paginator.new(client, create_recently_1)

create_recently_3 = []
  create_recently_3 += create_recently_2.body['results']
while create_recently_2.next?
  create_recently_2 = create_recently_2.next
  create_recently_3 += create_recently_2.body['results']
end  


yesterday_1 =  DateTime.now - 1
  
create_recently_3.each do |create_recently_4|
  if Date.parse(create_recently_4['created_at']) >= yesterday_1  
  
  email = person['email']
  id = person['person_id']
  puts "#{email} #{id} " 
  
   
    params = {
 id: "#{id}",
 name: "onboarding_petition",
  
}
    client.call(:memberships, :create , params)
    
  else  

puts "NOT adding membership #{id}" 
    
end
  

