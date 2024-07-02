
# Retrieve the current AWS account ID dynamically
data "aws_caller_identity" "current" {}


resource "aws_iam_role" "lambda_execution_role" {
  name               = "cloud_resume_lambda_role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "cloud_resume_lambda_policy"
  description = "AWS IAM Policy for aws lambda to access dynamodb"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Action": [
       "dynamodb:BatchGetItem",
       "dynamodb:GetItem",
       "dynamodb:Query",
       "dynamodb:Scan",
       "dynamodb:BatchWriteItem",
       "dynamodb:PutItem",
       "dynamodb:UpdateItem"
     ],
     "Resource": "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:*" 
   },
   {
     "Effect": "Allow",
     "Action": [
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:*" 
   },
   {
     "Effect": "Allow",
     "Action": "logs:CreateLogGroup",
     "Resource": "*"
   }
 ]
}
EOF
}

# iam role policy attachment to lambda role
resource "aws_iam_role_policy_attachment" "attach_policy_to_lambda_role" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Archive the lambda function python code 
data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/"
  output_path = "${path.module}/lambda/lambda_function.zip"
}

# lambda function creation
resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/lambda/lambda_function.zip"
  function_name = "VistorCounter"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda_handler.lambda_handler"
  runtime       = "python3.12"
  depends_on    = [aws_iam_role_policy_attachment.attach_policy_to_lambda_role]
  timeout       = 30
  environment {
    variables = {
      databaseName = "${aws_dynamodb_table.visitors_ddb.name}"
    }
  }

}