

rankhospital <- function(state, outcome, num = "best") {
    ## Read Outcome Data 
     # Set up data map for outcomes
     outcomes <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

     #Store name of hospital name variable
     hn <- "Hospital.Name"

     # Read in the CSV data
     o <- read.csv( "outcome-of-care-measures.csv",  na.strings="Not Available" )

     # Check state/outcome are valid
     if(! outcome %in% names(outcomes))   stop("invalid outcome")
     if(! state %in% o[,"State"] )   stop("invalid state")


     # Get only the outcome data that we need
     outcome_data <- o[,c(2,7,outcomes[outcome])]

     # Replace spaces in the column name and fix column name the same
     oc <-  sub( " ", ".",  outcome)
     names(outcome_data)[3] <- oc

     state_outcomes <- outcome_data[outcome_data$State == state,]
     
     # Remove NA
     state_outcomes <- state_outcomes[!is.na(state_outcomes[,3]),]
     
     # Order by outcome, then hospital name
     ranked <- arrange_(state_outcomes, oc, hn )
     
     num <- if(num == "best") { 1 }
     else if(num == "worst") { length(ranked[,1])  }
     else num
     
     ## Return hospital name in that state given the rank 30-day rate
     as.character(ranked[num,hn])
}

