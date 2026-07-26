const assert = require("node:assert");
const test = require("node:test");
const { slugify } = require("./slugify");

test("lowercases and hyphenates", () => {
  assert.strictEqual(slugify("Hello World"), "hello-world");
});
