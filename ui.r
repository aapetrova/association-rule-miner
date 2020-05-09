library("shiny")
library("shinydashboard")
library(DT)
library(plotly)

dashboardPage(
  dashboardHeader(title = "Association Rules"),
  dashboardSidebar(
	sidebarMenu(
		menuItem("About", icon=icon("question-circle"), tabName="about"),
		menuItem("Simple Plot", icon=icon("bar-chart"), tabName="staticplot"),
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
				"The visualizations the visitor can generate include static scatter plots, interactive data tables, and interactive scatter plots.", br(),
				"This demonstration uses the ExtendedBakery dataset, which is available here.", br(), br(),
				"Have fun ;)"
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

