/**
*
* @group Query Builder
* @group-content /ApexDocContent/QueryBuilder.html
*
* @description TODO
*
*/
public interface ISObjectQueryBuilder {


        // TODO create diagram to show the pieces needed for using query Builder
        //      1. set sobject Type
        //      2. add some fields
        //      3. Optional: filters
        //      4. Optional: order by
        //      5. Optional: limitCount, setAsUpdate & usingScope methods
        //      6. Get results: getQueryResults, getFirstQueryResult, getSearchResults
        //      7. Optional: getQuery to get the dynamically generated query string


//TODO new should be inhertied from QueryBuilder problably maybe idk
// SUBSELECT AND Id IN (SELECT Speaker_AGN__c FROM Speaker_Recent_Search_AGN__c WHERE User_AGN__c = :UserInfo.getUserId())];
// inSubSelect(Schema.SObjectField) // use describer classes to determine sobject type
// inSubSelect(Schema.SObjectField, List<IQueryFilter> subselectFilters) //optional query filters
// notInSubSelect(Schema.SObjectField) // NOT
// notInSubSelect(Schema.SObjectField, List<IQueryFilter> subselectFilters) // NOT
    // Setter methods
    ISObjectQueryBuilder setSObjectType(Schema.SObjectType sobjectType);

    // Field methods
    ISObjectQueryBuilder addAllFields();
    ISObjectQueryBuilder addAllStandardFields();
    ISObjectQueryBuilder addAllCustomFields();
    ISObjectQueryBuilder addAllReadableFields();
    ISObjectQueryBuilder addAllEditableFields();
    ISObjectQueryBuilder addFields(Schema.FieldSet fieldSet);
    ISObjectQueryBuilder addFields(List<Schema.SObjectField> fields);

    // Filter methods
    ISObjectQueryBuilder filterBy(IQueryFilter queryFilter);
    ISObjectQueryBuilder filterBy(List<IQueryFilter> queryFilters);
    ISObjectQueryBuilder andFilterBy(List<IQueryFilter> queryFilters);
    ISObjectQueryBuilder orFilterBy(List<IQueryFilter> queryFilters);

    ISObjectQueryBuilder inSubquery(Schema.SObjectField sobjectFieldToFilter, Schema.SObjectField lookupFieldOnRelatedSObject);
    ISObjectQueryBuilder notInSubquery(Schema.SObjectField sobjectFieldToFilter, Schema.SObjectField lookupFieldOnRelatedSObject);

// TODO stop using ISObjectRepository as a parameter
    ISObjectQueryBuilder includeChildrenRecords(Schema.SObjectField childToParentRelationshipField, List<Schema.SObjectField> fields, List<IQueryFilter> filters);
    // ISObjectQueryBuilder includeChildrenRecords(Schema.SObjectField childToParentRelationshipField, ISObjectRepository childSObjectRepository);
    // ISObjectQueryBuilder includeChildrenRecords(Map<Schema.SObjectField, ISObjectRepository> childFieldToChildSObjectRepositoryrMap);

    // Order By methods
    ISObjectQueryBuilder orderBy(Schema.SObjectField orderByField);
    ISObjectQueryBuilder orderBy(Schema.SObjectField orderByField, QuerySortOrder sortOrder);
    ISObjectQueryBuilder orderBy(Schema.SObjectField orderByField, QuerySortOrder sortOrder, QueryNullSortOrder nullsSortOrder);

    // Additional query option methods
    ISObjectQueryBuilder limitCount(Integer limitCount);
    ISObjectQueryBuilder setAsUpdate();
    ISObjectQueryBuilder usingScope(QueryFilterScope filterScope);

    // Query execution methods
    SObject getFirstQueryResult();
    List<SObject> getQueryResults();
    List<SObject> getSearchResults(String searchTerm, QuerySearchGroup searchGroup);

    // Get the dyanmic query strings
    String getQuery();
    // TODO I think I now hate this method
    //String getQuery(Schema.SObjectField sobjectField);

}