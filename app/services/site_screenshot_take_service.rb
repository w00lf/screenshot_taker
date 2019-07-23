require 'utils/watir_browser'

class SiteScreenshotTakeService
  DEFAULT_TIMEOUT = 5

  def self.call(url:, field_to_fill:, info_to_fill:, autocomlite_selector:, button_submit:, concess_accept:, headless: true)
    browser = WatirBrowser.new(headless: headless).watir_browser
    browser.goto(url)
    browser.element(css: concess_accept).wait_until(timeout: DEFAULT_TIMEOUT, &:enabled?).click() if concess_accept
    browser.text_field(css: field_to_fill).wait_until(&:present?).set(info_to_fill)
    2.times do
      browser.element(css: autocomlite_selector).wait_until(timeout: DEFAULT_TIMEOUT, &:present?).click() rescue print('Cannot click second time on elem, skipping')
    end
    browser.element(css: button_submit).wait_until(timeout: DEFAULT_TIMEOUT, &:present?).click() if button_submit
    sleep(DEFAULT_TIMEOUT)
    screenshot_location = Rails.root.join('public', 'crawl_results')
    screenshot_file = "site_image_#{SecureRandom.uuid}.png"
    browser.screenshot.save(File.join(screenshot_location, screenshot_file))
    last_url = browser.url
    browser.close()
    {
      url: last_url,
      image_url: "http://#{Settings.this.host}/crawl_results/#{screenshot_file}"
    }
  end
end
