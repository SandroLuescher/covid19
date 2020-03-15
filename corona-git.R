library(ggplot2)

covid.data <- subset(covid_cant, canton != "CH" & canton != "FL")

plot <- ggplot(covid.data, aes(x=as.Date(date), y=as.numeric(tested_pos)*10000/as.numeric(population),group=canton))+
  geom_line()+
  geom_point()+
  facet_wrap(. ~ canton)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1,size=6),
        text = element_text(size=10),
        panel.grid.major = element_line(colour = "grey",linetype = "dotted"),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(color="darkblue", size=14, face="bold"))+
  scale_x_date(date_labels = "%B %d",date_breaks = "1 day")+
  labs(y="",x="",title="Positiv erstgetestete Personen nach Kanton pro 10'000 Einwohner",subtitle="Stand: 14.03.2020, 10.30 Uhr
Quellen: Gesundheitsdirektion Kanton Zürich, Statistisches Amt Kanton Zürich & Bundesamt für Gesundheit")

plot

ggsave("covid2.png", plot)


