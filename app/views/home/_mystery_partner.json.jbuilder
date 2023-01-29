json.extract! mystery_partner, :id, :created_at, :updated_at
employee1 = Employee.find(mystery_partner.employee1_id)
employee2 = Employee.find(mystery_partner.employee2_id)
json.set! :name, employee1.name
json.set! :img, url_for(employee1.image)
json.employee1 do

    json.name employee1.name
    json.img url_for(employee1.image)
end
json.employee2 do
  json.name employee2.name
  json.img url_for(employee2.image)
end
