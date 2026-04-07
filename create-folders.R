pages <- list(
  "about.qmd" = c(
    "---",
    'title: "About"',
    "---",
    "",
    "# About",
    "",
    "This page will introduce Kris, her background, and her approach."
  ),
  "services.qmd" = c(
    "---",
    'title: "Services"',
    "---",
    "",
    "# Services",
    "",
    "This page will outline the counselling services Kris offers."
  ),
  "how-i-work.qmd" = c(
    "---",
    'title: "How I Work"',
    "---",
    "",
    "# How I Work",
    "",
    "This page will explain the counselling process and what clients can expect."
  ),
  "pricing.qmd" = c(
    "---",
    'title: "Pricing"',
    "---",
    "",
    "# Pricing",
    "",
    "This page will describe session fees and payment information."
  ),
  "blog.qmd" = c(
    "---",
    'title: "Blog"',
    "---",
    "",
    "# Blog",
    "",
    "Articles and reflections will go here."
  ),
  "contact.qmd" = c(
    "---",
    'title: "Contact"',
    "---",
    "",
    "# Contact",
    "",
    "This page will include contact details and next steps."
  )
)

for (f in names(pages)) {
  writeLines(pages[[f]], f)
  message("Wrote file: ", f)
}

if (file.exists("compassionate-pathways.qmd") && !file.exists("index.qmd")) {
  file.rename("compassionate-pathways.qmd", "index.qmd")
}

writeLines(c(
  "---",
  'title: "Compassionate Pathways"',
  "---",
  "",
  "# Welcome",
  "",
  "A calm, compassionate space to support healing, growth, and wellbeing."
), "index.qmd")