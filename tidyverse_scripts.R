
library(tidyverse)
library(here)
library(ggplot2)


data <- read.csv(here("data", "raw", "insurance_with_date.csv"))
view(data)

#tidyverse
data <- readr::read_csv(here("data", "raw", "insurance_with_date.csv"))
view(data)

str(data)

#lgl = logical 

#mutate

data <- data %>%
  mutate(
    new_sex = as.factor(sex),    # Convert 'sex' to a factor and assign to 'new_sex'
    new_region = as.factor(region)  # Convert 'region' to a factor and assign to 'new_region'
  )

data <- data %>%
  mutate(
    #Sex as Factor
    new_sex = as.factor(sex),
    #Region as Factor
    new_region = as.factor(region),
    #More than two children
    two_children = children > 2,
    #Smoker
    smoke_yes = smoker == "yes",
    #Date plus 6 Month
    new_date = date + month(6)
  )

diff <- data$newdate - data$date
diff

#Plot Exercies
# filter data frame covid: 
# only keep confirmed cases in the cantons of Zurich, Bern and Vaud 
# in the first half of the year 2020

ebola_data <- readr::read_csv(here("data", "raw", "ebola.csv"))

library(tidyverse)

# Sort ebola_data by date in ascending order, specifying the dataframe with the column
ebola_data <- ebola_data %>%
  arrange(Date)

ebola_graph <- ebola_data %>%
  select(date = Date, country = "Country", cum_conf_cases = Cum_conf_cases)%>%
  filter(date <= ymd("2015-03-15") &
           (country == "Guinea" | country == "Liberia" | country == "Sierra Leone"))

#Plots

# Point Plot with Custom Labels
plot_ebola_point <- ggplot(data = ebola_graph, 
                           mapping = aes(x = date, y = cum_conf_cases)) + 
  geom_point(aes(group = country, colour = country)) +  # Points colored by country
  labs(title = "Ebola Cumulative Confirmed Cases Over Time",
       x = "Date",  # Label for the x-axis
       y = "Cumulative Confirmed Cases",  # Label for the y-axis
       colour = "Country")  # Title for the legend

plot_ebola_point


# Line Plot with Colors for Each Country
plot_ebola_line <- ggplot(data = ebola_graph, 
                           mapping = aes(x = date, y = cum_conf_cases)) + 
  geom_line(aes(group = country, colour = country)) +  # Lines colored by country
  labs(title = "Ebola Cumulative Confirmed Cases Over Time",
       x = "Date",  # Label for the x-axis
       y = "Cumulative Confirmed Cases",  # Label for the y-axis
       colour = "Country")  # Title for the legend

plot_ebola_line

#Column Plot
plot_ebola_col <- ggplot(data = ebola_graph, 
                          mapping = aes(x = date, y = cum_conf_cases)) + 
  geom_col(aes(group = country, colour = country)) +  # Lines colored by country
  labs(title = "Ebola Cumulative Confirmed Cases Over Time",
       x = "Date",  # Label for the x-axis
       y = "Cumulative Confirmed Cases",  # Label for the y-axis
       colour = "Country")  # Title for the legend

plot_ebola_col

#Chat GPT

#Refining it with GPT
library(ggplot2)
library(lubridate)

# Ensure your data preparation step is corrected as described above
ebola_graph <- ebola_data %>%
  select(date = Date, country = Country, cum_conf_cases = Cum_conf_cases) %>%
  filter(date <= ymd("2015-03-15") &
           (country == "Guinea" | country == "Liberia" | country == "Sierra Leone"))

# Creating the plot
ebola_plot <- ggplot(data = ebola_graph, aes(x = date, y = cum_conf_cases, colour = country)) +
  geom_line(aes(group = country), size = 1) +  # Add lines, with one line per country
  geom_point(size = 3, shape = 21, fill = "white") +  # Add points with white fill
  scale_colour_manual(values = c("Guinea" = "blue", "Liberia" = "red", "Sierra Leone" = "green")) +
  labs(title = "Ebola Cumulative Confirmed Cases Over Time",
       subtitle = "Data for Guinea, Liberia, and Sierra Leone",
       x = "Date",
       y = "Cumulative Confirmed Cases",
       colour = "Country") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position = "top",
        axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y")  # Adjust x-axis to show monthly breaks


# Display the plot
print(ebola_plot)

#Save
# Save as PNG
ggsave("ebola_plot.png", plot = ebola_plot, width = 10, height = 6, dpi = 300)

# Save as PDF
ggsave("ebola_plot.pdf", plot = ebola_plot, width = 10, height = 6)


