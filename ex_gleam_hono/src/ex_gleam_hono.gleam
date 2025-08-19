import deno
import hono.{fetch}
import gleam/option.{None}
import hono/deno as hono_deno
import hono/req

pub fn main() {
  let app = hono.create()

  let app =
    app
    |> hono_deno.use_static("/", "./priv/")
    |> hono.get("/greet/:name", fn (c) {
        let name = c |> hono.req |> req.param("name")
        hono.text(c, "Hello! " <> name <> " !")
      })

  let handler = fetch(app)
  deno.serve(handler, None)
}
