import conversation.{type JsRequest, type JsResponse}
import handler.{handler}

pub fn handle_request(req: JsRequest) -> JsResponse {
  req
  |> conversation.to_gleam_request
  |> handler()
  |> conversation.to_js_response
}
