function slugify(title) {
  return title.toLowerCase().replace(/ /g, "-");
}

module.exports = { slugify };
