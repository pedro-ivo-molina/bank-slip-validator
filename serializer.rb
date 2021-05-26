class Serializer
  def serialize(header, body, annotations, footer)
    {
      "errors" => {
        "header_errors" => header,
        "body_errors" => body,
        "footer_errors" => footer
      },
      "annotations" => annotations
    }.to_json
  end
end