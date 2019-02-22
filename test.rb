

require 'nationbuilder'

client = NationBuilder::Client.new('harrysandboxdev', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "find recently created people"

date_25day=DateTime.now - 2.5

person_to_create= {
  "person": {
    "email": "bob1@example.com",
    "last_name": "Smith",
    "first_name": "Bob",
    "created_at": "#{date_25day}",
  }
}

client.call(:people, :create, person_to_create)


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


two_days_ago =  DateTime.now - 2
three_days_ago =  DateTime.now - 3


#use this date for setting membership expiration
expires_7_day = DateTime.now + 7
  
#gets email and id from the list of people to then add membersip
create_recently_3.each do |create_recently_4|
  #will just add membership to people who's profile was created in the last day

    if Date.parse(create_recently_4['created_at']).between?(three_days_ago, two_days_ago) 
    
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

=begin
  
  membership_params = {
 person_id: "#{id}"
    }
  
  membership_1 = client.call(:membership, :index, membership_params)
membership_2 = NationBuilder::Paginator.new(client, membership_1)
  
   puts "#{membership_2}"
=end

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

#gets email and id from the list of people to then add membersip
create_recently_3.each do |create_recently_4|
  
 
  
  email = create_recently_4['email']
  id = create_recently_4['id']
  tags = create_recently_4['tags'] 
  puts "#{email} id #{id} #{tags}" 
  
petition_count=tags.count{ |element| element.match('petition') }
  
  puts "#{email} id #{id} #{petition_count}" 
  
  
  
    add_tag = {
 id: "#{id}",
  tagging: {
    tag: "PETITIONS SIGNED:  #{petition_count}"
  }
  
}
  
    client.call(:people, :tag_person , add_tag)
  
  end  
=end    
