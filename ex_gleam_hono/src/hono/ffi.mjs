import { Some, None } from "../../gleam_stdlib/gleam/option.mjs";


// For Context.req
export const req_param = (req, key) => req.param(key)
