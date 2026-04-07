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


dir.create(".github/workflows", recursive = TRUE, showWarnings = FALSE)

writeLines(
  c(
    'name: Publish Quarto site',
    '',
    'on:',
    '  push:',
    '    branches: ["main"]',
    '  workflow_dispatch:',
    '',
    'permissions:',
    '  contents: read',
    '  pages: write',
    '  id-token: write',
    '',
    'concurrency:',
    '  group: "pages"',
    '  cancel-in-progress: true',
    '',
    'jobs:',
    '  build:',
    '    runs-on: ubuntu-latest',
    '',
    '    steps:',
    '      - name: Checkout',
    '        uses: actions/checkout@v5',
    '',
    '      - name: Configure GitHub Pages',
    '        id: pages',
    '        uses: actions/configure-pages@v5',
    '',
    '      - name: Set up Quarto',
    '        uses: quarto-dev/quarto-actions/setup@v2',
    '',
    '      - name: Set up R',
    '        uses: r-lib/actions/setup-r@v2',
    '',
    '      - name: Restore R packages',
    '        uses: r-lib/actions/setup-renv@v2',
    '',
    '      - name: Render site',
    '        run: quarto render',
    '',
    '      - name: Upload Pages artifact',
    '        uses: actions/upload-pages-artifact@v4',
    '        with:',
    '          path: docs',
    '',
    '  deploy:',
    '    environment:',
    '      name: github-pages',
    '      url: ${{ steps.deployment.outputs.page_url }}',
    '    runs-on: ubuntu-latest',
    '    needs: build',
    '',
    '    steps:',
    '      - name: Deploy to GitHub Pages',
    '        id: deployment',
    '        uses: actions/deploy-pages@v4'
  ),
  ".github/workflows/publish.yml"
)