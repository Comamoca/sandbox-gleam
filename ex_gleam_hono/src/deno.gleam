import conversation.{type JsRequest, type JsResponse}
import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option}

@external(javascript, "./ffi.mjs", "serve")
pub fn serve(handler: fn(JsRequest) -> Promise(JsResponse), port: Option(Int)) -> Nil
