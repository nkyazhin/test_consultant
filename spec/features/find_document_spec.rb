require 'spec_helper'

feature "Find document", js: true do


  before do

  end

  scenario '#find document' do
    visit_cons_page
    expect_correct_cons_page
    name = 'нк ч2'
    # Ищем документ
    find_document(name)
    puts '1111111'
    sleep 5
    popup_window = window_opened_by do
      open_first_document
    end
    puts '222222'
    within_window popup_window do
      sleep 5
      puts '333333333333'
        puts iframe = page.find(:xpath, "//td[@class='textContainer']//iframe[@id='listContainerFrame']")
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
    page.find(:xpath,"//div[@class='listPaneContent']/div[@index='0']").click
  end
end
