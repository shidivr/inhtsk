require_relative 'spec_helper'
require_relative '../lib/movies'
describe Netflix do
  let(:netflix) {Movies::Netflix.new('./example/movies.txt')}
  
  describe '#show' do
  
    context 'when enough money' do
      before do
        netflix.pay(25)
      end 
      it 'should show movies' do
        expect(netflix.show(genre: 'Comedy', period: :new).class).to eq(New)   
      end
      
      context 'test all periods' do        
        describe 1900..1945 do
          it { is_expected.to include(netflix.show(period: :ancient).year) }
        end
        
        describe 1945..1968 do
          it { is_expected.to include(netflix.show(period: :classic).year) }
        end
        
        describe 1968..2000 do
          it { is_expected.to include(netflix.show(period: :modern).year) }
        end
        
        describe 2000..2017 do
          it { is_expected.to include(netflix.show(period: :new).year) }
        end                 
      end
    end

    context 'when not enough money' do
     it 'should raise error' do 
        expect {netflix.show(period: :new, genre: 'Comedy')}.to raise_error('havnt money for showing movie')
      end  
    end
  end
   
  describe '#pay' do 
    it 'changes account' do 
      expect { netflix.pay(25) }.to change(netflix, :person_acct).by(25) 
    end
     
    it 'fails when negative amount' do
      expect {netflix.pay(-30)}.not_to change(netflix, :person_acct)
    end 
  end

  it 'should shows cost of the movie' do 
    expect(netflix.how_much?('Terminator')).to eq('Movie "Terminator" costs: 3')
  end
end
