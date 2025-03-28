ui <- bootstrapPage(

  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "app.css")),
  useShinyjs(),

  lapply(1:N, \(i) {

    div(
      class = "pblock",

      ## P button and winning probability
      div(
        class = "prow",
        div(
          class = "prowdiv1",
          switchInput(
            inputId = paste0("p", i), value = (i <= 2),
            onLabel = paste0("P", i), offLabel = paste0("P", i)
          )
        ),
        div(
          class = "prowdiv2",
          uiOutput(outputId = paste0("prob", i))
        )
      ),

      ## dice number and targeting value buttons
      {
        block <-
          div(
            id = paste0("buttons", i),
            radioGroupButtons(
              inputId = paste0("dice", i), label = "#",
              choiceNames = 1:max_dice, choiceValues = 1:max_dice, selected = 1,
              individual = FALSE, status = "success", size = "sm"
            ),
            radioGroupButtons(
              inputId = paste0("target", i), label = "T",
              choiceNames = 1:max_target, choiceValues = 1:max_target, selected = 1,
              individual = FALSE, status = "danger", size = "sm"
            )
          )
        if (i <= 2) block else hidden(block)
      }
    )

  })

)
