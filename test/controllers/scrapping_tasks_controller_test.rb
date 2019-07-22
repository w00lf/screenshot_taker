require 'test_helper'

class ScrappingTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scrapping_task = scrapping_tasks(:one)
  end

  test "should get index" do
    get scrapping_tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_scrapping_task_url
    assert_response :success
  end

  test "should create scrapping_task" do
    assert_difference('ScrappingTask.count') do
      post scrapping_tasks_url, params: { scrapping_task: { name: @scrapping_task.name, uuid: @scrapping_task.uuid } }
    end

    assert_redirected_to scrapping_task_url(ScrappingTask.last)
  end

  test "should show scrapping_task" do
    get scrapping_task_url(@scrapping_task)
    assert_response :success
  end

  test "should get edit" do
    get edit_scrapping_task_url(@scrapping_task)
    assert_response :success
  end

  test "should update scrapping_task" do
    patch scrapping_task_url(@scrapping_task), params: { scrapping_task: { name: @scrapping_task.name, uuid: @scrapping_task.uuid } }
    assert_redirected_to scrapping_task_url(@scrapping_task)
  end

  test "should destroy scrapping_task" do
    assert_difference('ScrappingTask.count', -1) do
      delete scrapping_task_url(@scrapping_task)
    end

    assert_redirected_to scrapping_tasks_url
  end
end
