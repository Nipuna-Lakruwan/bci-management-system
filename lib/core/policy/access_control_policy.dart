/// Abstract policy defining what features a role can access.
/// This follows the Open/Closed Principle (OCP) since we can add new policies
/// without modifying the Dashboard screen.
abstract class AccessControlPolicy {
  bool get canViewHumanResources;
}

class AdminAccessPolicy implements AccessControlPolicy {
  @override
  bool get canViewHumanResources => true;
}

class HrAccessPolicy implements AccessControlPolicy {
  @override
  bool get canViewHumanResources => true;
}

class GuestAccessPolicy implements AccessControlPolicy {
  @override
  bool get canViewHumanResources => false;
}

/// Factory to get the policy for a given role.
class AccessControlFactory {
  static AccessControlPolicy getPolicy(String role) {
    switch (role) {
      case 'Admin':
        return AdminAccessPolicy();
      case 'HR':
        return HrAccessPolicy();
      default:
        return GuestAccessPolicy();
    }
  }
}
