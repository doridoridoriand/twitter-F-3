class ServiceItem < Items

  def self.create(params)
    entry_hex = SecureRandom.hex(10)
    new_item = Items.new(uuid: params['uuid'],
                         hex:  entry_hex,
                         content: params['content'],
                         created_at: Time.now)
    new_item.save
    entry_hex
  end

  def self.show(params)
    Items.where(id: params['from']..params['to']).order('created_at desc')
  end

  # @param array
  # @return array
  def self.show_with_uuid(params)
    Items.where(uuid: params).order('created_at desc')
  end

  # @param hash
  # @return array
  # TODO: DBに負担かかる書き方しているので要修正
  def self.exist?(params)
    if self.find_by_uuid_hex(params)
      self.find_by_uuid_hex(params)
    else
      false
    end
  end

  def self.show_with_uuid_date(uuids, params)
    Items.where(uuid: uuids,
                created_at: params['from']..params['to'])
  end

  def self.find_by_username(params)
    user_detail = ServiceUser.find_by_username(params).first
    self.show_with_uuid(user_detail.uuid)
  end

  def self.find_by_uuid_hex(params)
    if params['owner_uuid'] && params['entry_hex']
      params['uuid'] = params['owner_uuid']
      params['hex'] = params['entry_hex']
    end
    Items.where(uuid: params['uuid'], hex: params['hex']).first
  end
end
