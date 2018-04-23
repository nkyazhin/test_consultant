require 'spec_helper'

feature "Find document", js: true do


  before do

  end

  scenario '#find document' do
    # Заходим на сайт
    visit_cons_page
    # Проверяем что это нужная нам страница
    expect_correct_cons_page
    # Ищем документ
    name = 'нк ч2'
    find_document(name)
    popup_window = window_opened_by do
      open_first_document
    end
    within_window popup_window do
      puts iframe = page.all('iframe').first
      within_frame(iframe) do
        puts page.all('span').count
      end
    end
    # puts iframe.inspect
    # page.driver.browser.switch_to.frame(iframe)
    # page.find(:xpath, "//span[@class='blk']")
    #
    # within_frame(iframe) do
    #   puts page.inspect
    #   sleep 10
    # end
    # page.find(:xpath, "//iframe[contains(@src, 'код']")
    # sleep 100
  end

  private

  def visit_cons_page
    visit '/cons'
  end

  def expect_correct_cons_page
    expect(page).to have_title('КонсультантПлюс - Стартовая страница')
    expect(page).to have_xpath("//form[@class='filterForm']")
  end

  def find_document(name)
    page.fill_in :dictFilter, with: name
    click_button 'Найти'
  end

  def open_first_document
    page.find(:xpath,"//div[@class='listPaneContent']/div[@index='0']").click
  end
end
