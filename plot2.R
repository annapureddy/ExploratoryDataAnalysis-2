library(dplyr)

# Obtain the data 
unzip("exdata_data_NEI_data.zip")
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Get total emissions per year for fips == "24510"
df <- filter(nei, fips == '24510')
df <- summarize(group_by(df, year), total_emissions = sum(Emissions))

# Plot the data
png(file = 'plot2.png')
plot(df[, 'year'], df[, 'total_emissions'], xlab = 'Year', ylab = "Total PM2.5 Emissions", main = "Total emissions in Baltimore between 1999 - 2008")
dev.off()