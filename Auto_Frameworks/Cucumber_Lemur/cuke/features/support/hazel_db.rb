class HAZEL_DB
  
  
  def initialize
    @dbh = DBI.connect('DBI:OCI8:HAZELQA', 'PUBLISHER', 'VKNCHCRW')
  end
  
  def send statement
    @result = @dbh.execute(statement)
  end
  
  def get_publisher_configs pub_id
    hsh = Hash.new
    query = @dbh.execute("SELECT NOTES, NAME, EXTERNAL_NAME, ATTI_CONTACT, SYSTEM_STATUS, CLIENT_STATUS, CUST_ACQ_TYPE_ID, URL, DESCRIPTION, IS_OANDO FROM PUBLISHER_HAZEL WHERE PUBLISHER_ID = #{pub_id}")
    query.fetch_hash do |row|
      row.each do |k,v|
        v.class == OCI8::CLOB ? value = v.read : value = v
        hsh[k] = value
      end
    end
     query.finish
     close
     return hsh
  end
  
  def get_property_configs prop_id
    hsh = Hash.new
    query = @dbh.execute("SELECT NAME, STATUS_ID, DIST_CLASSIFICATION_ID, PROPERTY_CODE, DESCRIPTION, URL FROM PROPERTY WHERE PROPERTY_ID = #{prop_id}")
    query.fetch_hash do |row|
      row.each do |k,v|
        v.class == OCI8::CLOB ? value = v.read : value = v
        hsh[k] = value
      end
    end
     query.finish
     close
     return hsh
  end
  
  def get_implementation_configs imp_id
    hsh = Hash.new
    query = @dbh.execute("SELECT NAME, DESCRIPTION, DIST_MEDIUM_ID, CLIENT_STATUS, SYSTEM_STATUS, STATE, IS_PURCHASED, HOSTED_BY_TYPE_ID, REPORTING_TYPE_ID, HAS_SLA, IS_AD_UNIT, URL, ADS_TARGETED_BASED_ON FROM IMPLEMENTATION WHERE IMPLEMENTATION_ID = #{imp_id}")
    query.fetch_hash do |row|
      row.each do |k,v|
        v.class == OCI8::CLOB ? value = v.read : value = v
        hsh[k] = value
      end
    end
     query.finish
     close
     return hsh
  end
  
  def update_publisher_configs values
    change = ''
    values.each_pair do |k,v|
      unless k == 'PUBLISHER_ID' then
        v.class == String ? change << ", #{k}='#{v}'" : change << ", #{k}=#{v}"
      end
    end
    statement = "UPDATE Publisher_hazel SET #{change.sub(', ', '')} where PUBLISHER_ID = #{values['PUBLISHER_ID']}"
    query = @dbh.execute(statement)
    @dbh.commit
    @dbh.disconnect
  end
  
  def update_property_configs values
    change = ''
    values.each_pair do |k,v|
      unless k == 'PROPERTY_ID' then
        v.class == String ? change << ", #{k}='#{v}'" : change << ", #{k}=#{v}"
      end
    end
    statement = "UPDATE PROPERTY SET #{change.sub(', ', '')} where PROPERTY_ID = #{values['PROPERTY_ID']}"
    query = @dbh.execute(statement)
    @dbh.commit
    @dbh.disconnect
  end
  
  def update_implementation_configs values
    change = ''
    values.each_pair do |k,v|
      unless k == 'IMPLEMENTATION_ID' then
        v.class == String ? change << ", #{k}='#{v}'" : change << ", #{k}=#{v}"
      end
    end
    statement = "UPDATE IMPLEMENTATION SET #{change.sub(', ', '')} where IMPLEMENTATION_ID = #{values['IMPLEMENTATION_ID']}"
    query = @dbh.execute(statement)
    @dbh.commit
    @dbh.disconnect
  end
  
  def commit
    @dbh.commit
  end
  
  def close
    @dbh.disconnect
  end
  
end