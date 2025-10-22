import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/javascript/promise.{type Promise}

pub type JsResponse

pub type RequestBody

pub type ResponseBody {
  Text(String)
}

@external(javascript, "./ffi.mjs", "serve")
pub fn serve(
  handler: fn(Request(RequestBody)) -> Promise(Response(ResponseBody)),
) -> Nil

pub fn main() {
  serve(handler)
}

pub fn handler(_req) {
  response.new(200)
  |> response.set_body(Text("Hello"))
  |> response.set_header("test", "test-header")
  |> promise.resolve
}

pub fn convert_response_body(body: ResponseBody) {
  case body {
    Text(body) -> body
  }
}
