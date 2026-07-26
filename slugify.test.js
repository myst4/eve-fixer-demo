const assert = require("node:assert");
const test = require("node:test");
const { slugify } = require("./slugify");

test("lowercases and hyphenates", () => {
  assert.strictEqual(slugify("Hello World"), "hello-world");
});

test("strips punctuation and collapses separators", () => {
  assert.strictEqual(slugify("Hello,  World!"), "hello-world");
});

test("trims leading and trailing hyphens", () => {
  assert.strictEqual(slugify("--Hello World--"), "hello-world");
});
