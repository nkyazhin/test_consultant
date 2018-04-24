require 'spec_helper'

feature "Find document", js: true do
  let(:document_name) { 'нк ч2' }
  let(:delay_open_document) { Config.new.delay_open_document }

  scenario '#find document' do
    visit_cons_page
    expect_correct_cons_page
    find_document(document_name)
    # Запоминаем открывшуюся вкладку
    popup_window = window_opened_by do
      open_first_document
    end
    sleep delay_open_document.to_i
    # Все действия в данном блоке введуся во вкладке popup_window
    within_window popup_window do
      # Находим iframe
      # Все действия в данном блоке введуся 'внутри' найденного iframa
      within_frame('listContainerFrame') do
        expect(page).to have_content(/налоговый КОДЕКС/i)
        expect(page).to have_content(/чАсТь ВтОраЯ/i)
      end
    end
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
    page.find(:xpath, "//div[@class='listPaneContent']/div[@index='0']").click
  end
end
