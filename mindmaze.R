
# ============================================================
# MINDMAZE - THE STATISTICAL QUIZ CHALLENGE
# R LAB MINI PROJECT
# ============================================================

library(shiny)
library(ggplot2)

# ------------------------------------------------------------
# 1. QUESTION DATABASE
# ------------------------------------------------------------

questions <- data.frame(
  
  Category = c(
    rep("General Knowledge", 4),
    rep("Mathematics", 4),
    rep("Statistics", 4),
    rep("Logical Reasoning", 4)
  ),
  
  Question = c(
    "Which planet is known as the Red Planet?",
    "What is the capital of Japan?",
    "Which is the largest ocean?",
    "How many continents are there?",
    
    "What is 15 percent of 200?",
    "What is the square root of 144?",
    "What is 12 multiplied by 8?",
    "What is the value of 7 squared?",
    
    "What is the mean of 2, 4 and 6?",
    "Which measure represents the middle value?",
    "What is the probability of getting heads?",
    "What is the median of 3, 5 and 9?",
    
    "Complete the series: 2, 4, 6, 8, ?",
    "If A is taller than B and B than C, who is shortest?",
    "How many sides does a hexagon have?",
    "Complete the series: 1, 4, 9, 16, ?"
  ),
  
  A = c(
    "Venus", "Beijing", "Atlantic", "Five",
    "20", "10", "84", "14",
    "3", "Mean", "1/4", "3",
    "9", "A", "5", "20"
  ),
  
  B = c(
    "Mars", "Tokyo", "Indian", "Six",
    "30", "12", "96", "49",
    "4", "Median", "1/2", "5",
    "10", "B", "6", "25"
  ),
  
  C = c(
    "Jupiter", "Seoul", "Pacific", "Seven",
    "25", "14", "88", "42",
    "5", "Mode", "1", "7",
    "12", "C", "7", "36"
  ),
  
  D = c(
    "Saturn", "Bangkok", "Arctic", "Eight",
    "40", "16", "92", "56",
    "6", "Range", "1/3", "9",
    "14", "Cannot say", "8", "49"
  ),
  
  Answer = c(
    "B", "B", "C", "C",
    "B", "B", "B", "B",
    "B", "B", "B", "B",
    "B", "C", "B", "C"
  ),
  
  stringsAsFactors = FALSE
)

# ------------------------------------------------------------
# 2. UI DESIGN
# ------------------------------------------------------------

