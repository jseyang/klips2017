o<-subset(bdata, ((byear>=1946 & byear<=1960) | (byear>=1982 & byear<=1996) | uprising_e==1) & elechk==1)
s1<-subset(o, uprising_e6==1)
s2<-subset(o, gwangju_e==1 & byear>=1946 & byear<=1960)
s3<-subset(o, gwangju_e==1 & byear>=1982 & byear<=1996)
s4<-subset(o, gwangju_e!=1 & uprising_e==1)
s5<-subset(o, gwangju_e!=1 & byear>=1946 & byear<=1960)
s6<-subset(o, gwangju_e!=1 & byear>=1982 & byear<=1996)

sqldf("select count(*) from s1 where edu is not NULL")
mean(s1$edu, na.rm=T)
sd(s1$edu, na.rm=T)
sqldf("select count(*) from s2 where edu is not NULL")
mean(s2$edu, na.rm=T)
sd(s2$edu, na.rm=T)
sqldf("select count(*) from s3 where edu is not NULL")
mean(s3$edu, na.rm=T)
sd(s3$edu, na.rm=T)
sqldf("select count(*) from s4 where edu is not NULL")
mean(s4$edu, na.rm=T)
sd(s4$edu, na.rm=T)
sqldf("select count(*) from s5 where edu is not NULL")
mean(s5$edu, na.rm=T)
sd(s5$edu, na.rm=T)
sqldf("select count(*) from s6 where edu is not NULL")
mean(s6$edu, na.rm=T)
sd(s6$edu, na.rm=T)

sqldf("select count(*) from s1 where fedu is not NULL")
mean(s1$fedu, na.rm=T)
sd(s1$fedu, na.rm=T)
sqldf("select count(*) from s2 where fedu is not NULL")
mean(s2$fedu, na.rm=T)
sd(s2$fedu, na.rm=T)
sqldf("select count(*) from s3 where fedu is not NULL")
mean(s3$fedu, na.rm=T)
sd(s3$fedu, na.rm=T)
sqldf("select count(*) from s4 where fedu is not NULL")
mean(s4$fedu, na.rm=T)
sd(s4$fedu, na.rm=T)
sqldf("select count(*) from s5 where fedu is not NULL")
mean(s5$fedu, na.rm=T)
sd(s5$fedu, na.rm=T)
sqldf("select count(*) from s6 where fedu is not NULL")
mean(s6$fedu, na.rm=T)
sd(s6$fedu, na.rm=T)

o<-subset(pdata, ((byear>=1946 & byear<=1960) | (byear>=1982 & byear<=1996) | uprising_e==1) & elechk==1)
o$marry_yn<-o$marry.yn
s1<-subset(o, uprising_e6==1)
s2<-subset(o, gwangju_e==1 & byear>=1946 & byear<=1960)
s3<-subset(o, gwangju_e==1 & byear>=1982 & byear<=1996)
s4<-subset(o, gwangju_e!=1 & uprising_e==1)
s5<-subset(o, gwangju_e!=1 & byear>=1946 & byear<=1960)
s6<-subset(o, gwangju_e!=1 & byear>=1982 & byear<=1996)

sqldf("select marry_yn, count(*) from s1 group by marry_yn")
sqldf("select marry_yn, count(*) from s2 group by marry_yn")
sqldf("select marry_yn, count(*) from s3 group by marry_yn")
sqldf("select marry_yn, count(*) from s4 group by marry_yn")
sqldf("select marry_yn, count(*) from s5 group by marry_yn")
sqldf("select marry_yn, count(*) from s6 group by marry_yn")

sqldf("select count(*) from s1 where hwage is not NULL")
mean(s1$hwage, na.rm=T)
sd(s1$hwage, na.rm=T)
sqldf("select count(*) from s2 where hwage is not NULL")
mean(s2$hwage, na.rm=T)
sd(s2$hwage, na.rm=T)
sqldf("select count(*) from s3 where hwage is not NULL")
mean(s3$hwage, na.rm=T)
sd(s3$hwage, na.rm=T)
sqldf("select count(*) from s4 where hwage is not NULL")
mean(s4$hwage, na.rm=T)
sd(s4$hwage, na.rm=T)
sqldf("select count(*) from s5 where hwage is not NULL")
mean(s5$hwage, na.rm=T)
sd(s5$hwage, na.rm=T)
sqldf("select count(*) from s6 where hwage is not NULL")
mean(s6$hwage, na.rm=T)
sd(s6$hwage, na.rm=T)