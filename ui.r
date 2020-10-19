library("shiny")
library("shinydashboard")
library(DT)
library(plotly)

dashboardPage(
  dashboardHeader(title = "Association Rules"),
  dashboardSidebar(
	sidebarMenu(
		menuItem("About", icon=icon("question-circle"), tabName="about"),
		menuItem("Upload CSV", icon=icon("upload"), tabName="upload"),
		menuItem("Static Plot", icon=icon("bar-chart"), tabName="staticplot"),
		menuItem("Interactive Table", icon=icon("table"), tabName="table"),
		menuItem("Interactive Scatterplot", icon=icon("mouse-pointer"), tabName="scatterplot"),
		menuItem("Acknowledgements", icon=icon("star"), tabName="credits")
	)
  ),
  dashboardBody(
	tabItems(
		tabItem(tabName="about",
			fluidRow(
				box(
				"Welcome,", br(), br(), "this page contains interactive visualizations of association rule mining.", br(),
				"It serves as a side-project that emerged during the Data Mining proseminar at the Technical University of Munich.",
				br(), br(),
				"You can generate static scatter plots, interactive data tables, and interactive scatter plots.", br(),
				"This demonstration uses the ExtendedBakery dataset, which is available ",
				a("here.", href="http://users.csc.calpoly.edu/~dekhtyar/466-Spring2018/labs/lab01.html"), br(), br(),
				"Note that this app uses mostly small (~1000 items) datasets for demo purposes.", br(), br(),
				"Have fun ;)"
				)
			)
			
		),
		
		tabItem(tabName="upload",
		        fluidRow(
		          box("Upload a CSV where each row represents a transaction like this:", br(), br(),
		              code("1,item1,item2"), br(),
		              code("2,item3"), br(),
		              code("3,item1,item3,item4"), br(), br(),
		          "Alternatively, you can preview this app with the Extended Bakery dataset.", br(),br(),
		              # https://github.com/rstudio/shiny-examples/blob/master/009-upload/app.R
		              fileInput("dataset",
		                        "Browse CSV:",
		                        multiple = FALSE,
		                        accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")
		              ),
		              checkboxInput("hasId", "The first column is an ID.")
		          )
		        )
		  
		),
		
		tabItem(tabName="staticplot", title = "Static plot",
			fluidRow(
				column(width = 12, 
					
					box(
						width=NULL,
						plotOutput("simplestaticplot")
					),
					
					box(
						title="Specify support and confidence thresholds:", width=NULL,
						sliderInput("support1", "Minimal support:", min=0.01, max=0.05, value=0.02),
						sliderInput("confidence1", "Minimal confidence:", min = 0.002, max = 0.999, value = 0.2)
					)
				)
			)
		),
		
		tabItem(tabName="table", title = "Interactive table",
			fluidRow(
				column(width = 12, 
				
					box(
						width=NULL,
						dataTableOutput("interactivetable")
					),
				
					box(
						title="Specify support and confidence thresholds:", width=NULL,
						sliderInput("support2", "Minimal support:", min=0.01, max=0.05, value=0.02),
						sliderInput("confidence2", "Minimal confidence:", min = 0.002, max = 0.999, value = 0.2)
					)
					
				)
			)
		),
		
		
		tabItem(tabName="scatterplot", title = "Interactive scatterplot",
			fluidRow(
				column(width = 12, 
				
					box(
						width=NULL,
						plotlyOutput("interactivescatterplot")
					),
					
					box(
						title="Specify support and confidence thresholds:", width=NULL,
						sliderInput("support3", "Minimal support:", min=0.01, max=0.05, value=0.02),
						sliderInput("confidence3", "Minimal confidence:", min = 0.002, max = 0.999, value = 0.2)
					)
					
				)
			)
		),
		
		tabItem(tabName="credits", title = "Acknowledgements",
			fluidRow(
				box(
					"This app was built with the following R libraries:", br(), br(),
					"shiny", br(),
					"shinydashboard", br(),
					"arules", br(),
					"arulesViz", br(),
					"DT", br(),
					"plotly"
				)
			)
			
		)
	)
	
  )
)

