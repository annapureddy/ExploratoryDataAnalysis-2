library(dplyr)

# Obtain the data 
unzip("exdata_data_NEI_data.zip")
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Filter data for Baltimore 
df1 <- filter(nei, fips == '24510')
a1 <- inner_join(df1, scc, by = c('SCC'))
m1 <- a1[grepl('[M|m]obile', a1[, 'EI.Sector']),]
s1 <- summarize(group_by(m1, year), total_emissions = sum(Emissions))

# Filter data for Los Angeles
df2 <- filter(nei, fips == '06037')
a2 <- inner_join(df2, scc, by = c('SCC'))
m2 <- a2[grepl('[M|m]obile', a2[, 'EI.Sector']),]
s2 <- summarize(group_by(m2, year), total_emissions = sum(Emissions))

# Plot the data
png(file = 'plot6.png')
miny <- min(s1[, 'total_emissions'], s2[, 'total_emissions'])
maxy <- max(s1[, 'total_emissions'], s2[, 'total_emissions'])
plot(s1[, 'year'], s1[, 'total_emissions'], ylim = c(miny, maxy), type = 'n', xlab = 'Year', ylab = "Total PM2.5 emissions from mobile sources", main = "Total emissions from mobile sources between 1999 - 2008")
points(s1[, 'year'], s1[, 'total_emissions'], pch = 19, col = 2, type = 'b')
points(s2[, 'year'], s2[, 'total_emissions'], pch = 19, col = 3, type = 'b')
legend("topleft", legend = c("Baltimore", "Los Angeles"), pch = c(19, 19), col = c(2, 3))
dev.off()