require 'garage'

describe Garage do
  let(:van) { double :van, bikes: [broken_bike, broken_bike], collect_broken_bikes: [broken_bike, broken_bike], deliver: [broken_bike, broken_bike] }
  let(:broken_bike) { double :broken_bike, report_broken: true, broken: true, working?:false }
  let(:bike) { double :bike, broken: false, working?: true }
  let(:station) { double :station, dock_bike: true, bikes: [broken_bike, bike, bike, bike] }

  it 'should report what bikes it has' do
    subject.receive(van)
    expect(subject.bikes).to eq [broken_bike, broken_bike]
  end


  it 'should receive bikes' do
    broken_bike.report_broken
    station.dock_bike(broken_bike)
    van.collect_broken_bikes(station)
    van.deliver
    expect(subject.receive(van)).to eq subject.bikes
  end

end
