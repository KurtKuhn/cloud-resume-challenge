resource "aws_dynamodb_table" "visitors_ddb" {
  name         = "VistorsCount"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  } 

  attribute {
    name = "visitors"
    type = "N"
  }

  attribute {
    name = "blog_visitors"
    type = "N"
  }

  attribute {
    name = "resume_visitors"
    type = "N"
  }

  global_secondary_index {
    name            = "visitors_count"
    hash_key        = "visitors"
    projection_type = "ALL"
    read_capacity   = 1
    write_capacity  = 1
    
  }

  global_secondary_index {
    name            = "resume_visitors_count"
    hash_key        = "resume_visitors"
    projection_type = "ALL"
    read_capacity   = 1
    write_capacity  = 1
  }

  global_secondary_index {
    name            = "blog_visitors_count"
    hash_key        = "blog_visitors"
    projection_type = "ALL"
    read_capacity   = 1
    write_capacity  = 1
  }

  server_side_encryption {
    enabled = true
  }
}

# Used for the placing for the first vistor
resource "aws_dynamodb_table_item" "vistor_place_item" {
  table_name = aws_dynamodb_table.visitors_ddb.name
  hash_key   = aws_dynamodb_table.visitors_ddb.hash_key

  item = <<ITEM
{
  "id": {"S": "visitor_count"},
  "visitors": {"N": "0"}
}
ITEM
}

resource "aws_dynamodb_table_item" "resume_item" {
  table_name = aws_dynamodb_table.visitors_ddb.name
  hash_key   = aws_dynamodb_table.visitors_ddb.hash_key

  item = <<ITEM
{
  "id": {"S": "resume_visitor_count"},
  "visitors": {"N": "0"}
}
ITEM
}

resource "aws_dynamodb_table_item" "blog_resume_item" {
  table_name = aws_dynamodb_table.visitors_ddb.name
  hash_key   = aws_dynamodb_table.visitors_ddb.hash_key

  item = <<ITEM
{
  "id": {"S": "blog_visitor_count"},
  "visitors": {"N": "0"}
}
ITEM
}