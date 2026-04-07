repo_dir <- "C:/Users/mla210/Github/compassionate-pathways"
owner <- "MarkLaVenia"
repo <- "compassionate-pathways"

run <- function(...) {
  cmd <- paste(...)
  cat("\n>", cmd, "\n")
  status <- system(cmd)
  if (!identical(status, 0L)) {
    stop("Command failed: ", cmd, call. = FALSE)
  }
}

setwd(repo_dir)

# 1) Authenticate once if needed (interactive)
run("gh auth login")

# 2) Commit files
run("git add .")
run('git commit -m "Initial Quarto website"')

# 3) Create the remote repo and push
run(
  sprintf(
    "gh repo create %s/%s --public --source=. --remote=origin --push",
    owner, repo
  )
)

# 4) Detect branch
branch <- system("git branch --show-current", intern = TRUE)
branch <- trimws(branch)

# 5) Enable GitHub Pages from /docs
run(
  sprintf(
    'gh api --method POST -H "Accept: application/vnd.github+json" /repos/%s/%s/pages -f source[branch]="%s" -f source[path]="/docs"',
    owner, repo, branch
  )
)

# 6) Show Pages info
run(sprintf("gh api /repos/%s/%s/pages", owner, repo))