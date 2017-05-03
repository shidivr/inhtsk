require 'spec_helper'
require_relative '../movie'
require_relative '../ancient'

describe Movie do
  let(:mov_col){MovieCollection.new('movies.txt')}
  describe '#Movie.create' do
    let(:content){["http://imdb.com/title/tt0073195/?ref_=chttp_tt_209","Jaws",year,"USA","1975-06-20","Adventure,Drama,Thriller","124 min","8.1","Steven Spielberg","Roy Scheider,Robert Shaw,Richard Dreyfuss"]}
    subject{Movie.create(content,mov_col).inspect }

    context 'Ancient' do
      let(:year) { '1930' }
      it { is_expected.to eq("Jaws - старый фильм(1930 год)") }
    end
    
    context 'Classic' do
      let(:year) { '1960' }
      it { is_expected.to eq("Jaws - классический фильм, Steven Spielberg это известный режиссёр, ещё (5) его фильм(ов) попал(и) в топ-250") }
    end
    
    context 'Modern' do
      let(:year) { '1970' }
      it { is_expected.to eq("Jaws - cовременное кино: играют Roy Scheider,Robert Shaw,Richard Dreyfuss") }
    end
    
    context 'New' do
      let(:year) { '2010' }
      it { is_expected.to eq("Jaws - новинка, вышло 7 лет назад!") }
    end
  end
  
  describe '#has_genre' do
    let(:content){["http://imdb.com/title/tt0073195/?ref_=chttp_tt_209","Jaws","1930","USA","1975-06-20","Adventure,Drama,Thriller","124 min","8.1","Steven Spielberg","Roy Scheider,Robert Shaw,Richard Dreyfuss"]}
    subject{Movie.create(content,mov_col).has_genre?(genre) }
    
    context 'true condition' do
      let(:genre) { 'Drama' }
      it { is_expected.to eq(true) }
    end
    
    context 'false condition' do
      let(:genre) { 'Comedy' }
      it { is_expected.to eq(false) }
    end
    
    context 'not exist condition' do
      let(:genre) { 'www' }
      it { expect{subject}.to raise_error('жанра www не существует') }
    end
  end
  
  describe '#mathches' do 
    let(:content){["http://imdb.com/title/tt0073195/?ref_=chttp_tt_209","Jaws","1930","USA","1975-06-20","Adventure,Drama,Thriller","124 min","8.1","Steven Spielberg","Roy Scheider,Robert Shaw,Richard Dreyfuss"]}
    subject{Movie.create(content,mov_col).matches?(:title,req) }
    
    context 'right matches' do
      let(:req) { "Jaws" }
      it { is_expected.to be true }
    end
    
    context 'wrong matches' do
      let(:req) { "jjaws" }
      it { is_expected.to be false }
    end    
  end
end
