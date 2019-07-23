require 'utils/watir_browser'

class ScrapeProviderSitesJob < ApplicationJob
  queue_as :default
  DOMAINS_TO_CHECK = {
    'https://stofa.dk/bredbaand#/address' => { field_to_fill: '#dawa-autocomplete-input', autocomlite_selector: '.autocomplete-container ul li' },
    'https://yousee.dk/bredbaand/overblik.aspx#bredbaand' => { field_to_fill: '[placeholder="Indtast dit vejnavn og husnr."]', autocomlite_selector: 'ul.autocomplete__list li' },
    'https://www.hiper.dk' => { field_to_fill: '#address-field', autocomlite_selector: 'ul#address-list li', button_submit: '#continue-button' },
    'https://fastspeed.dk' => { field_to_fill: '#input_1_1', autocomlite_selector: 'ul#ui-id-1 li', button_submit: '#gform_submit_button_1' },
    'https://www.fullrate.dk/privat/bredbaand' => {
      field_to_fill: '.addresscheck__main .addresscheck-field__input',
      autocomlite_selector: '.addresscheck-field__search-list .addresscheck-field__search-line',
      concess_accept: '.cookiepopup__area a'
    },
    'https://www.waoo.dk' => {
      field_to_fill: '#js-adv-widget',
      autocomlite_selector: '.auto-complete li',
      button_submit: '.auto-complete__button'
    }
  }

  def perform(scrapping_task_id)
    scrapping_task = ScrappingTask.find(scrapping_task_id)
    DOMAINS_TO_CHECK.each do |(url, attributes)|
      ActionCable.server.broadcast "scrapping_task_#{scrapping_task.uuid}", status_message: "Parsing: #{url}..."
      results = SiteScreenshotTakeService.call(
                  url: url,
                  info_to_fill: scrapping_task.name,
                  field_to_fill: attributes[:field_to_fill],
                  autocomlite_selector: attributes[:autocomlite_selector],
                  button_submit: attributes[:button_submit],
                  concess_accept: attributes[:concess_accept],
                  headless: true) rescue {}
      ActionCable.server.broadcast "scrapping_task_#{scrapping_task.uuid}", image_url: results[:image_url], url: results[:url]
      ActionCable.server.broadcast "scrapping_task_#{scrapping_task.uuid}", status_message: "Done: #{url}."
    end
    ActionCable.server.broadcast "scrapping_task_#{scrapping_task.uuid}", status_message: "All done!"
  end
end
