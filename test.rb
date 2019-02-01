

require 'nationbuilder'

client = NationBuilder::Client.new('harrysandboxdev', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "find recently created people"

create_recently_tag = {
  tag: "harrytest123"
  }
  
create_recently_1 = client.call(:people_tags, :people, create_recently_tag)
create_recently_2 = NationBuilder::Paginator.new(client, create_recently_1)

create_recently_3 = []
  create_recently_3 += create_recently_2.body['results']
while create_recently_2.next?
  create_recently_2 = create_recently_2.next
  create_recently_3 += create_recently_2.body['results']
end  


yesterday_1 =  DateTime.now - 1
expires_7_day = DateTime.now + 7
  
create_recently_3.each do |create_recently_4|
  if Date.parse(create_recently_4['created_at']) >= yesterday_1  
  
  email = create_recently_4['email']
  id = create_recently_4['id']
  puts "#{email} id #{id} why #{expires_7_day}" 
  
   
    params = {
 person_id: "#{id}",
 membership: {
      name: "test",
    status: "active",
   expires_on: "#{expires_7_day}"
   }
}
    client.call(:memberships, :create , params)
    
  else  

puts "NOT adding membership #{id}" 
    
end
  
end

