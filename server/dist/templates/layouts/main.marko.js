function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXml = __helpers.x,
      attr = __helpers.a;

  return function render(data, out) {
    out.w("<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\"><meta name=\"theme-color\" content=\"#cba\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><meta http-equiv=\"Accept-CH\" content=\"DPR, Viewport-Width, Width\"><title data-suffix=\" — colinaarts.com\" data-base=\"colinaarts.com\">colinaarts.com</title>");

    if (process.env.NODE_ENV === "production") {
      out.w("<script src=\"/app.js\"></script>");
    } else {
      out.w("<script src=\"https://localhost:8080/app.js\"></script>");
    }

    out.w("<script src=\"//colinaarts-com.disqus.com/embed.js\"" +
      attr("data-timestamp", Date.now()) +
      " async></script></head></html>");
  };
}

(module.exports = require("marko").c(__filename)).c(create);
