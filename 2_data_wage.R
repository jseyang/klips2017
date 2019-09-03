rm(list = ls())
setwd("d://klips2017/data") 
load("klips.Rdata")

for (j in 1:18) {
  if (j<10) {
    a<-c("p0", j, "0107") #만나이
    b<-c("p0", j, "1006") #(주된일자리)주당 정규근로시간(임금)
    d<-c("p0", j, "1011") #(주된일자리)초과근로여부
    e<-c("p0", j, "1012") #(주된일자리)일주일 또는 월평균 초과근로시간
    f<-c("p0", j, "1019") #(주된일자리)초과근로시간 구분
    g<-c("p0", j, "1031") #(주된일자리)주당 평균 근무시간(비임금)
    h<-c("p0", j, "1642") #(주된일자리)임금근로자-월평균임금액수(만)
    i<-c("p0", j, "1672") #(주된일자리)비임금근로자-월평균 소득(만)
    l<-c("p0", j, "0121") #거주지
    m<-c("p0", j, "0330") #(주된일자리)업종: 2000코드(표준산업분류 8차)
    n<-c("p0", j, "0332") #(주된일자리)직종: 2000코드(표준직업분류 5차)
    o<-c("p0", j, "2501") #(주된일자리)노조유무
    p<-c("p0", j, "5501") #(모든응답자)혼인상태
  }
  else {
    a<-c("p", j, "0107")
    b<-c("p", j, "1006")
    d<-c("p", j, "1011")
    e<-c("p", j, "1012")
    f<-c("p", j, "1019")
    g<-c("p", j, "1031")
    h<-c("p", j, "1642")
    i<-c("p", j, "1672")
    l<-c("p", j, "0121") #거주지
    m<-c("p", j, "0330") #(주된일자리)업종: 2000코드(표준산업분류 8차)
    n<-c("p", j, "0332") #(주된일자리)직종: 2000코드(표준직업분류 5차)
    o<-c("p", j, "2501") #(주된일자리)노조유무
    p<-c("p", j, "5501") #(모든응답자)혼인상태
    
  }
  
  colnm_a<-paste(a, collapse = "")
  colnm_b<-paste(b, collapse = "")
  colnm_d<-paste(d, collapse = "")
  colnm_e<-paste(e, collapse = "")
  colnm_f<-paste(f, collapse = "")
  colnm_g<-paste(g, collapse = "")
  colnm_h<-paste(h, collapse = "")
  colnm_i<-paste(i, collapse = "")
  colnm_l<-paste(l, collapse = "")
  colnm_m<-paste(m, collapse = "")
  colnm_n<-paste(n, collapse = "")
  colnm_o<-paste(o, collapse = "")
  colnm_p<-paste(p, collapse = "")
  
  pid<-pdata$pid
  age<-pdata[,colnames(pdata)==colnm_a]
  normhour<-pdata[,colnames(pdata)==colnm_b]
  overtimeyn<-pdata[,colnames(pdata)==colnm_d]
  overtime<-pdata[,colnames(pdata)==colnm_e]
  overtime_cl<-pdata[,colnames(pdata)==colnm_f]
  avhour_self<-pdata[,colnames(pdata)==colnm_g]
  mwage<-pdata[,colnames(pdata)==colnm_h]
  mearnings_self<-pdata[,colnames(pdata)==colnm_i]
  area<-pdata[,colnames(pdata)==colnm_l]
  ind<-pdata[,colnames(pdata)==colnm_m]
  occ<-pdata[,colnames(pdata)==colnm_n]
  union<-pdata[,colnames(pdata)==colnm_o]
  marry<-pdata[,colnames(pdata)==colnm_p]
  
  for (i in c( "age", "normhour", "overtimeyn", "overtime", "overtime_cl", "avhour_self", "mwage", "mearnings_self", 
               "area", "ind", "occ", "union", "marry")) {
    t=get(i)
    t[t==-1]<-NA
    assign(i, t)
  }
  for (i in c( "normhour", "avhour_self", "mwage", "mearnings_self")) {
    t=get(i)
    t[t==0]<-NA
    assign(i, t)
  } 
  year<-rep(j+1997, times=nrow(pdata))
  overtime<-ifelse(overtime_cl==2, overtime/4.3, overtime)
  workhr<-ifelse(overtimeyn==1, normhour, normhour+overtime)
  hwage<-mwage / (workhr*4.3)
  mearnings<-ifelse(is.na(mwage), mearnings_self, mwage)
  earnhr<-ifelse(is.na(mwage), avhour_self, workhr )
  hearnings<-mearnings/earnhr
  
  wage<-as.data.frame(
    cbind(pid, year, age, normhour, overtimeyn, overtime, overtime_cl, avhour_self, mwage,  mearnings_self, 
          workhr, hwage, earnhr, hearnings, mearnings, area, ind, occ, union, marry  )
  )
  
  k<-wage[is.na(age)==F, ]
  x<-c("wage", j)
  y<-c("wage", j, ".Rdata")
  filenm1<-paste(x, collapse = "")
  filenm2<-paste(y, collapse = "")
  assign(filenm1, k)
  save(list=c(filenm1), file=filenm2) 
  
}

rm(list = ls())
for (i in 1:18) {
  x<-c("wage",i,".Rdata")
  filenm<-paste(x, collapse = "")
  load(filenm)
}

wage<-as.data.frame(wage1)
for (i in 2:18) {
  x<-c("wage",i)
  filenm<-paste(x, collapse = "")
  d<-get(filenm)
  wage<-rbind(wage, d)
}
save(wage, file="wage.Rdata")

library(xlsx)

cpi<-read.xlsx2("d://klips2017/cpi.xlsx", sheetIndex = 1)

save(cpi, file="cpi.Rdata")

rm(list = ls())
library(doBy)

load("wage.Rdata")
load("cpi.Rdata")
wage<-merge(wage, cpi, by="year", all.x=T)
wage<-orderBy(~pid+year, wage)
save(wage, file="wage.Rdata")

