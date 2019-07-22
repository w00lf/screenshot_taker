require 'utils/watir_browser'

class SiteScreenshotTakeService
  def self.call(url:, field_to_fill:, info_to_fill:, autocomlite_selector:, button_submit:, headless: true)
    browser = WatirBrowser.new(headless: headless).watir_browser
    browser.goto(url)
    browser.text_field(css: field_to_fill).wait_until(&:present?).set(info_to_fill)
    2.times do
      browser.element(css: autocomlite_selector).wait_until(timeout: 3, &:present?).click() rescue print('Cannot click second time on elem, skipping')
      sleep 2
    end
    browser.element(css: button_submit).wait_until(&:present?).click() if button_submit
    sleep 3
    screenshot_location = '/Users/mitaraskin/Work/Personal/screenshot_taker/public'
    screenshot_file = "site_image_#{SecureRandom.uuid}.png"
    browser.screenshot.save(File.join(screenshot_location, screenshot_file))
    last_url = browser.url
    browser.close()
    {
      url: last_url,
      image_url: "http://localhost:3000/#{screenshot_file}"
    }
  end
end
