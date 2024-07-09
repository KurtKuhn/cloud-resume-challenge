# resource "aws_api_gateway_rest_api" "vistor_counter_api" {
#   name        = "vistorcounter-api"
#   description = "Allows lambda to read/write to dynamoDB"
#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# # Deploy the api endpoint
# resource "aws_api_gateway_deployment" "vistor_counter_api_deploy" {
#   rest_api_id = aws_api_gateway_rest_api.vistor_counter_api.id

#   depends_on = [
#     aws_api_gateway_method.get
#   ]
# }

# resource "aws_api_gateway_resource" "vistor_counter_gateway_resource" {
#   rest_api_id = aws_api_gateway_rest_api.vistor_counter_api.id
#   parent_id   = aws_api_gateway_rest_api.vistor_counter_api.root_resource_id
#   path_part   = "VistorCounter"
# }

# # GET method request
# resource "aws_api_gateway_method" "get" {
#   authorization = "NONE"
#   http_method   = "GET"
#   resource_id   = aws_api_gateway_rest_api.vistor_counter_api.root_resource_id
#   rest_api_id   = aws_api_gateway_rest_api.vistor_counter_api.id
# }

# # needed for the lambda permissions (allows api to invoke our lambda function)
# output "api_gateway_method" {
#   value = aws_api_gateway_method.get.http_method
# }

# # Allow API to call dynamodb table
# resource "aws_api_gateway_integration" "lambda_integration" {
#   integration_http_method = "POST"
#   content_handling        = "CONVERT_TO_TEXT"
#   uri                     = aws_lambda_function.terraform_lambda_func.invoke_arn
#   http_method             = aws_api_gateway_method.get.http_method
#   resource_id             = aws_api_gateway_rest_api.vistor_counter_api.root_resource_id
#   rest_api_id             = aws_api_gateway_rest_api.vistor_counter_api.id
#   type                    = "AWS"

# }

# # GET method "Integration Response"  
# resource "aws_api_gateway_integration_response" "crc_response" {
#   http_method = aws_api_gateway_method.get.http_method # GET
#   resource_id = aws_api_gateway_rest_api.vistor_counter_api.root_resource_id # API resource ID
#   rest_api_id = aws_api_gateway_rest_api.vistor_counter_api.id  # ID of the associated REST API
#   status_code = aws_api_gateway_method_response.response_200.status_code # 200, HTTP status code

#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = "'*'" # restrict origin, * allows anything
#   }

#   response_templates = {
#     "application/json" = ""
#   }

#   depends_on = [
#     aws_api_gateway_integration.lambda_integration
#   ]
# }

# # GET method "Method Response"
# resource "aws_api_gateway_method_response" "response_200" {
#   http_method = aws_api_gateway_method.get.http_method
#   resource_id = aws_api_gateway_rest_api.vistor_counter_api.root_resource_id
#   rest_api_id = aws_api_gateway_rest_api.vistor_counter_api.id
#   status_code = "200"

#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = false
#   }

#   response_models = {
#     "application/json" = "Empty" # response body
#   }

# }

# # needed for the lambda permissions
# output "api_gateway_deployment_arn" {
#   value = aws_api_gateway_deployment.vistor_counter_api_deploy.execution_arn
# }

# resource "aws_api_gateway_stage" "vistor_counter_api_stage_env" {
#   deployment_id = aws_api_gateway_deployment.vistor_counter_api_deploy.id
#   rest_api_id   = aws_api_gateway_deployment.vistor_counter_api_deploy.rest_api_id
#   stage_name    = "stage"
# }

# output "apigateway-url" {
#   value = "$${https://ijfkmwtxhh.execute-api.us-east-1.amazonaws.com/stage.vistor_counter_api.invoke_url}/stage"
# }