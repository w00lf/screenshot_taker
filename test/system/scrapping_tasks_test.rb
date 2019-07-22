require "application_system_test_case"

class ScrappingTasksTest < ApplicationSystemTestCase
  setup do
    @scrapping_task = scrapping_tasks(:one)
  end

  test "visiting the index" do
    visit scrapping_tasks_url
    assert_selector "h1", text: "Scrapping Tasks"
  end

  test "creating a Scrapping task" do
    visit scrapping_tasks_url
    click_on "New Scrapping Task"

    fill_in "Name", with: @scrapping_task.name
    fill_in "Uuid", with: @scrapping_task.uuid
    click_on "Create Scrapping task"

    assert_text "Scrapping task was successfully created"
    click_on "Back"
  end

  test "updating a Scrapping task" do
    visit scrapping_tasks_url
    click_on "Edit", match: :first

    fill_in "Name", with: @scrapping_task.name
    fill_in "Uuid", with: @scrapping_task.uuid
    click_on "Update Scrapping task"

    assert_text "Scrapping task was successfully updated"
    click_on "Back"
  end

  test "destroying a Scrapping task" do
    visit scrapping_tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Scrapping task was successfully destroyed"
  end
end
