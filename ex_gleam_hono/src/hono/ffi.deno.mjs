import { serveStatic } from "jsr:@hono/hono/deno";

export const serve_static = (root) => {
  return serveStatic({ root: root })
}

export const use_static = (app, path, root) => {
  app.use(path + "*", serveStatic({ root: root }));
  return app;
};
