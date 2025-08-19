import hono.{type Req}

@external(javascript, "./ffi.mjs", "req_param")
pub fn param(req: Req, key: String) -> String
