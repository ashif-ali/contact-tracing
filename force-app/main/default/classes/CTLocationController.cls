public with sharing class CTLocationController {
  public static List<Location__c> getRecentStatusChanges() {
    return [
      SELECT
        Id,
        Name,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      ORDER BY Status_Update_Date__c DESC NULLS LAST
      LIMIT 100
    ];
  }

  public static List<Location__c> searchLocation(String location) {
    location = location + '%';
    return [
      SELECT
        Id,
        IsDeleted,
        Name,
        LastViewedDate,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      WHERE
        Name LIKE :location
        OR Pincode__c LIKE :location
        OR Address__c LIKE :location
      ORDER BY Status_Update_Date__c DESC NULLS LAST
    ];
  }
  public static Location__c getLocationById(String locationId) {
    List<Location__c> locations = [
      SELECT
        Id,
        IsDeleted,
        Name,
        LastViewedDate,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      WHERE Id = :locationId
    ];
    if (locations != null && locations.size() > 0) {
      return locations[0];
    }
    return null;
  }
}