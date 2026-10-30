# Understanding classroom relationships with network models

I use this tutorial to explore a simple question: when students nominate
classmates they like, how much of the pattern is associated with measured
similarities, and what remains beyond those similarities?

I compare two network models using liking nominations from sixteen students
in one Dutch classroom. Both models account for differences in students'
tendencies to send and receive nominations and for the relationship between
the two directions of a pair. The second model adds a flexible representation
of who connects to whom. Comparing them helps me show why relationships cannot
always be understood as separate, unrelated observations.

The lesson moves from the original nomination records to a network picture,
descriptive statistics, model estimates, and checks of what the models reproduce.
I distinguish these associations from evidence that liking causes support,
cooperation, or other benefits.

This is my November 3, 2026 Methods Tutorial for PLSC 508 at Penn State,
using data from van den Bos et al. (2018).

## For classmates
Hello! 🙂
1. Download and extract the complete folder to a short path. Open the `.Rproj`
   in the folder that directly contains this README, the Rmd, data, and scripts.
2. Check the listed packages before class and install only those that are missing.
   Don’t update an already working installation just to match a version number.
3. In Source view, run chunks from the top. The two live rank-zero calls together
   took about 3.6 minutes in the recorded October 29 session. Other machines may
   take longer; RStudio remains busy while a call is running.
4. Keep supplied inputs and the manifest unchanged. If setup reports a mismatch,
   check the project root and restore an untouched copy rather than edit hashes.
5. Rank-two fits are loaded from the supplied file. Do not run the separate
   rank-two reproduction function during class. Recovery fits are used only if
   the presenter explicitly announces that change of route.

I open `W11_Dutch_Classroom.Rproj`, restart R, and use
`Week11_Dutch_AME_Class.Rmd` in Source view. The matching HTML contains the
same lesson and its executed outputs.

## Before class

I extract the entire folder to a short path. I keep its internal folders intact.
I check that `amen`, `igraph`, `posterior`, and `knitr` are installed. Rendering
also requires `rmarkdown` and Pandoc. I arrange missing installations before the
session; the lesson does not install packages or download data.

My earlier estimation used R 4.6.0 and amen 1.4.5. I record the actual versions
in the session record rather than require every participant to upgrade R.
New versions or another platform can give different numerical behavior; I
inspect warnings and diagnostics rather than assume compatibility from a version
number alone.

## What runs

I run the visible chunks from the beginning. The `fit-rank-zero` chunk estimates
two chains of the rank-zero model with fixed seeds. It also runs when I knit the document.
The `load-rank-two-estimated-beforehand` chunk reads the two designated saved
rank-two fits. It never fits a replacement when a file is absent.

The saved rank-two objects are the first two numbered chains of the longer
rank-two run. I do not select a pair based on attractive diagnostics or pool
those chains with the earlier shorter rank-two run. Every result table in this
lesson uses two chains per model.

## Create the HTML

From the classroom project I save the Rmd, restart R, then run:

```r
source("scripts/render_lesson.R")
lesson_html <- render_lesson()
```

This is a real run of two rank-zero chains, not a formatting-only step. The
result is `Week11_Dutch_AME_Class.html` in this folder. The end of the Rmd saves
`outputs/classroom_run_<timestamp>_<process>.rds` and prints its exact path.
That record includes the live fits, settings identifiers, summaries, and session
information. I do not open an older HTML as though it reflects a newer source.

## Files

- `Week11_Dutch_AME_Class.Rmd`: the commented lesson and live rank-zero calls.
- `data/group36_like_nominations.csv`: the original group-36 liking slot records,
  including the duplicate. The lesson constructs the binary matrix visibly.
- `data/group36_attributes.csv`: matching released IDs, recorded sex, and age.
- `data/input_reference.rds`: the expected aligned outcome and predictor arrays.
- `data/rank2_preestimated.rds`: two genuine saved rank-two fits and their provenance.
- `DATA_MANIFEST.csv`: fingerprints of the supplied data/provenance files.
- `PROVENANCE.md`: my existing contribution statement, included in the lesson.
- `scripts/estimate_rank2_before_class.R`: the complete longer two-chain calls,
  for a deliberate reproduction outside class. Sourcing defines the function;
  calling `estimate_rank2_before_class()` performs the estimation.
- `recovery/rank0_backup.rds`: earlier matching rank-zero fits, for an explicitly
  announced recovery only. They are not the default execution route.

I retain the raw OSF archive and the more extensive four-chain checks in my
separate authoring project. Source: van den Bos et al. (2018),
https://doi.org/10.1371/journal.pone.0194656 ; data https://osf.io/vucwf/ .
The recorded data license is CC BY 4.0. References and changes are described
in the tutorial.

## When something stops

A file-identity or missing-file error is not a reason to refit or change a
fingerprint. I restore the supplied input and run from the correct project root.
If live estimation fails, I preserve the error. I do not silently replace it.
For an announced classroom recovery after the earlier construction chunks:

```r
backup <- readRDS("recovery/rank0_backup.rds")
stopifnot(identical(backup$inputs$Y, Y), identical(backup$inputs$Xdyad, Xdyad))
R0 <- backup$fits
seeds0 <- backup$seeds
runtime0 <- rep(NA_real_, 2L)
r0_execution <- "loaded_recovery_not_live"
```

I then continue at the rank-two loading chunk, tell the class I loaded earlier
fits, and record the problem. This is not evidence that the live fit succeeded.
