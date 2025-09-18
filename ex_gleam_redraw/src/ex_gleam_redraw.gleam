import gleam/int
import redraw as react
import redraw/dom/attribute as a
import redraw/dom/client
import redraw/dom/events
import redraw/dom/html

pub type Root

pub type Node(props)

pub type Children

pub fn main() {
  let root = root()
  let assert Ok(node) = client.create_root("root")
  client.render(node, react.strict_mode([root()]))
}

pub fn root() {
  let app = app()
  use <- react.standalone("Root")
  app()
}

pub fn app() {
  let counter = counter()
  use <- react.standalone("App")

  react.fragment([
    html.div([a.class("h-screen w-screen flex justify-center items-center")], [
      html.div([a.class("shadow-xl rounded-md bg-slate-100")], [
        counter(Nil),
      ]),
    ]),
  ])
}

fn counter() {
  use _ <- react.element("Counter")

  let #(count, set_count) = react.use_state(0)

  react.fragment([
    html.div([a.class("flex flex-col p-8")], [
      html.p([a.class("mx-auto text-2xl pb-5")], [
        html.text(int.to_string(count)),
      ]),
      html.div([a.class("flex justify-center")], [
        html.button(
          [
            a.class("btn btn-lg mx-3"),
            events.on_click(fn(_) { set_count(count + 1) }),
          ],
          [html.text("+")],
        ),
        html.button(
          [
            a.class("btn btn-lg mx-3"),
            events.on_click(fn(_) { set_count(count - 1) }),
          ],
          [html.text("-")],
        ),
      ]),
      hello(),
    ]),
  ])
}

@external(javascript, "../../../../src/hello.jsx", "Hello")
fn hello() -> react.Component
