class ServiceItem < Items

  def self.create(params)
    new_item = Items.new(uuid: params['uuid'],
                         hex:  SecureRandom.hex(10),
                         content: params['content'],
                         created_at: Time.now)
    new_item.save
  end

  def self.show(params)
    Items.where(id: params['from']..params['to'])
  end

  def self.find_by_uuid_hex(params)
    Items.where(uuid: params['uuid'], hex: params['hex'])
  end
end
