require 'spec_helper' 

describe DataPack do
  describe 'send_at' do
    it 'is nil when created' do
      Factory(:data_pack).send_at.should be_nil
    end

    it 'is set after being send to client' do
      data_pack = Factory(:data_pack)
      data_pack.send_to_client!  
      data_pack.send_at.should_not be_nil
    end
  end

  describe 'recieved_at' do
    it 'is nil when created' do
      Factory(:data_pack).recieved_at.should be_nil
    end

    it 'is set after being recieved to client' do
      data_pack = Factory(:data_pack)
      data_pack.send_to_client!
      data_pack.recieve!
      data_pack.recieved_at.should_not be_nil
    end
  end
end
