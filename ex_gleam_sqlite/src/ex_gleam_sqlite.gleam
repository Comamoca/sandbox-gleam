import birl
import dateformat
import db/sql
import fabulous
import gleam/list
import gleam/result
import parrot/dev
import sqlight

pub type Todo {
  Todo(id: Int, title: String, status: String, created_at: String)
}

pub fn main() {
  use on <- sqlight.with_connection("./db/todos.db")

  let table =
    fabulous.Table([], [], 30, "LEFT", "LEFT")
    |> fabulous.add_col("Task")
    |> fabulous.add_col("Status")
    |> fabulous.add_col("Crated At")

  let assert Ok(items) = get_all_todo(on)

  list.fold(items, table, fn(table, item) {
    let assert Ok(time) = birl.parse(item.created_at)
    let assert Ok(yymmdd) = dateformat.format("YYYY/MM/DD", time)
    fabulous.add_row(table, [item.title, item.status, yymmdd])
  })
  |> fabulous.make_table
}

fn get_all_todo(on: sqlight.Connection) {
  let #(sql, with, expecting) = sql.list_todos()
  let with = list.map(with, parrot_to_sqlight)
  use items <- result.try(sqlight.query(sql, on:, with:, expecting:))
  Ok(items)
}

// fn get_todo_item_sample() {
// let id = 1
// let assert Ok(item) = get_todo(on, id)

// let assert Ok(time) = birl.parse(item.created_at)
// let assert Ok(yymmdd) = dateformat.format("YYYY/MM/DD", time)

// io.println(
//   ["Task: ", item.title, " | ", item.status, " | ", yymmdd]
//   |> string.concat,
// )
// }

// fn get_todo(on: sqlight.Connection, id: Int) {
//   let to_error = fn(res: Result(a, b)) -> Result(a, String) {
//     result.replace_error(res, "Value Error")
//   }

//   let #(sql, with, expecting) = sql.get_todo(id)
//   let with = list.map(with, parrot_to_sqlight)

//   use item <- result.try(sqlight.query(sql, on:, with:, expecting:) |> to_error)
//   use item <- result.try(list.first(item) |> to_error)
//   Ok(item)
// }

fn parrot_to_sqlight(param: dev.Param) -> sqlight.Value {
  case param {
    dev.ParamBool(x) -> sqlight.bool(x)
    dev.ParamFloat(x) -> sqlight.float(x)
    dev.ParamInt(x) -> sqlight.int(x)
    dev.ParamString(x) -> sqlight.text(x)
    dev.ParamBitArray(x) -> sqlight.blob(x)
    dev.ParamNullable(x) -> sqlight.nullable(fn(a) { parrot_to_sqlight(a) }, x)
    dev.ParamList(_) -> panic as "sqlite does not implement lists"
    dev.ParamDate(_) -> panic as "date parameter needs to be implemented"
    dev.ParamTimestamp(_) -> panic as "sqlite does not support timestamps"
    dev.ParamDynamic(_) -> panic as "cannot process dynamic parameter"
  }
}
