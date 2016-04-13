class ServiceItem < Items

  def self.create(params)
    new_item = Items.new(uuid: params['uuid'],
                         hex:  SecureRandom.hex(10),
                         content: params['content'],
                         created_at: Time.now)
    new_item.save
  end
end
