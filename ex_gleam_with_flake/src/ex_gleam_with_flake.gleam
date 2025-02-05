import gleam/io
import effect.{type Effect}

pub fn main() {
  let println: Effect(Nil) = {
    io.println("Hello from ex_gleam_tmp!")
    |> effect.dispatch
  }

  use _ <- effect.perform(println)
  Nil
}
