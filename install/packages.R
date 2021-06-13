## required packages
packages <- c('acled.api', 'arm', 'brms', 'caret', 'covr', 'cowplot',
              'data.table', 'devtools', 'doParallel', 'future', 'ggrepel',
              'ggridges', 'ggthemes', 'glmnet', 'gridExtra', 'haven',
              'knitr', 'latex2exp', 'lme4', 'lwgeom', 'magick',
              'meltt', 'microbenchmark', 'modelsummary', 'ranger', 'rgeos',
              'rgdal', 'rio', 'rJava', 'rpart', 'rstan', 'RWmisc', 'testthat',
              'texreg', 'WDI', 'tidyverse', 'xtable')

## check if any required packages not present
if (length(setdiff(packages, rownames(installed.packages())))) {
  
  ## install any required packages not present
  install.packages(setdiff(packages, rownames(installed.packages())),
                   repos = 'http://cran.us.r-project.org')
  
}

## sf w/ arguments
if (length(setdiff('sf', rownames(installed.packages())))) {
  
  ## install any required packages not present
  install.packages('sf', repos = 'http://cran.us.r-project.org',
                   configure.args = '--with-gdal-config=/usr/local/bin/gdal-config --with-proj-include=/usr/local/include --with-proj-lib=/usr/local/lib --with-geos-config=/usr/local/bin/geos-config')
  
}

## symlink optimized BLAS
if (grepl('darwin', sessionInfo()$R.version$os)) {

  file.symlink('/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/Versions/Current/libBLAS.dylib',
              '/Library/Frameworks/R.framework/Resources/lib/libRblas.dylib')
  
} 