import { Hono } from "@hono/hono";
import { serveStatic } from "@hono/hono/deno";
import { Some, None } from "../gleam_stdlib/gleam/option.mjs";

// For Hono
export const createHono = () => new Hono();
export const get = (app, path, handler) => {
  app.get(path, handler);
  return app;
};
export const fetch = (app) => app.fetch.bind(app);

// For Context
export const ctx_text = (ctx, text) => ctx.text(text);
export const ctx_html = (ctx, text) => ctx.html(text);
export const ctx_req = (ctx) => ctx.req;

// For Context.req
export const req_param = (req) => req.param;

// For Deno
export const serve = (handler, port) => {
  if (port instanceof Some) {
    return Deno.serve({ port: port[0] }, handler);
  } else {
    return Deno.serve(handler);
  }
};
