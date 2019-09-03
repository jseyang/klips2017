rm(list = ls())

setwd("d://klips2017/1-18th_STATA")

library(readstata13)

for (i in (1:18)) {
  if (i<10) {
    x<-c("klips0", i, "p.dta")
  }
  else {
    x<-c("klips", i, "p.dta")
  }
  filenm<-paste(x, collapse = "")
  dta<-read.dta13(filenm)
  y<-c("d://klips2017/data/", substr(filenm,1,8), ".Rdata")
  filenm2<-paste(y, collapse = "")
  save(dta, file=filenm2)
}

# klips01p<-read.dta13("klips01p.dta")
# save(klips01p, file="d://klips2017/data/klips01p.Rdata")
# klips02p<-read.dta13("klips02p.dta")
# save(klips02p, file="d://klips2017/data/klips02p.Rdata")
# klips03p<-read.dta13("klips03p.dta")
# save(klips03p, file="d://klips2017/data/klips03p.Rdata")
# klips04p<-read.dta13("klips04p.dta")
# save(klips04p, file="d://klips2017/data/klips04p.Rdata")
# klips05p<-read.dta13("klips05p.dta")
# save(klips05p, file="d://klips2017/data/klips05p.Rdata")
# klips06p<-read.dta13("klips06p.dta")
# save(klips06p, file="d://klips2017/data/klips06p.Rdata")
# klips07p<-read.dta13("klips07p.dta")
# save(klips07p, file="d://klips2017/data/klips07p.Rdata")
# klips08p<-read.dta13("klips08p.dta")
# save(klips08p, file="d://klips2017/data/klips08p.Rdata")
# klips09p<-read.dta13("klips09p.dta")
# save(klips09p, file="d://klips2017/data/klips09p.Rdata")
# klips10p<-read.dta13("klips10p.dta")
# save(klips10p, file="d://klips2017/data/klips10p.Rdata")
# klips11p<-read.dta13("klips11p.dta")
# save(klips11p, file="d://klips2017/data/klips11p.Rdata")
# klips12p<-read.dta13("klips12p.dta")
# save(klips12p, file="d://klips2017/data/klips12p.Rdata")
# klips13p<-read.dta13("klips13p.dta")
# save(klips13p, file="d://klips2017/data/klips13p.Rdata")
# klips14p<-read.dta13("klips14p.dta")
# save(klips14p, file="d://klips2017/data/klips14p.Rdata")
# klips15p<-read.dta13("klips15p.dta")
# save(klips15p, file="d://klips2017/data/klips15p.Rdata")
# klips16p<-read.dta13("klips16p.dta")
# save(klips16p, file="d://klips2017/data/klips16p.Rdata")
# klips17p<-read.dta13("klips17p.dta")
# save(klips17p, file="d://klips2017/data/klips17p.Rdata")
# klips18p<-read.dta13("klips18p.dta")
# save(klips18p, file="d://klips2017/data/klips18p.Rdata")


