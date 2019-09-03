cd d:\klips2017\1-18th_STATA

use klips01p, clear
gen bch=p010103
gen byear=p010104
gen bmm=p010105
gen bdd=p010106
gen reg14=p019003
gen breg=p019001

keep if reg14==6 | reg14==12 | reg14==13 | breg==6 | breg==12 | breg==13
keep pid bch byear bmm bdd reg14 breg

forvalues i=2/4 {
    merge 1:1 pid using klips0`i'p
    drop _merge
    replace bch=p0`i'0103 if bch==.
    replace byear=p0`i'0104 if byear==.
    replace bmm=p0`i'0105 if bmm==.
    replace bdd=p0`i'0106 if bdd==.
    replace reg14=p0`i'9003 if reg14==.
    replace breg=p0`i'9001 if breg==.
    
    keep if reg14==6 | reg14==12 | reg14==13 | breg==6 | breg==12 | breg==13
    keep pid bch byear bmm bdd reg14 breg
}

merge 1:1 pid using klips05p
drop _merge
replace bch=p050103 if bch==.
replace byear=p050104 if byear==.
replace bmm=p050105 if bmm==.
replace bdd=p050106 if bdd==.
replace reg14=p059003 if reg14==.
replace breg=p059001 if breg==.
gen high_reg=p055114 //전북 12 전남 13 광주 6

keep if high_reg==6 | high_reg==12 | high_reg==13 | reg14==6 | reg14==12 | reg14==13 | breg==6 | breg==12 | breg==13
keep pid bch byear bmm bdd high_reg reg14 breg

forvalues i=6/9 {
    merge 1:1 pid using klips0`i'p
    drop _merge
    replace bch=p0`i'0103 if bch==.
    replace byear=p0`i'0104 if byear==.
    replace bmm=p0`i'0105 if bmm==.
    replace bdd=p0`i'0106 if bdd==.
    replace high_reg=p0`i'5114  if high_reg==. //전북 12 전남 13 광주 6
    replace reg14=p0`i'9003 if reg14==.
    replace breg=p0`i'9001 if breg==.
    
    keep if high_reg==6 | high_reg==12 | high_reg==13 | reg14==6 | reg14==12 | reg14==13 | breg==6 | breg==12 | breg==13
    keep pid bch byear bmm bdd high_reg reg14 breg
}

forvalues i=10/18 {
    merge 1:1 pid using klips`i'p
    drop _merge
    replace bch=p`i'0103 if bch==.
    replace byear=p`i'0104 if byear==.
    replace bmm=p`i'0105 if bmm==.
    replace bdd=p`i'0106 if bdd==.
    replace high_reg=p`i'5114  if high_reg==. //전북 12 전남 13 광주 6
    replace reg14=p`i'9003 if reg14==.
    replace breg=p`i'9001 if breg==.
    
    keep if high_reg==6 | high_reg==12 | high_reg==13 | reg14==6 | reg14==12 | reg14==13 | breg==6 | breg==12 | breg==13
    keep pid bch byear bmm bdd high_reg reg14 breg
} 

gen midchk=(high_reg==reg14)

gen uprising_h6=(bch==1 & byear==1962 & bmm>=3 & bmm<=12 & high_reg==6)
replace uprising_h6=1 if (byear==1963 & byear<=1964 & high_reg==6)
replace uprising_h6=1 if (bch==1 & byear==1965 & bmm>=1 & bmm<=2 & high_reg==6)
replace uprising_h6=1 if (bch==2 & byear==1962 & bmm==1 & bdd>=25 & bdd<=31 & high_reg==6)
replace uprising_h6=1 if (bch==2 & byear==1962 & bmm>=2 & bmm<=12 & high_reg==6)
replace uprising_h6=1 if (bch==2 & byear==1965 & bmm==1 & bdd>=1 & bdd<=27 & high_reg==6)

gen uprising_h13=(bch==1 & byear==1962 & bmm>=3 & bmm<=12 & (high_reg==6 | high_reg==13))
replace uprising_h13=1 if (byear==1963 & byear<=1964 & (high_reg==6 | high_reg==13))
replace uprising_h13=1 if (bch==1 & byear==1965 & bmm>=1 & bmm<=2 & (high_reg==6 | high_reg==13))
replace uprising_h13=1 if (bch==2 & byear==1962 & bmm==1 & bdd>=25 & bdd<=31 & (high_reg==6 | high_reg==13))
replace uprising_h13=1 if (bch==2 & byear==1962 & bmm>=2 & bmm<=12 & (high_reg==6 | high_reg==13))
replace uprising_h13=1 if (bch==2 & byear==1965 & bmm==1 & bdd>=1 & bdd<=27 & (high_reg==6 | high_reg==13))

gen uprising_m6=(bch==1 & byear==1965 & bmm>=3 & bmm<=12 & high_reg==6 & midchk==1)
replace uprising_m6=1 if (byear==1966 & byear<=1967 & high_reg==6  & midchk==1)
replace uprising_m6=1 if (bch==1 & byear==1968 & bmm>=1 & bmm<=2 & high_reg==6 & midchk==1)
replace uprising_m6=1 if (bch==2 & byear==1965 & bmm==1 & bdd>=28 & bdd<=31 & high_reg==6 & midchk==1)
replace uprising_m6=1 if (bch==2 & byear==1965 & bmm>=2 & bmm<=12 & high_reg==6 & midchk==1)
replace uprising_m6=1 if (bch==2 & byear==1968 & bmm==1 & high_reg==6 & midchk==1)
replace uprising_m6=1 if (bch==2 & byear==1968 & bmm==2 & bdd>=1 & bdd<=2 & high_reg==6 & midchk==1)

gen uprising_m13=(bch==1 & byear==1965 & bmm>=3 & bmm<=12 & (high_reg==6 | high_reg==13) & midchk==1)
replace uprising_m13=1 if (byear==1966 & byear<=1967 & (high_reg==6 | high_reg==13) & midchk==1)
replace uprising_m13=1 if (bch==1 & byear==1968 & bmm>=1 & bmm<=2 & (high_reg==6 | high_reg==13) & midchk==1)
replace uprising_m13=1 if (bch==2 & byear==1965 & bmm==1 & bdd>=25 & bdd<=31 & (high_reg==6 | high_reg==13) & midchk==1)
replace uprising_m13=1 if (bch==2 & byear==1965 & bmm>=2 & bmm<=12 & (high_reg==6 | high_reg==13) & midchk==1)
replace uprising_m13=1 if (bch==2 & byear==1968 & bmm==1 & high_reg==6 & midchk==1)
replace uprising_m13=1 if (bch==2 & byear==1968 & bmm==2 & bdd>=1 & bdd<=2 & (high_reg==6 | high_reg==13) & midchk==1)

gen elechk=(breg==reg14)
gen uprising_e6=(elechk==1 & breg==6 & bch==1 & ((byear<1980 & byear>=1969) | (byear==1968 & bmm>=3) | (byear==1980 & bmm<5 & bmm>=1)))
replace uprising_e6=1 if (elechk==1 & breg==6 & bch==2 & byear<1980 & byear>=1969)
replace uprising_e6=1 if (elechk==1 & breg==6 & bch==2 & byear==1968 & (bmm==1 | (bmm==2 & (bdd==1 | bdd==2))))
replace uprising_e6=1 if (elechk==1 & breg==6 & bch==2 & byear==1980 & (bmm==1 | bmm==2 | (bmm==3 & (bdd>=1 & bdd==16))))

gen elechk13=((breg==6 | breg==13) & (reg14==6 | reg14==13))
gen uprising_e13=(elechk13==1 & bch==1 & ((byear<1980 & byear>=1969) | (byear==1968 & bmm>=3) | (byear==1980 & bmm<5 & bmm>=1)))
replace uprising_e13=1 if (elechk13==1 & bch==2 & byear<1980 & byear>=1969)
replace uprising_e13=1 if (elechk13==1 & bch==2 & byear==1968 & (bmm==1 | (bmm==2 & (bdd==1 | bdd==2))))
replace uprising_e13=1 if (elechk13==1 & bch==2 & byear==1980 & (bmm==1 | bmm==2 | (bmm==3 & (bdd>=1 & bdd==16))))

gen elechk12=((breg==6 | breg==12 | breg==13) & (reg14==6 | reg14==12 | reg14==13))
gen uprising_e12=(elechk12==1 & bch==1 & ((byear<1980 & byear>=1969) | (byear==1968 & bmm>=3) | (byear==1980 & bmm<5 & bmm>=1)))
replace uprising_e12=1 if (elechk12==1 & bch==2 & byear<1980 & byear>=1969)
replace uprising_e12=1 if (elechk12==1 & bch==2 & byear==1968 & (bmm==1 | (bmm==2 & (bdd==1 | bdd==2))))
replace uprising_e12=1 if (elechk12==1 & bch==2 & byear==1980 & (bmm==1 | bmm==2 | (bmm==3 & (bdd>=1 & bdd==16))))

save "D:\klips2017\data\temp.dta"
