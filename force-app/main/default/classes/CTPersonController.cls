public with sharing class CTPersonController {
  public static String getToken(String mobileNo) {
    Blob targetBlob = Blob.valueOf(mobileNo);
    Blob hash = Crypto.generateDigest('MD5', targetBlob);
    return EncodingUtil.base64Encode(hash);
  }

  public static List<Person__c> getRecentHealthChanges() {
    List<Person__c> personList = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      ORDER BY Status_Update_Date__c DESC NULLS LAST
      LIMIT 100
    ];
    return personList;
  }

  public static List<Person__c> searchPeople(String searchTerm) {
    searchTerm = searchTerm + '%';
    return [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE
        Name LIKE :searchTerm
        OR Mobile__c LIKE :searchTerm
        OR Token__c LIKE :searchTerm
      ORDER BY Status_Update_Date__c DESC
    ];
  }

  public static List<Person__c> getPersonById(String personId) {
    List<Person__c> people = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE Id = :personId
    ];
    if (people != null && people.size() > 0) {
      return people[0];
    }
    return null;
  }
}
