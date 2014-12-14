library(dplyr)

# Obtain the data 
unzip("exdata_data_NEI_data.zip")
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Join data to get the pollutant sources
df <- filter(nei, fips == '24510')
all <- inner_join(df, scc, by = c('SCC'))
mobile <- all[grepl('[M|m]obile', all[, 'EI.Sector']),]
mobile <- summarize(group_by(mobile, year), total_emissions = sum(Emissions))

# Plot the data appropriately
png(file = 'plot5.png')
plot(mobile[, 'year'], mobile[, 'total_emissions'], xlab = 'Year', ylab = "Total PM2.5 emissions from mobile sources", main = "Total emissions from mobile sources between 1999 - 2008")
dev.off()