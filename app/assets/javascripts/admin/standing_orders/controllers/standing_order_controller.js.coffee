angular.module("admin.standingOrders").controller "StandingOrderController", ($scope, StatusMessage, StandingOrder, customers, schedules, paymentMethods, shippingMethods) ->
  $scope.standingOrder = StandingOrder.standingOrder
  $scope.customers = customers
  $scope.schedules = schedules
  $scope.paymentMethods = paymentMethods
  $scope.shippingMethods = shippingMethods
  $scope.errors = StandingOrder.errors
  $scope.newItem = { variant_id: 0, quantity: 1 }
  $scope.distributor_id = $scope.standingOrder.shop_id # variant selector requires distributor_id
  $scope.view = if $scope.standingOrder.id? then 'review' else 'details'
  $scope.stepTitles = { details: '1. Basic Details', products: '2. Add Products', review: '3. Review & Finalise' }

  $scope.save = ->
    $scope.standing_order_form.$setPristine()
    StandingOrder.save()

  $scope.setView = (view) -> $scope.view = view

  $scope.addStandingLineItem = ->
    StandingOrder.buildItem($scope.newItem)

  $scope.estimatedSubtotal = ->
    $scope.standingOrder.standing_line_items.reduce (subtotal, item) ->
      item.price_estimate * item.quantity
    , 0

  $scope.estimatedTotal = ->
    $scope.estimatedSubtotal()