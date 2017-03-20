require(dplyr)
require(ggplot2)
require(tidyr)
require(grid)

carot <- read.csv('carotenoids.csv', stringsAsFactors = F)
carot2 <- carot %>% gather(key = stage, value = count, bud:pre.A)
carot2$stage <- factor(carot2$stage, levels = c("bud","stage.D","pre.A"),
                       labels = c("bud", "stage D", "pre-A"))
carot2$gene <- factor(carot2$gene, levels = c("PSY","PDS","ZISO","ZDS","CRTISO","LCYB",
                                              "LCYE","CYP97","BCH","ZEP","NXS","NCED"))
carot2$species <- factor(carot2$species, levels = c("AC","AE","AM","AP"))

ggplot(carot2,aes(stage, count)) +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = "white", colour = "black"),
        legend.position = c(1.5,0.25),
        legend.key = element_rect(fill = "white"),
        legend.justification = c("center", "top"),
        legend.key.width = unit(2, "cm")) +
  scale_shape_manual(values = c(0,1,2,5)) +
  geom_point(aes(shape = species)) +
  geom_line(aes(color = species, group = species)) +
  scale_color_manual(values = c("royalblue","red","gray50","magenta")) +
  facet_wrap(~gene, scales = "free", ncol=2) +
  labs(x= "")
ggsave("carotenoids.png",width=25,height=25,unit="cm",dpi=600)
