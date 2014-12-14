library(dplyr)
library(ggplot2)

# Obtain the data 
unzip("exdata_data_NEI_data.zip")
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Join data to get the pollutant sources
all <- inner_join(nei, scc, by = c('SCC'))

# Filter for coal sources
coal <- all[grepl('[C|c]oal', all[, 'EI.Sector']),]

# Plot total emissions from coal sources
df <- summarize(group_by(coal, year), total_emissions = sum(Emissions))
png(file = 'plot4.png')
plot(df[, 'year'], df[, 'total_emissions'], xlab = 'Year', ylab = "Total PM2.5 emissions from coal sources", main = "Total emissions from coal sources between 1999 - 2008")
dev.off()