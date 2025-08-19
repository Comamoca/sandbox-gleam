import conversation.{
  type JsRequest, type JsResponse,
}
import gleam/javascript/promise.{type Promise}

pub type Hono

pub type Context
pub type Req

@external(javascript, "./ffi.mjs", "createHono")
pub fn create() -> Hono

@external(javascript, "./ffi.mjs", "get")
pub fn get(
  app: Hono,
  path: String,
  handler: fn(Context) -> Promise(JsResponse),
) -> Hono

// fn hono_get(app: Hono, path: String, handler: fn (Context) -> Promise(Response(ResponseBody))) -> Promise(Response(ResponseBody))

@external(javascript, "./ffi.mjs", "fetch")
pub fn fetch(app: Hono) -> fn(JsRequest) -> Promise(JsResponse)

// @external(javascript, "./ffi.mjs", "wrap")
// pub fn wrap(req: JsRequest, handler: fn (Request(RequestBody)) -> Promise(Response(ResponseBody)))

@external(javascript, "./ffi.mjs", "ctx_text")
pub fn text(ctx: Context, text: String) -> Promise(JsResponse)

@external(javascript, "./ffi.mjs", "ctx_html")
pub fn html(ctx: Context, html: String) -> Promise(JsResponse)

@external(javascript, "./ffi.mjs", "ctx_req")
pub fn req(ctx: Context) -> Req
