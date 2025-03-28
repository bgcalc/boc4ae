server <- function(input, output, session) {

  rv <- reactiveValues()

  observe({

    ## number of Ps
    rv$n <- sum(sapply(1:N, \(i) input[[paste0("p", i)]]))
    if (rv$n <= 1) return()

    ## sort Ps by dice number and targeting value
    dita <- sapply(1:N, \(i) {
      `if`(isTRUE(input[[paste0("p", i)]]),
           as.numeric(paste0(input[[paste0("dice", i)]], input[[paste0("target", i)]])),
           0)
    })
    ord <- order(dita, decreasing = TRUE)
    v <- dita[ord]

    ## read data
    filter <- paste(sapply(1:rv$n, \(j) paste0("p", j, " == v[", j, "]")), collapse = " & ")
    d <- battle_data[[rv$n]][eval(parse(text = filter))]

    ## get winning probabilities
    w <- sapply(1:N, \(i) d[[paste0("w", i)]])
    lapply(1:N, \(i) {
      rv[[paste0("w", i)]] <- w[which(ord == i)]
    })

  })

  lapply(1:N, \(i) {

    ## click on P button
    observeEvent(
      input[[paste0("p", i)]],
      toggle(id = paste0("buttons", i), anim = TRUE),
      ignoreInit = TRUE
    )

    ## output
    output[[paste0("prob", i)]] <- renderUI({
      if (isFALSE(input[[paste0("p", i)]]) || rv$n < 2) return(div())
      div(rv[[paste0("w", i)]], class = "chance")
    })

  })

}
