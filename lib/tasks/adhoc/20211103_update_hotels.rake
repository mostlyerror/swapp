# this is really error prone, but wanted to document this somewhere, and enable
# it to be run in more than one place. 
#
namespace :adhoc do
  desc "20211103_update_hotels_and_contacts"
  task update_hotels_and_contacts: :environment do
    data = [
      {
        hotel: {
          name: "Comfort Inn Denver",
        },
        contacts: [
          {
            first_name: "Angela",
            last_name: "Reynolds",
            title: "General Manager",
            phone: "720-934-4946"
          }
        ]
      },
      {
        hotel: {
          name: "Quality Inn"
        },
        contacts: [
          {
            first_name: "Cris",
            title: "General Manager"
          },
          {
            first_name: "Amie",
            title: "Front Desk Manager"
          }
        ]
      },
      {
        hotel: {
          name: "Comfort Inn-Brighton",
          phone: "720-685-1500",
          address: {
            street: "2180 Medical Center Dr",
            city: "Brighton",
            state: "CO",
            zip: "80601"
          }
        },
        contacts: [
          {
            first_name: "Brian",
            last_name: "Moen",
            title: "General Manager"
          }
        ]
      },
      {
        hotel: {
          name: "HomeTowne Studios",
        },
        contacts: [
          {
            first_name: "Shalimar",
            title: "General Manager"
          }
        ]
      },
      {
        hotel: {
          name: "Penn Motel - Commerce City",
          phone: "(303) 287-7366",
          address: {
            street: "6630 HWY 2",
            city: "Commerce City",
            state: "CO",
            zip: "80022"
          }
        },
        contacts: [
          {
            first_name: "Eva",
            last_name: "Song",
            phone: "720-514-3868"
          }
        ]
      },
      {
        hotel: {
          name: "HomeTowne Suites- Denver Airport/Aurora",
          phone: "303-307-1088",
          address: {
            street: "3705 Chambers Rd",
            city: "Aurora",
            state: "CO", 
            zip: "80011"
          }
        },
        contacts: [
          {
            first_name: "Reed", 
            last_name: "Martini",
            phone: "303-817-4510"
          }
        ]
      },
      {
        hotel: {
          name: "Triangle T Motel- Commerce City",
          phone: "(303) 287-9859",
          address: {
            street: "7030 Hwy 2",
            city: "Commerce City",
            state: "CO", 
            zip: "80022"
          }
        },
        contacts: [
          {
            first_name: "Hyun",
            last_name: "Song",
            phone: "303-286-9055"
          }
        ]
      }
    ]

    ActiveRecord::Base.transaction do
      puts Hotel.count
      puts HotelContact.count
      puts Contact.count

      data.each do |attrs|
        h_attrs = attrs[:hotel]
        address = h_attrs.delete(:address)
        contacts = attrs[:contacts]

        hotel = Hotel.find_or_create_by(h_attrs)
        hotel.update(address: address) if address.present?
        contacts.each do |c_attrs|
          hotel.contacts.find_or_create_by(c_attrs)
        end
      end

      puts Hotel.count
      puts HotelContact.count
      puts Contact.count
      ap Hotel.all
      ap HotelContact.all
      ap Contact.all
      raise ActiveRecord::Rollback
    end
  end
end
