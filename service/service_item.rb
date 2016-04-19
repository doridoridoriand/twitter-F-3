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

  # @param array
  # @return array
  def self.show_with_uuid(params)
    Items.where(uuid: params)
  end

  def self.show_with_uuid_date(params)
    Items.where(uuid: params['uuid'],
                id: params['from']..params['to'])
  end

  def self.find_by_username(params)
    user_detail = ServiceUser.find_by_username(params).first
    self.show_with_uuid(user_detail.uuid)
  end

  def self.find_by_uuid_hex(params)
    Items.where(uuid: params['uuid'], hex: params['hex'])
  end
end
