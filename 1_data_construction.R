rm(list = ls())

setwd("d://klips2017/data") 

library(plyr)
library(doBy)
library(sqldf)

# load("klips01p.Rdata")
# pdata<-dta
# 
# for (i in (2:18)) {
#   if (i<10) {
#     x<-c("klips0", i, "p.Rdata")
#   }
#   else {
#     x<-c("klips", i, "p.Rdata")
#   }
#   filenm<-paste(x, collapse = "")
#   load(filenm)
#   pdata<-merge(pdata, dta, by="pid", all=T)
# }
# 
# save(pdata, file="klips.Rdata")

load("klips.Rdata")
load("d://klips2017/solartolunar/solartolunar.Rdata")

  
pid<-pdata$pid

sex<-pdata$p010101
for (i in (2:18)) {
  if (i<10) {
    x<-c("p0", i, "0101")
  }
  else {
    x<-c("p", i, "0101")
  }
  colnm<-paste(x, collapse = "")
  sex[is.na(sex)]<-pdata[is.na(sex),colnames(pdata)==colnm]
}

cal_cl<-pdata$p010103
for (i in (2:18)) {
  if (i<10) {
    x<-c("p0", i, "0103")
  }
  else {
    x<-c("p", i, "0103")
  }
  colnm<-paste(x, collapse = "")
  cal_cl[is.na(cal_cl)]<-pdata[is.na(cal_cl),colnames(pdata)==colnm]
  cal_cl[cal_cl==-1]<-NA
}

byear<-pdata$p010104
for (i in (2:18)) {
  if (i<10) {
    x<-c("p0", i, "0104")
  }
  else {
    x<-c("p", i, "0104")
  }
  colnm<-paste(x, collapse = "")
  byear[is.na(byear)]<-pdata[is.na(byear),colnames(pdata)==colnm]
}
byear[byear==-1]<-NA

bmm<-pdata$p010105
for (i in (2:18)) {
  if (i<10) {
    x<-c("p0", i, "0105")
  }
  else {
    x<-c("p", i, "0105")
  }
  colnm<-paste(x, collapse = "")
  bmm[is.na(bmm)]<-pdata[is.na(bmm),colnames(pdata)==colnm]
}
bmm[bmm==-1]<-NA

bdd<-pdata$p010106
for (i in (2:18)) {
  if (i<10) {
    x<-c("p0", i, "0106")
  }
  else {
    x<-c("p", i, "0106")
  }
  colnm<-paste(x, collapse = "")
  bdd[is.na(bdd)]<-pdata[is.na(bdd),colnames(pdata)==colnm]
}
bdd[bdd==-1]<-NA

pdata$lunar<-ifelse(cal_cl==2,(byear*10000)+(bmm*100)+bdd, NA)
pdata<-merge(pdata, cal, by="lunar", all.x=T)
pdata<-orderBy(~pid, pdata)
pdata$seed=runif(nrow(pdata))
temp<-pdata[, c("pid", "seed")]
pcnt=sqldf("select pid, max(seed) as mseed from temp group by pid")
pdata<-merge(pdata, pcnt, by="pid", all=T)
syn<-ifelse(pdata$seed==pdata$mseed,1,0)
pdata<-pdata[syn==1,]
rm(temp, pcnt, cal)
pdata<-subset(pdata, select = -c(seed,mseed))

byear<-ifelse(cal_cl==2, as.numeric(substr(as.character(pdata$solar),1,4)), byear)
bmm<-ifelse(cal_cl==2, as.numeric(substr(as.character(pdata$solar),5,6)), bmm)  
bdd<-ifelse(cal_cl==2, as.numeric(substr(as.character(pdata$solar),7,8)), bdd)  

reg14<-pdata$p019003
for (i in (2:18)) {
  if (i<10) {
    x<-c("p0", i, "9003")
  }
  else {
    x<-c("p", i, "9003")
  }
  colnm<-paste(x, collapse = "")
  reg14[is.na(reg14)]<-pdata[is.na(reg14),colnames(pdata)==colnm]
}
reg14[reg14==-1]<-NA

