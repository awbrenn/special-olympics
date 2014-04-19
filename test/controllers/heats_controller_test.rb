require 'test_helper'

class HeatsControllerTest < ActionController::TestCase
  setup do
    @heat = heats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heat" do
    assert_difference('Heat.count') do
      post :create, heat: { event_id: @heat.event_id, gender: @heat.gender, max_age: @heat.max_age, min_age: @heat.min_age, num_heats: @heat.num_heats, time: @heat.time }
    end

    assert_redirected_to heat_path(assigns(:heat))
  end

  test "should show heat" do
    get :show, id: @heat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @heat
    assert_response :success
  end

  test "should update heat" do
    patch :update, id: @heat, heat: { event_id: @heat.event_id, gender: @heat.gender, max_age: @heat.max_age, min_age: @heat.min_age, num_heats: @heat.num_heats, time: @heat.time }
    assert_redirected_to heat_path(assigns(:heat))
  end

  test "should destroy heat" do
    assert_difference('Heat.count', -1) do
      delete :destroy, id: @heat
    end

    assert_redirected_to heats_path
  end
end
