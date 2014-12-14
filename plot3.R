library(dplyr)
library(ggplot2)

# Obtain the data 
unzip("exdata_data_NEI_data.zip")
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Get data for fips == "24510"
df <- filter(nei, fips == '24510')
df <- summarize(group_by(df, year, type), total_emissions = sum(Emissions))

# Plot the data
p <- qplot(year, total_emissions, data = df, facets = . ~ type, xlab = 'Year', ylab = "Total PM2.5 Emissions", main = "Total emissions in Baltimore by type between 1999 - 2008")
ggsave(filename = 'plot3.png', plot = p)