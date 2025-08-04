import conversation.{type RequestBody, type ResponseBody}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/list
import gleam/string
import helper.{html_body, response_with_html}
import lustre/element.{text}
import lustre/element/html

const routers = ["greet/name"]

pub fn handler(req: Request(RequestBody)) -> Response(ResponseBody) {
  case request.path_segments(req) {
    [] -> {
      let body =
        html_body([], [
          html.h1([], [text("Hello!")]),
          html.p([], [html.text(" This server supported below routes. ")]),
          html.ul([], [
            html.li([], list.map(routers, fn(route) { html.text(route) })),
          ]),
          html.p([], []),
        ])
      response_with_html(200, body)
    }
    ["greet", name] ->
      response_with_html(
        200,
        html_body([], [
          html.h1([], [text(string.join(["Hello", name <> "!"], " "))]),
        ]),
      )
    _ -> response_with_html(404, html_body([], [html.h1([], [text("404")])]))
  }
}