ui <- fluidPage(
  
  tags$head(
    
    tags$title("MindMaze - Quiz Challenge"),
    
    tags$style(HTML("

      body {
        background-color: #F4F1FA;
        font-family: 'Segoe UI', sans-serif;
        color: #30264D;
      }

      .header {
        background: linear-gradient(120deg,
        #211B3C, #7556B8);
        color: white;
        padding: 25px;
        border-radius: 15px;
        margin-top: 20px;
        margin-bottom: 25px;
      }

      .brand {
        font-size: 32px;
        font-weight: 800;
        letter-spacing: 3px;
      }

      .subtitle {
        color: #D9CEF2;
        font-size: 14px;
      }

      .welcome {
        background: linear-gradient(130deg,
        #30234F, #8566C7);
        color: white;
        padding: 45px 25px;
        text-align: center;
        border-radius: 17px;
        margin-bottom: 22px;
      }

      .welcome h1 {
        font-size: 40px;
        font-weight: 800;
      }

      .welcome p {
        color: #E5DDF5;
        font-size: 16px;
      }

      .card {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(40,25,70,0.06);
        margin-bottom: 20px;
      }

      .metric {
        background: white;
        text-align: center;
        padding: 22px 10px;
        border-radius: 14px;
        box-shadow: 0 3px 12px rgba(40,25,70,0.06);
        margin-bottom: 15px;
      }

      .metric-value {
        font-size: 29px;
        font-weight: 800;
        color: #7556B8;
      }

      .metric-label {
        color: #8A829B;
        font-size: 12px;
        margin-top: 5px;
      }

      .question {
        font-size: 23px;
        font-weight: 700;
        margin-bottom: 20px;
        color: #30234F;
      }

      .progress {
        height: 10px;
        background: #EAE5F3;
        border-radius: 10px;
      }

      .progress-bar {
        background: #8061C3;
      }

      .btn-primary {
        background: #7556B8;
        border: none;
        border-radius: 9px;
        padding: 11px 22px;
        font-weight: 600;
      }

      .btn-primary:hover {
        background: #523A8C;
      }

      .form-control {
        border-radius: 8px;
      }

      .radio label {
        display: block;
        background: #F4F1FA;
        padding: 12px 15px;
        border-radius: 9px;
        margin-bottom: 9px;
        cursor: pointer;
        width: 100%;
      }

      .radio label:hover {
        background: #E9E1F6;
      }

      .result-banner {
        background: linear-gradient(130deg,
        #30234F, #8566C7);
        color: white;
        text-align: center;
        padding: 30px;
        border-radius: 16px;
        margin-bottom: 20px;
      }

      .result-banner h1 {
        font-size: 45px;
        font-weight: 800;
      }

      .result-banner p {
        color: #E5DDF5;
      }

      .footer {
        text-align: center;
        padding: 22px;
        color: #9991A8;
        font-size: 12px;
      }

      h3, h4 {
        font-weight: 700;
      }

    "))
  ),
  
  # HEADER
  
  fluidRow(
    column(
      12,
      
      div(
        class = "header",
        
        div(class = "brand", "MINDMAZE"),
        
        div(
          class = "subtitle",
          "THE STATISTICAL QUIZ CHALLENGE"
        )
      )
    )
  ),
  
  # MAIN LAYOUT
  
  sidebarLayout(
    
    sidebarPanel(
      width = 3,
      
      h4("QUIZ SETTINGS"),
      
      textInput(
        "player",
        "Enter your name",
        placeholder = "Your name..."
      ),
      
      selectInput(
        "category",
        "Select Category",
        
        choices = c(
          "General Knowledge",
          "Mathematics",
          "Statistics",
          "Logical Reasoning",
          "Mixed Challenge"
        )
      ),
      
      hr(),
      
      actionButton(
        "start",
        "START QUIZ",
        class = "btn-primary",
        width = "100%"
      ),
      
      br(), br(),
      
      helpText(
        "Choose a category and challenge yourself!"
      )
    ),
    
    mainPanel(
      width = 9,
      
      uiOutput("main_content")
    )
  ),
  
  div(
    class = "footer",
    "MINDMAZE | THINK. LEARN. REPEAT."
  )
)

# ------------------------------------------------------------
# 3. SERVER
# ------------------------------------------------------------

server <- function(input, output, session) {
  
  # Store quiz information
  
  rv <- reactiveValues(
    
    started = FALSE,
    finished = FALSE,
    
    index = 1,
    
    selected = NULL,
    
    answers = character(),
    marks = numeric(),
    
    player = "",
    category = ""
  )
  
  # ----------------------------------------------------------
  # START QUIZ
  # ----------------------------------------------------------
  
  observeEvent(input$start, {
    
    if (is.null(input$player) ||
        trimws(input$player) == "") {
      
      showNotification(
        "Please enter your name!",
        type = "warning"
      )
      
      return()
    }
    
    rv$player <- trimws(input$player)
    
    rv$category <- input$category
    
    if (input$category == "Mixed Challenge") {
      
      quiz <- questions
      
    } else {
      
      quiz <- questions[
        questions$Category == input$category,
      ]
    }
    
    # Randomise questions
    
    rv$selected <- quiz[
      sample(nrow(quiz)),
    ]
    
    rv$answers <- rep(
      NA_character_,
      nrow(rv$selected)
    )
    
    rv$marks <- rep(
      0,
      nrow(rv$selected)
    )
    
    rv$index <- 1
    
    rv$finished <- FALSE
    rv$started <- TRUE
    
    updateRadioButtons(
      session,
      "answer",
      selected = character(0)
    )
    
  })
  
  # ----------------------------------------------------------
  # SUBMIT ANSWER
  # ----------------------------------------------------------
  
  observeEvent(input$submit, {
    
    req(rv$started)
    req(!rv$finished)
    
    if (is.null(input$answer) ||
        input$answer == "") {
      
      showNotification(
        "Please select an answer!",
        type = "warning"
      )
      
      return()
    }
    
    i <- rv$index
    
    rv$answers[i] <- input$answer
    
    if (input$answer == rv$selected$Answer[i]) {
      
      rv$marks[i] <- 1
      
      showNotification(
        "Correct answer! Great job!",
        type = "message"
      )
      
    } else {
      
      rv$marks[i] <- 0
      
      showNotification(
        "Incorrect! Keep trying.",
        type = "warning"
      )
    }
    
    if (i == nrow(rv$selected)) {
      
      rv$finished <- TRUE
      
    } else {
      
      rv$index <- i + 1
      
      updateRadioButtons(
        session,
        "answer",
        selected = character(0)
      )
    }
    
  })
  
  # ----------------------------------------------------------
  # PLAY AGAIN
  # ----------------------------------------------------------
  
  observeEvent(input$restart, {
    
    rv$started <- FALSE
    rv$finished <- FALSE
    rv$index <- 1
    
  })
  
  # ----------------------------------------------------------
  # RESULTS DATA
  # ----------------------------------------------------------
  
  results <- reactive({
    
    req(rv$finished)
    
    data.frame(
      
      Question_Number = 1:length(rv$marks),
      
      Category = rv$selected$Category,
      
      Question = rv$selected$Question,
      
      Your_Answer = rv$answers,
      
      Correct_Answer = rv$selected$Answer,
      
      Marks = rv$marks,
      
      stringsAsFactors = FALSE
    )
    
  })
  
  # ----------------------------------------------------------
  # MAIN SCREEN
  # ----------------------------------------------------------
  
  output$main_content <- renderUI({
    
    # WELCOME SCREEN
    
    if (!rv$started) {
      
      return(
        
        tagList(
          
          div(
            class = "welcome",
            
            h1("Welcome to MindMaze!"),
            
            p("Challenge your mind. Test your knowledge."),
            
            p("THINK SMART. PLAY SMARTER.")
          ),
          
          fluidRow(
            
            column(
              4,
              
              div(
                class = "metric",
                
                div(
                  class = "metric-value",
                  "04"
                ),
                
                div(
                  class = "metric-label",
                  "QUIZ CATEGORIES"
                )
              )
            ),
            
            column(
              4,
              
              div(
                class = "metric",
                
                div(
                  class = "metric-value",
                  "16"
                ),
                
                div(
                  class = "metric-label",
                  "TOTAL QUESTIONS"
                )
              )
            ),
            
            column(
              4,
              
              div(
                class = "metric",
                
                div(
                  class = "metric-value",
                  "100%"
                ),
                
                div(
                  class = "metric-label",
                  "CHALLENGE YOURSELF"
                )
              )
            )
          ),
          
          div(
            class = "card",
            
            h3("Ready to test your knowledge?"),
            
            p(
              "Select a quiz category from the left panel ",
              "and start your challenge."
            ),
            
            p(
              "Your final report will include statistical ",
              "calculations and graphical analysis."
            )
          )
        )
      )
    }
    
    # QUIZ SCREEN
    
    if (rv$started && !rv$finished) {
      
      i <- rv$index
      
      total <- nrow(rv$selected)
      
      progress <- round((i / total) * 100)
      
      q <- rv$selected[i, ]
      
      return(
        
        tagList(
          
          div(
            class = "card",
            
            h4(
              paste("Welcome,", rv$player, "!")
            ),
            
            p(
              paste("Category:", rv$category)
            ),
            
            fluidRow(
              
              column(
                6,
                
                strong(
                  paste("Question", i, "of", total)
                )
              ),
              
              column(
                6,
                
                div(
                  style = "text-align:right;",
                  
                  strong(
                    paste(
                      "Score:",
                      sum(rv$marks)
                    )
                  )
                )
              )
            ),
            
            br(),
            
            div(
              class = "progress",
              
              div(
                class = "progress-bar",
                
                style = paste0(
                  "width:", progress, "%;"
                )
              )
            )
          ),
          
          div(
            class = "card",
            
            div(
              class = "question",
              q$Question
            ),
            
            radioButtons(
              
              "answer",
              
              "Choose your answer:",
              
              choices = setNames(
                
                c("A", "B", "C", "D"),
                
                c(
                  paste("A.", q$A),
                  paste("B.", q$B),
                  paste("C.", q$C),
                  paste("D.", q$D)
                )
              ),
              
              selected = character(0)
            ),
            
            br(),
            
            actionButton(
              
              "submit",
              
              if (i == total) {
                "FINISH QUIZ"
              } else {
                "SUBMIT & NEXT"
              },
              
              class = "btn-primary",
              width = "100%"
            )
          )
        )
      )
    }
    
    # RESULT SCREEN
    
    if (rv$finished) {
      
      score <- sum(rv$marks)
      
      total <- length(rv$marks)
      
      accuracy <- mean(rv$marks) * 100
      
      mean_score <- mean(rv$marks)
      
      median_score <- median(rv$marks)
      
      sd_score <- sd(rv$marks)
      
      if (accuracy >= 80) {
        
        performance <- "EXCELLENT"
        
        message <- "Outstanding! You have a sharp mind!"
        
      } else if (accuracy >= 60) {
        
        performance <- "GOOD"
        
        message <- "Well done! Keep practising!"
        
      } else if (accuracy >= 40) {
        
        performance <- "AVERAGE"
        
        message <- "Good attempt! You can improve!"
        
      } else {
        
        performance <- "NEEDS IMPROVEMENT"
        
        message <- "Keep learning and try again!"
      }
      
      return(
        
        tagList(
          
          div(
            class = "result-banner",
            
            h4("QUIZ COMPLETED"),
            
            h1(
              paste(score, "/", total)
            ),
            
            h3(performance),
            
            p(message)
          ),
          
          fluidRow(
            
            column(
              3,
              
              div(
                class = "metric",
                
                div(
                  class = "metric-value",
                  paste0(round(accuracy, 1), "%")
                ),
                
                div(
                  class = "metric-label",
                  "ACCURACY"
                )
              )
            ),
            
            column(
              3,
              
              div(
                class = "metric",
                
                div(
                  class = "metric-value",
                  score
                ),
                
                div(
                  class = "metric-label",
                  "CORRECT ANSWERS"
                )
              )
            ),
            
            column(
              3,
              
              div(
                class = "metric",
                
                div(
                  class = "metric-value",
                  total - score
                ),
                
                div(
                  class = "metric-label",
                  "INCORRECT ANSWERS"
                )
              )
            ),
            
            column(
              3,
              
              div(
                class = "metric",
                
                div(
                  class = "metric-value",
                  round(mean_score, 2)
                ),
                
                div(
                  class = "metric-label",
                  "MEAN SCORE"
                )
              )
            )
          ),
          
          div(
            class = "card",
            
            h3("Statistical Analysis"),
            
            p(
              paste(
                "Mean:",
                round(mean_score, 2)
              )
            ),
            
            p(
              paste(
                "Median:",
                round(median_score, 2)
              )
            ),
            
            p(
              paste(
                "Standard Deviation:",
                round(sd_score, 2)
              )
            ),
            
            p(
              paste(
                "Maximum Marks:",
                max(rv$marks)
              )
            ),
            
            p(
              paste(
                "Minimum Marks:",
                min(rv$marks)
              )
            )
          ),
          
          fluidRow(
            
            column(
              6,
              
              div(
                class = "card",
                
                h4("Correct vs Incorrect"),
                
                plotOutput(
                  "pie_plot",
                  height = "280px"
                )
              )
            ),
            
            column(
              6,
              
              div(
                class = "card",
                
                h4("Category-wise Performance"),
                
                plotOutput(
                  "bar_plot",
                  height = "280px"
                )
              )
            )
          ),
          
          div(
            class = "card",
            
            h3("Your Answer Report"),
            
            tableOutput("answer_table"),
            
            br(),
            
            downloadButton(
              "download",
              "DOWNLOAD REPORT",
              class = "btn-primary"
            ),
            
            br(), br(),
            
            actionButton(
              "restart",
              "PLAY AGAIN",
              class = "btn-primary"
            )
          )
        )
      )
    }
    
  })
  
  # ----------------------------------------------------------
  # 4. PIE CHART
  # ----------------------------------------------------------
  
  output$pie_plot <- renderPlot({
    
    req(rv$finished)
    
    chart_data <- data.frame(
      
      Answer = c("Correct", "Incorrect"),
      
      Count = c(
        sum(rv$marks),
        length(rv$marks) - sum(rv$marks)
      )
    )
    
    ggplot(
      chart_data,
      aes(x = "", y = Count, fill = Answer)
    ) +
      
      geom_col(width = 1, color = "white") +
      
      coord_polar(theta = "y") +
      
      scale_fill_manual(
        values = c(
          "Correct" = "#42B883",
          "Incorrect" = "#E76F91"
        )
      ) +
      
      theme_void() +
      
      labs(fill = NULL)
  })
  
  # ----------------------------------------------------------
  # 5. CATEGORY-WISE BAR CHART
  # ----------------------------------------------------------
  
  output$bar_plot <- renderPlot({
    
    req(rv$finished)
    
    report <- aggregate(
      
      Marks ~ Category,
      
      data = results(),
      
      FUN = mean
    )
    
    report$Accuracy <- report$Marks * 100
    
    ggplot(
      report,
      aes(
        x = reorder(Category, Accuracy),
        y = Accuracy
      )
    ) +
      
      geom_col(
        fill = "#8061C3",
        width = 0.65
      ) +
      
      geom_text(
        aes(label = paste0(round(Accuracy), "%")),
        hjust = -0.2
      ) +
      
      coord_flip() +
      
      scale_y_continuous(
        limits = c(0, 115)
      ) +
      
      labs(
        x = NULL,
        y = "Accuracy (%)"
      ) +
      
      theme_minimal(base_size = 12)
  })
  
  # ----------------------------------------------------------
  # 6. ANSWER TABLE
  # ----------------------------------------------------------
  
  output$answer_table <- renderTable({
    
    req(rv$finished)
    
    results()[
      ,
      c(
        "Question_Number",
        "Category",
        "Your_Answer",
        "Correct_Answer",
        "Marks"
      )
    ]
    
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  # ----------------------------------------------------------
  # 7. DOWNLOAD REPORT
  # ----------------------------------------------------------
  
  output$download <- downloadHandler(
    
    filename = function() {
      
      paste0(
        "MindMaze_",
        gsub(
          "[^A-Za-z0-9_-]",
          "_",
          rv$player
        ),
        "_Results.csv"
      )
    },
    
    content = function(file) {
      
      write.csv(
        results(),
        file,
        row.names = FALSE
      )
    }
  )
  
}

# ------------------------------------------------------------
# 8. RUN APPLICATION
# ------------------------------------------------------------

shinyApp(ui, server)

