class PortfolioPage < SitePrism::Page
  set_url "/portfolios/{id}"

  element :page_title, '#portfolio-title'
  element :messages_area, '#messages'
  element :trades_area, '#trades'

  element :messages, '.message'
  element :message_input, '#message_input'
end
