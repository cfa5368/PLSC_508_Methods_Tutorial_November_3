# I reproduce the two rank-two fits outside the classroom session.
# I open the classroom project before calling this function.
# source("scripts/estimate_rank2_before_class.R")
# r2_path <- estimate_rank2_before_class()
# This function performs long estimation. The tutorial itself only reads the
# previously estimated file in data/rank2_preestimated.rds.

estimate_rank2_before_class <- function() {
  if (!requireNamespace("amen", quietly = TRUE)) stop("I install amen before running this script.")
  inputs <- readRDS("data/input_reference.rds")
  seeds <- c(50836301L, 50836302L)
  RNGkind("Mersenne-Twister", "Inversion", "Rejection")
  fits <- vector("list", 2L)
  elapsed <- numeric(2L)
  for (j in seq_along(seeds)) {
    cat("I estimate rank-two chain", j, "with seed", seeds[j], "\n")
    elapsed[j] <- system.time({
      fits[[j]] <- amen::ame(
        Y = inputs$Y, Xdyad = inputs$Xdyad, Xrow = NULL, Xcol = NULL,
        family = "bin", R = 2, rvar = TRUE, cvar = TRUE, dcor = TRUE,
        intercept = TRUE, symmetric = FALSE, prior = list(),
        seed = seeds[j], burn = 10000, nscan = 200000, odens = 25,
        plot = FALSE, print = FALSE, gof = TRUE
      )
    })[["elapsed"]]
  }
  out <- file.path("outputs", paste0("rank2_reproduction_", format(Sys.time(), "%Y%m%d_%H%M%S"),
                                    "_", Sys.getpid(), ".rds"))
  dir.create("outputs", showWarnings = FALSE)
  saveRDS(list(fits = fits, inputs = inputs, seeds = seeds, elapsed_seconds = elapsed,
               software = list(R = R.version.string, amen = as.character(packageVersion("amen"))),
               description = "Two rank-two chains re-estimated outside class"), out)
  cat("I saved:", out, "\nI inspect these fits before replacing any designated classroom file.\n")
  invisible(out)
}
