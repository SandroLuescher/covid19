# Choose the data directory with the csv files

temp = list.files(pattern="*.csv")
for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i]))

# Delete the columns so all files have the same number of columns

COVID19_Fallzahlen_Kanton_TI_total.csv <- subset(COVID19_Fallzahlen_Kanton_TI_total.csv, select = -c(12))
COVID19_Fallzahlen_Kanton_ZH_total.csv <- subset(COVID19_Fallzahlen_Kanton_ZH_total.csv, select = -c(12,13))
COVID19_Fallzahlen_Kanton_GE_total.csv <- subset(COVID19_Fallzahlen_Kanton_GE_total.csv, select = -c(12,13))

# Merge the datasets (had drop OW because it contains too little data - caused an error)

new <- rbind(COVID19_Fallzahlen_Kanton_AG_total.csv, COVID19_Fallzahlen_Kanton_AI_total.csv,
             COVID19_Fallzahlen_Kanton_AR_total.csv, COVID19_Fallzahlen_Kanton_BE_total.csv,
             COVID19_Fallzahlen_Kanton_BL_total.csv, COVID19_Fallzahlen_Kanton_BS_total.csv,
             COVID19_Fallzahlen_Kanton_FR_total.csv, COVID19_Fallzahlen_Kanton_GE_total.csv,
             COVID19_Fallzahlen_Kanton_GL_total.csv, COVID19_Fallzahlen_Kanton_GR_total.csv,
             COVID19_Fallzahlen_Kanton_JU_total.csv, COVID19_Fallzahlen_Kanton_LU_total.csv,
             COVID19_Fallzahlen_Kanton_NE_total.csv, COVID19_Fallzahlen_Kanton_NW_total.csv,
             COVID19_Fallzahlen_Kanton_SG_total.csv, COVID19_Fallzahlen_Kanton_SH_total.csv,
             COVID19_Fallzahlen_Kanton_SH_total.csv, COVID19_Fallzahlen_Kanton_SO_total.csv,
             COVID19_Fallzahlen_Kanton_SZ_total.csv, COVID19_Fallzahlen_Kanton_TG_total.csv,
             COVID19_Fallzahlen_Kanton_TI_total.csv, COVID19_Fallzahlen_Kanton_UR_total.csv,
             COVID19_Fallzahlen_Kanton_VD_total.csv, COVID19_Fallzahlen_Kanton_VS_total.csv,
             COVID19_Fallzahlen_Kanton_ZG_total.csv, COVID19_Fallzahlen_Kanton_ZH_total.csv)

# Required packages

library(ggplot2)
library(directlabels)
library(gghighlight)

plot<-ggplot(new, aes(x=as.Date(date), y=as.numeric(log10(ncumul_conf)),group=abbreviation_canton_and_fl,col=abbreviation_canton_and_fl))+
  geom_line(size=1)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1,size=4),
        text = element_text(size=10),
        panel.grid.major = element_line(colour="lightgrey"),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(color="darkblue", size=14, face="bold"),
        legend.position = "none")+
  scale_x_date(date_labels = "%B %d",date_breaks = "3 day")+
  labs(y="log10",x="",title="Kumulative Entwicklung der kantonalen COVID-19 Fallzahlen",subtitle="Stand: 23.03.2020, 16.00 Uhr
Quellen: OGD-Datensatz der offiziellen kantonalen Fallzahlen - https://github.com/openZH/covid_19")+
  facet_wrap(~abbreviation_canton_and_fl)

covidplot <- plot + gghighlight()

ggsave("covidplot.png",covidplot)
