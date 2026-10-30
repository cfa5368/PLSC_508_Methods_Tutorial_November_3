# I render the same route I present: this runs two rank-zero chains.
# It reads the rank-two file already estimated beforehand.
# source("scripts/render_lesson.R")
# lesson_html <- render_lesson()

render_lesson <- function() {
  if (!file.exists("Week11_Dutch_AME_Class.Rmd")) {
    stop("I open W11_Dutch_Classroom.Rproj in the classroom folder first.")
  }
  if (!requireNamespace("rmarkdown", quietly = TRUE)) stop("I install rmarkdown before rendering.")
  if (file.exists("Week11_Dutch_AME_Class.html")) {
    dir.create("outputs/history", recursive = TRUE, showWarnings = FALSE)
    archive <- file.path("outputs/history", paste0("lesson_", format(Sys.time(), "%Y%m%d_%H%M%S"),
                                                 "_", Sys.getpid(), ".html"))
    if (!file.copy("Week11_Dutch_AME_Class.html", archive, overwrite = FALSE)) stop("I could not preserve the previous HTML.")
  }
  cat("I render the classroom route, including two rank-zero fits.\n")
  result <- rmarkdown::render("Week11_Dutch_AME_Class.Rmd",
    output_file = "Week11_Dutch_AME_Class.html",
    envir = new.env(parent = globalenv()), quiet = FALSE)
  cat("DUTCH_CLASSROOM_RENDER_COMPLETE\n", result, "\n")
  invisible(result)
}
