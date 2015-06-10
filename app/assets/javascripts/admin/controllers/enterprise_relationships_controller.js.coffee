angular.module("ofn.admin").controller "AdminEnterpriseRelationshipsCtrl", ($scope, EnterpriseRelationships, Enterprises) ->
  $scope.EnterpriseRelationships = EnterpriseRelationships
  $scope.Enterprises = Enterprises
  $scope.permissions = {}

  $scope.create = ->
    $scope.EnterpriseRelationships.create($scope.parent_id, $scope.child_id, $scope.permissions)

  $scope.delete = (enterprise_relationship) ->
    if confirm("Are you sure?")
      $scope.EnterpriseRelationships.delete enterprise_relationship

  $scope.allPermissionsChecked = ->
    for i in EnterpriseRelationships.all_permissions
      if !$scope.permissions[i]
        return false
    return true

  $scope.checkAllPermissions = ->
    newValue = !$scope.allPermissionsChecked()
    EnterpriseRelationships.all_permissions.forEach (p) ->
      $scope.permissions[p] = newValue
