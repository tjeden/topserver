require 'spec_helper'

describe TopserverLogger do
  context '#info' do
    it 'uses puts' do
      subject.should_receive(:puts).with('hoho')
      subject.info('hoho')
    end
  end
end