breg<-pdata$p019001
for (i in (2:18)) {
  if (i<10) {
    x<-c("p0", i, "9001")
  }
  else {
    x<-c("p", i, "9001")
  }
  colnm<-paste(x, collapse = "")
  breg[is.na(breg)]<-pdata[is.na(breg),colnames(pdata)==colnm]
}
breg[breg==-1]<-NA

high_reg<-pdata$p055114
for (i in (6:18)) {
  if (i<10) {
    x<-c("p0", i, "5114")
  }
  else {
    x<-c("p", i, "5114")
  }
  colnm<-paste(x, collapse = "")
  high_reg[is.na(high_reg)]<-pdata[is.na(high_reg),colnames(pdata)==colnm]
}
high_reg[high_reg==-1]<-NA

hmidchk=rep(0, times=length(pid))
hmidchk[high_reg==reg14 & is.na(high_reg)==F]<-1
highchk=rep(0, times=length(pid))
highchk[is.na(high_reg)==F]<-1
midchk=rep(0, times=length(pid))
midchk[is.na(reg14)==F]<-1

elechk=rep(0, times=length(pid))
elechk[breg==reg14 & is.na(breg)==F & is.na(reg14)==F & is.na(byear)==F & is.na(bmm)==F & is.na(bdd)==F]<-1
elechk2=rep(0, times=length(pid))
elechk2[is.na(breg)==F & is.na(reg14)==F & is.na(byear)==F & is.na(bmm)==F & is.na(bdd)==F]<-1
prenatalchk=rep(0, times=length(pid))
prenatalchk[is.na(breg)==F & is.na(byear)==F & is.na(bmm)==F & is.na(bdd)==F]<-1

for (i in c("uprising_h", "uprising_m", "uprising_e", "uprising_n", 
            "uprising_h6", "uprising_h13", "uprising_h12", 
            "uprising_m6", "uprising_m13", "uprising_m12", 
            "uprising_e6", "uprising_e13", "uprising_e12",
            "uprising_n6", "uprising_n13", "uprising_n12",
            "gwangju_h", "gwangju_m", "gwangju_e", "gwangju_n",
            "h13", "m13", "e13", "n13",
            "h12", "m12", "e12", "n12")) {
  assign(i, rep(0, times=length(pid)))
}

uprising_h[byear==1962 & bmm>=3 & bmm<=12]<-1
uprising_h[byear==1963 & byear<=1964]<-1
uprising_h[byear==1965 & bmm>=1 & bmm<=2]<-1
gwangju_h[high_reg==6]<-1
h13[high_reg==6 | high_reg==13]<-1
h12[high_reg==6 | high_reg==12 | high_reg==13]<-1

uprising_h6[uprising_h==1 & gwangju_h==1]<-1
uprising_h13[uprising_h==1 & h13==1]<-1
uprising_h12[uprising_h==1 & h12==1]<-1

uprising_m[byear==1965 & bmm>=3 & bmm<=12]<-1
uprising_m[byear==1966 & byear<=1967]<-1
uprising_m[byear==1968 & bmm>=1 & bmm<=2]<-1
gwangju_m[reg14==6]<-1
m13[reg14==6 | reg14==13]<-1
m12[reg14==6 | reg14==12 | reg14==13]<-1

uprising_m6[uprising_m==1 & gwangju_m==1]<-1
uprising_m13[uprising_m==1 & m13==1]<-1
uprising_m12[uprising_m==1 & m12==1]<-1

uprising_e[(byear<1980 & byear>=1969) | (byear==1968 & bmm>=3 & bmm<=12) | (byear==1980 & bmm<5 & bmm>=1) | (byear==1980 & bmm==5 & bmm<18)]<-1
gwangju_e[breg==6 & reg14==6]<-1
e13[(reg14==6 | reg14==13) & (breg==6 | breg==13)]<-1
e12[(reg14==6 | reg14==12 | reg14==13) & (breg==6 | breg==12 | breg==13)]<-1

uprising_e6[uprising_e==1 & gwangju_e==1]<-1
uprising_e13[uprising_e==1 & e13==1]<-1
uprising_e12[uprising_e==1 & e12==1]<-1

