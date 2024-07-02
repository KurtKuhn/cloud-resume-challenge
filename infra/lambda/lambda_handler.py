import boto3
import json
import os

dynamodb_client = boto3.resource('dynamodb')
table_name = os.getenv('databaseName')
table = dynamodb_client.Table(table_name)

def lambda_handler(event, context):
    try:
        dynamodbResponse = table.update_item(
                Key={
                    'id': 'visitor_count'
                },
                UpdateExpression='SET visitors = visitors + :increment',
                ExpressionAttributeValues={
                    ':increment': 1
                },
                ReturnValues='UPDATED_NEW'
            )
            
        responseBody = json.dumps({"count":int(dynamodbResponse['Attributes']['visitors'])})

    except:
        putItem = table.put_item(
            Item = {
                'id': 'visitor_count',
                'visitors': 1
            }
        )

        dynamodbResponse = table.get_item(
            Key = {
                'id': 'visitor_count',
            }
        )

        responseBody = json.dumps({"count":int(dynamodbResponse['Item']['visitors'])})

    apiResponse = {
        "isBase64Encoded": False,
        "statusCode": 200,
        'headers': {
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        "body": responseBody
    }

    return apiResponse