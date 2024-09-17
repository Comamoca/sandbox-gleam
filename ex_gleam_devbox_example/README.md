<!-- gen-readme start - generated by https://github.com/jetify-com/devbox/ -->
## Getting Started
This project uses [devbox](https://github.com/jetify-com/devbox) to manage its development environment.

Install devbox:
```sh
curl -fsSL https://get.jetpack.io/devbox | bash
```

Start the devbox shell:
```sh 
devbox shell
```

Run a script in the devbox environment:
```sh
devbox run <script>
```
## Scripts
Scripts are custom commands that can be run using this project's environment. This project has the following scripts:

* [dev](#devbox-run-dev)
* [test](#devbox-run-test)

## Shell Init Hook
The Shell Init Hook is a script that runs whenever the devbox environment is instantiated. It runs 
on `devbox shell` and on `devbox run`.
```sh
gleam deps download
```

## Packages

* [gleam@latest](https://www.nixhub.io/packages/gleam)
* [erlang@latest](https://www.nixhub.io/packages/erlang)

## Script Details

### devbox run dev
```sh
gleam run
```
&ensp;

### devbox run test
```sh
echo "Error: no test specified" && exit 1
```
&ensp;



<!-- gen-readme end -->