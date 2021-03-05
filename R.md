[R](#r)

[RStudio](#rstudio)

### R
```bash
# Compile from source
./configure [--prefix=${SOFTWAREDIR}/R --enable-utf8 --with-pcre1 --enable-R-shlib] #  The last option is to enable a lib     rary needed by RStudio
 make
```

### RStudio
```bash
export RSTUDIO_WHICH_R=${SOFTWAREDIR}/R-4.0.3/bin/R && rstudio
```