uprising_n[((byear==1979 & ((bmm==8 & bdd>=18) | bmm>=9)) | (byear==1980 & (bmm<=4 | (bmm==5 & bdd<=17))))]<-1
gwangju_n[breg==6]<-1
n13[breg==6 | breg==13]<-1
n12[breg==6 | breg==12 | breg==13]<-1

uprising_n6[uprising_n==1 & gwangju_n==1]<-1
uprising_n13[uprising_n==1 & n13==1]<-1
uprising_n12[uprising_n==1 & n12==1]<-1

uage<-1980-byear
uage<-ifelse(bmm>5, uage-1, uage)
uage<-ifelse(bmm==5 & bdd>18, uage-1, uage)
uage[uage<0]<-0

edu1<-pdata$p010110
edu2<-pdata$p010111
fedu1<-pdata$p019051
fedu2<-pdata$p019052
medu1<-pdata$p019053
medu2<-pdata$p019054
for (i in c( "edu", "fedu", "medu")) {
  if (i=="edu") {
    l="0110"
    m="0111"
  }
  if (i=="fedu") {
    l="9051"
    m="9052"
  }
  if (i=="medu") {
    l="9053"
    m="9054"
  }
  print(i)
  for (j in (2:18)) {
    if (j<10) {
      x<-c("p0", j, l)
      y<-c("p0", j, m)
    }
    else {
      x<-c("p", j, l)
      y<-c("p", j, m)
    }
    colnm<-paste(x, collapse = "")
    colnm2<-paste(y, collapse = "")
    d=pdata[,colnames(pdata)==colnm]
    t=pdata[,colnames(pdata)==colnm2]

    ob1=paste(c(i, "1"), collapse="")
    ob2=paste(c(i, "2"), collapse="")
    e=get(ob1)
    f=get(ob2)
    e[is.na(d)==F]<-d[is.na(d)==F]
    f[is.na(d)==F]<-t[is.na(d)==F]
    assign(ob1, e)
    assign(ob2, f)
  }
}

edu=rep(NA, times=length(pid))
edu[edu1==1 | edu1==2]<-0
edu[edu1==3 & (edu2==1 | edu2==2)]<-6
edu[edu1==3 & (edu2>=3 & edu2<=5)]<-3
edu[edu1==4 & (edu2==1 | edu2==2)]<-9
edu[edu1==4 & (edu2>=3 & edu2<=5)]<-7.5
edu[edu1==5 & (edu2==1 | edu2==2)]<-12
edu[edu1==5 & (edu2>=3 & edu2<=5)]<-10.5
edu[edu1==6 & (edu2==1 | edu2==2)]<-14
edu[edu1==6 & (edu2>=3 & edu2<=5)]<-13
edu[edu1==7 & (edu2==1 | edu2==2)]<-16
edu[edu1==7 & (edu2>=3 & edu2<=5)]<-14
edu[edu1==8 & (edu2==1 | edu2==2)]<-18
edu[edu1==8 & (edu2>=3 & edu2<=5)]<-17
edu[edu1==9 & (edu2==1 | edu2==2)]<-20
edu[edu1==9 & (edu2>=3 & edu2<=5)]<-19

fedu=rep(NA, times=length(pid))
fedu[fedu1==1]<-0
fedu[fedu1==2 & (fedu2==1 | fedu2==5 | fedu2==6)]<-6
fedu[fedu1==2 & (fedu2>=2 & fedu2<=4)]<-3
fedu[fedu1==3 & (fedu2==1 | fedu2==5 | fedu2==6)]<-9
fedu[fedu1==3 & (fedu2>=2 & fedu2<=4)]<-7.5
fedu[fedu1==4 & (fedu2==1 | fedu2==5 | fedu2==6)]<-12
fedu[fedu1==4 & (fedu2>=2 & fedu2<=4)]<-10.5
fedu[fedu1==5 & (fedu2==1 | fedu2==5 | fedu2==6)]<-14
fedu[fedu1==5 & (fedu2>=2 & fedu2<=4)]<-13
fedu[fedu1==6 & (fedu2==1 | fedu2==5 | fedu2==6)]<-16
fedu[fedu1==6 & (fedu2>=2 & fedu2<=4)]<-14
fedu[fedu1==7 & (fedu2==1 | fedu2==5 | fedu2==6)]<-18
fedu[fedu1==7 & (fedu2>=2 & fedu2<=4)]<-17

