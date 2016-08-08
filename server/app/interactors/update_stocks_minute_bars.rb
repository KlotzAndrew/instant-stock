class UpdateStocksMinuteBars
  include Interactor::Organizer

  organize FetchMinuteBars,
           CreateMinuteBars
end
