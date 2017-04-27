require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  let(:theatre) {Theatre.new('movies.txt' || ARGV[0])}
  
  describe '#show' do
    subject { theatre.show(time).first.inspect.gsub("\n","") }
    context 'morning' do
      let(:time) { '06:00' }
      it { is_expected.to eq('Casablanca | USA | ["Drama", "Romance", "War"] | 1942 | 8.6') }
    end
    
    context 'day' do
      let(:time) { '12:00' }
      it { is_expected.to eq('Life Is Beautiful | Italy | ["Comedy", "Drama", "Romance"] | 1997 | 8.6')}
    end
     
      
    context 'day' do
      let(:time) { '18:00' }
      it { is_expected.to eq('Psycho | USA | ["Horror", "Mystery", "Thriller"] | 1960 | 8.6')}            
    end
    
    context 'if night time' do
      it 'shoud show movies on time' do
        expect(theatre.show("04:20").empty?).to eq(true)
      end
    end   
end
    
  describe '#when' do
    it 'should show time' do
      expect(theatre.when?('Psycho')).to eq("since 06:00 before 12:00 and since 12:00 before 18:00")
    end
  end
end
