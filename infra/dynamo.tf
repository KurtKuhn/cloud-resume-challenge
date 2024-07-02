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

  server_side_encryption {
    enabled = true
  }

  global_secondary_index {
    name            = "visitors_count"
    hash_key        = "visitors"
    projection_type = "ALL"
    read_capacity   = 1
    write_capacity  = 1
  }

}

# Used for the placing for the first vistor
resource "aws_dynamodb_table_item" "visitor_ddb_place_item" {
  table_name = aws_dynamodb_table.visitors_ddb.name
  hash_key   = aws_dynamodb_table.visitors_ddb.hash_key

  item = <<ITEM
{
  "id": {"S": "visitor_count"},
  "visitors": {"N": "0"}
}
ITEM
}