library(dplyr)

# Obtain the data 
unzip("exdata_data_NEI_data.zip")
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Get total emissions per year 
df <- summarize(group_by(nei, year), total_emissions = sum(Emissions))

# Plot the data
png(file = 'plot1.png')
plot(df[, 'year'], df[, 'total_emissions'], xlab = 'Year', ylab = "Total PM2.5 Emissions", main = "Total emissions between 1999 - 2008")
dev.off()