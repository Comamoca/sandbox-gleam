import { handle_request } from "./ex_gleam_workers.mjs";

export default {
  async fetch(request) {
    return handle_request(request);
  },
};
