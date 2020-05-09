library(shiny)
library("arules")
library("arulesViz")
library(DT)
library(plotly)

shinyServer(function(input, output) {

	purchases <- read.transactions(file="1000_names.csv", format="basket", sep=",", cols=1)
	
	output$simplestaticplot = renderPlot({
		rules_plot <- apriori(purchases, parameter=list(support=input$support1,confidence=input$confidence1))
		if (length(rules_plot) > 0) {
			plot(rules_plot, method = "scatterplot", measure = c("support", "confidence"), shading = "confidence", xlim = c(0.01, 0.05), ylim = c(0.002, 0.999))
		}
	})
	
	output$interactivetable = 
		renderDataTable({
			rules_table <- apriori(purchases, parameter=list(support=input$support2,confidence=input$confidence2))
			if (length(rules_table) > 0) {
				inspectDT(rules_table)
			}
		}, escape=TRUE)

	output$interactivescatterplot = renderPlotly({
		plotly_arules(apriori(purchases, parameter = list(support=input$support3, confidence=input$confidence3)), measure = c("support", "confidence"), shading = "confidence")
	})
	
})
