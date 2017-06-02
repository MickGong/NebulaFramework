/*************************************************************************************************
* This file is part of the Nebula Framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/jongpie/NebulaFramework for full license details. *
*************************************************************************************************/
public without sharing class SObjectTypeDescriber {

    public Schema.SObjectType SObjectType {get; private set;}

    public SObjectTypeDescriber(Id recordId) {
        this(recordId.getSObjectType());
    }

    public SObjectTypeDescriber(SObject record) {
        this(record.getSObjectType());
    }

    public SObjectTypeDescriber(Schema.SObjectType sobjectType) {
        this.SObjectType = sobjectType;
    }

    public String getChildRelationshipName(Schema.SObjectField childSObjectField) {
        Schema.SObjectType parentSObjectType = new SObjectFieldDescriber(childSObjectField).getParentSObjectType();
        Schema.ChildRelationship childRelationship = this.getSObjectTypeChildRelationshipMap(parentSObjectType).get(childSObjectField);

        return childRelationship.getRelationshipName();
    }

    public Boolean validateSObjectFieldExists(Schema.SObjectField expectedSObjectField) {
        SObjectFieldDescriber sobjectFieldDescriber = new SObjectFieldDescriber(expectedSObjectField);
        Map<String, Schema.SObjectField> fieldMap = this.SObjectType.getDescribe().fields.getMap();

        Boolean sobjectTypesMatch            = sobjectFieldDescriber.validateSObjectType(this.SObjectType);
        Boolean sobjectTypesHasMatchingField = fieldMap.containsKey(sobjectFieldDescriber.getFieldName());

        return sobjectTypesMatch && sobjectTypesHasMatchingField;
    }

    private Map<Schema.SObjectField, Schema.ChildRelationship> getSObjectTypeChildRelationshipMap(Schema.SObjectType parentSObjectType) {
        Map<Schema.SObjectField, Schema.ChildRelationship> childRelationshipMap = new Map<Schema.SObjectField, Schema.ChildRelationship>();

        for(Schema.ChildRelationship childRelationship : parentSObjectType.getDescribe().getChildRelationships()) {
            if(childRelationship.getRelationshipName() == null) continue;

            childRelationshipMap.put(childRelationship.getField(), childRelationship);
        }

        return childRelationshipMap;
    }

}