medu=rep(NA, times=length(pid))
medu[medu1==1]<-0
medu[medu1==2 & (medu2==1 | medu2==5 | medu2==6)]<-6
medu[medu1==2 & (medu2>=2 & medu2<=4)]<-3
medu[medu1==3 & (medu2==1 | medu2==5 | medu2==6)]<-9
medu[medu1==3 & (medu2>=2 & medu2<=4)]<-7.5
medu[medu1==4 & (medu2==1 | medu2==5 | medu2==6)]<-12
medu[medu1==4 & (medu2>=2 & medu2<=4)]<-10.5
medu[medu1==5 & (medu2==1 | medu2==5 | medu2==6)]<-14
medu[medu1==5 & (medu2>=2 & medu2<=4)]<-13
medu[medu1==6 & (medu2==1 | medu2==5 | medu2==6)]<-16
medu[medu1==6 & (medu2>=2 & medu2<=4)]<-14
medu[medu1==7 & (medu2==1 | medu2==5 | medu2==6)]<-18
medu[medu1==7 & (medu2>=2 & medu2<=4)]<-17

bro_num<-pdata$p069021
sis_num<-pdata$p069022
sib_order<-pdata$p069023
bor_elder<-pdata$p069024
sis_elder<-pdata$p069025
for (i in (7:18)) {
  if (i<10) {
    a<-c("p0", i, "9021")
    b<-c("p0", i, "9022")
    d<-c("p0", i, "9023")
    e<-c("p0", i, "9024")
    f<-c("p0", i, "9025")
  }
  else {
    a<-c("p", i, "9021")
    b<-c("p", i, "9022")
    d<-c("p", i, "9023")
    e<-c("p", i, "9024")
    f<-c("p", i, "9025")
  }
  
  colnm_a<-paste(a, collapse = "")
  colnm_b<-paste(b, collapse = "")
  colnm_d<-paste(d, collapse = "")
  colnm_e<-paste(e, collapse = "")
  colnm_f<-paste(f, collapse = "")
  
  bro_num[is.na(bro_num) | bro_num==-1]<-pdata[is.na(bro_num) | bro_num==-1,colnames(pdata)==colnm_a]
  sis_num[is.na(sis_num) | sis_num==-1]<-pdata[is.na(sis_num) | sis_num==-1,colnames(pdata)==colnm_b]
  sib_order[is.na(sib_order) | sib_order==-1]<-pdata[is.na(sib_order) | sib_order==-1,colnames(pdata)==colnm_d]
  bor_elder[is.na(bor_elder) | bor_elder==-1]<-pdata[is.na(bor_elder) | bor_elder==-1,colnames(pdata)==colnm_e]
  sis_elder[is.na(sis_elder) | sis_elder==-1]<-pdata[is.na(sis_elder) | sis_elder==-1,colnames(pdata)==colnm_f]
}

for (i in c( "bro_num", "sis_num", "sib_order", "bor_elder", "sis_elder")) {
    t=get(i)
    t[t==-1]<-NA
    assign(i, t)
}

bdata<-  data.frame(
  pid, sex, byear, bmm, bdd, breg, reg14, high_reg, uage, 
  edu, edu1, edu2, fedu, fedu1, fedu2, medu, medu1, medu2,
  bro_num, sis_num, sib_order, bor_elder, sis_elder,
  elechk, elechk2, highchk,midchk, prenatalchk, 
  gwangju_e, e12, e13, gwangju_m,  m12, m13,
  gwangju_h, h12, h13, gwangju_n, n12, n13,
  uprising_h, uprising_m, uprising_e, uprising_n, 
  uprising_h6, uprising_h13, uprising_h12, 
  uprising_m6, uprising_m13, uprising_m12, 
  uprising_e6, uprising_e13, uprising_e12,
  uprising_n6, uprising_n13, uprising_n12
  )


save(bdata, file="bdata.Rdata")
