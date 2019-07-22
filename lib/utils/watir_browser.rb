class WatirBrowser
  BROWSER_WIDTHS = (860..1280).step(20).to_a.freeze
  BROWSER_HEIGHTS = (1012..1020).to_a.freeze
  DEFAULT_CHROMEDRIVER_ARGS = ['--headless', '--no-sandbox', '--disable-dev-shm-usage', '--disable-gpu'].freeze
  DEFAULT_PAGE_LOAD_TIMEOUT = 120

  attr_accessor :watir_browser

  def self.browser(with_proxy: true)
    new(with_proxy).watir_browser
  end

  def initialize(with_proxy)
    @with_proxy = with_proxy

    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(capabilities_args)
    driver = Selenium::WebDriver.for(:chrome, desired_capabilities: capabilities)
    @watir_browser = Watir::Browser.new(driver)
    @watir_browser.driver.manage.timeouts.page_load = DEFAULT_PAGE_LOAD_TIMEOUT
    @watir_browser.window.resize_to(BROWSER_HEIGHTS.sample, BROWSER_WIDTHS.sample)
  end

  private

  def capabilities_args
    {
      'chromeOptions' => {
        'args' => chromedriver_args
      }
    }
  end

  def proxy_path
    proxy = 'localhost:8000'
    "#{proxy.http_host}:#{proxy.http_port}"
  end

  def chromedriver_args
    args = DEFAULT_CHROMEDRIVER_ARGS
    args += ["--proxy-server=#{proxy_path}"] if @with_proxy
    args
  end
end
