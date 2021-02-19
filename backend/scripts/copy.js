var copy = require("recursive-copy");
copy("src/email/templates", "dist/email/templates").catch((e) => {
  throw e;
});
