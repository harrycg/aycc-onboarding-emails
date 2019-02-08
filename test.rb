

require 'nationbuilder'

client = NationBuilder::Client.new('harrysandboxdev', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "find recently created people"

#sets the tag you want to pull out
create_recently_tag = {
  tag: "harrytest123"
  }
  
#pulls people from nationbuilder
create_recently_1 = client.call(:people_tags, :people, create_recently_tag)
create_recently_2 = NationBuilder::Paginator.new(client, create_recently_1)

#stores results
create_recently_3 = []
  create_recently_3 += create_recently_2.body['results']
while create_recently_2.next?
  create_recently_2 = create_recently_2.next
  create_recently_3 += create_recently_2.body['results']
end  

#gets email and id from the list of people to then add membersip
create_recently_3.each do |create_recently_4|
  
 
  
  email = create_recently_4['email']
  id = create_recently_4['id']
  tags = create_recently_4['tags']
  puts "#{email} id #{id} #{tags}" 
  
 
  

petition_count=tags.count{ |element| element.match(petition) }
  
  puts "#{email} id #{id} #{petition_count}" 
  
  end  
    
=begin
#sets the tag you want to pull out
create_recently_tag = {
  tag: "harrytest123"
  }
  
#pulls people from nationbuilder
create_recently_1 = client.call(:people_tags, :people, create_recently_tag)
create_recently_2 = NationBuilder::Paginator.new(client, create_recently_1)

#stores results
create_recently_3 = []
  create_recently_3 += create_recently_2.body['results']
while create_recently_2.next?
  create_recently_2 = create_recently_2.next
  create_recently_3 += create_recently_2.body['results']
end  


yesterday_1 =  DateTime.now - 1

#use this date for setting membership expiration
expires_7_day = DateTime.now + 7
  
#gets email and id from the list of people to then add membersip
create_recently_3.each do |create_recently_4|
  
  #will just add membership to people who's profile was created in the last day
  if Date.parse(create_recently_4['created_at']) >= yesterday_1  
  
  email = create_recently_4['email']
  id = create_recently_4['id']
  puts "#{email} id #{id} why #{expires_7_day}" 
  
   
    #parameter for the new membership
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
#this is for people who weren't created in the last day
puts "NOT adding membership #{id}" 
    
end
  
end
=end
