import { convert_response_body } from "./v1_3_0_ffi.mjs";
import { Request$Request } from "../gleam_http/gleam/http/request.mjs";
import {
  Response$Response$body,
  Response$Response$headers,
  Response$Response$status,
} from "../gleam_http/gleam/http/response.mjs";

export function serve(handler) {
  Deno.serve(async (req) => {
    const resp = await handler(req);

    const status = Response$Response$status(resp);
    const headers = Response$Response$headers(resp);
    const body = Response$Response$body(resp);
    const jsHeader = new Headers();

    // [[a, b]] => new Headers()
    headers.toArray().forEach((ary) => {
      jsHeader.append(ary[0], ary[1]);
    });

    return new Response(convert_response_body(body), {
      status: status,
      headres: jsHeader,
    });
  });
}
