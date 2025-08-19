import hono.{type Hono}

@external(javascript, "./ffi.deno.mjs", "use_static")
pub fn use_static(app: Hono, path: String, root: String) -> Hono
