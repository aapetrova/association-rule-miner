library(shiny)
library("arules")
library("arulesViz")
library(DT)
library(plotly)

shinyServer(function(input, output) {
  
  purchases <- reactive({
    if (!is.null(input$dataset)) {
      if (input$hasId) {
        colId <- 1
      } else {
        colId <- NULL
      }
      purchases <- read.transactions(file=input$dataset$datapath, format="basket", sep=",", cols=colId)
    } else {
      purchases <- read.transactions(file="1000_names.csv", format="basket", sep=",", cols=1)
    }
  })
	
	output$simplestaticplot = renderPlot({
		rules_plot <- apriori(purchases(), parameter=list(support=input$support1,confidence=input$confidence1))
		if (length(rules_plot) > 0) {
			plot(rules_plot, method = "scatterplot", measure = c("support", "confidence"), shading = "confidence", xlim = c(0.01, 0.05), ylim = c(0.002, 0.999))
		}
	})
	
	output$interactivetable = 
		renderDataTable({
			rules_table <- apriori(purchases(), parameter=list(support=input$support2, confidence=input$confidence2))
			if (length(rules_table) > 0) {
			  # I'd use inspectDT() but it doesn't seem to work anymore
			  # https://github.com/mhahsler/arulesViz/issues/17
			  output_df <- DATAFRAME(rules_table)[,c("LHS", "RHS", "support", "confidence", "lift")]
			  output_df[,3:5] <- round(output_df[,3:5], 3)
			  output_df
			}
		})

	output$interactivescatterplot = renderPlotly({
		plot(apriori(purchases(), parameter = list(support=input$support3, confidence=input$confidence3)), engine = "plotly", measure = c("support", "confidence"), shading = "confidence")
	})
	
})
