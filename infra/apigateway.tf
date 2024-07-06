# Create HTTP API Gateway
resource "aws_apigatewayv2_api" "visitor_counter_api" {
  name          = "visitor_counter_api"
  protocol_type = "HTTP"
  description   = "Visitor counter HTTP API to invoke AWS Lambda function to update & retrieve the visitors count in dynamodb table"
  
  cors_configuration {
      allow_credentials = false
      allow_headers     = []
      allow_methods     = [
          "GET",
          "OPTIONS",
          "POST",
      ]
      allow_origins     = [
          "*",
      ]
      expose_headers    = []
      max_age           = 0
  }

}

# api gateway stage
resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.visitor_counter_api.id
  name        = "default"
  auto_deploy = true
}

# Integrate api-gw with the lambda function
resource "aws_apigatewayv2_integration" "visitor_counter_api_integration" {
  api_id = aws_apigatewayv2_api.visitor_counter_api.id
  integration_uri    = aws_lambda_function.terraform_lambda_func.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

# api gateway route
resource "aws_apigatewayv2_route" "any" {
  api_id = aws_apigatewayv2_api.visitor_counter_api.id
  route_key = "ANY /VisitorCounter"
  target    = "integrations/${aws_apigatewayv2_integration.visitor_counter_api_integration.id}"
}

# Permission for api-gw to execute the lambda function
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.terraform_lambda_func.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.visitor_counter_api.execution_arn}/*/*"
}

output "apigateway-url" {
  value = "${aws_apigatewayv2_stage.default.invoke_url}/VisitorCounter"
}