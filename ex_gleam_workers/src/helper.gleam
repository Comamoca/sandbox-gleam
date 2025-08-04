import conversation.{type ResponseBody, Text}
import gleam/http/response.{type Response}
import gleam/list
import lustre/attribute
import lustre/element
import lustre/element/html.{html}

pub fn response_with_html(
  status: Int,
  html_text: String,
) -> Response(ResponseBody) {
  response.new(status)
  |> response.set_header("content-type", "text/html")
  |> response.set_body(Text(html_text))
}

pub fn html_body(attr, inner) -> String {
  html(list.append(attr, [attribute.lang("ja")]), [html.body(attr, inner)])
  |> element.to_document_string
}
