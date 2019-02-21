

rankall <- function(outcome, num = "best") {
    ## Read Outcome Data 
     # Set up data map for outcomes
     outcomes <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

     #Store name of hospital name variable
     hn <- "Hospital.Name"

     # Read in the CSV data
     o <- read.csv( "outcome-of-care-measures.csv",  na.strings="Not Available" )

     # Check outcome are valid
     if(! outcome %in% names(outcomes))   stop("invalid outcome")


     # Get only the outcome data that we need
     outcome_data <- o[,c(2,7,outcomes[outcome])]

     # Replace spaces in the column name and fix column name the same
     oc <-  sub( " ", ".",  outcome)
     
     names(outcome_data)[3] <- oc
     
     outcome_data <- arrange_(outcome_data, hn )
     states <- unique(outcome_data$State)
     states <- sort(states, decreasing = FALSE)
     
     rank <- data.frame(hospital = character(), state = character())
     
     r <- num
     
     for(state in states)
     {
          
          
          state_outcomes <- outcome_data[outcome_data$State == state,]
          
          # Remove NA
          state_outcomes <- state_outcomes[!is.na(state_outcomes[,3]),]
          
          # Order by outcome, then hospital name
          ranked <- arrange_(state_outcomes, oc, hn )
          
          r <- if(r == "best") { 1 }
          else if(r == "worst") { length(ranked[,1])  }
          else r
          
          ## Return hospital name in that state given the rank 30-day rate
          state_rank <- ranked[r,c(1,2)]
          names(state_rank) <- c("hospital","state")
          
          if ( ! is.na( state_rank[1] ) )
               rank <- rbind(rank, state_rank[,c(1,2)])
          else
          {
               df <- data.frame(NA, state)
               names(df) <- c("hospital","state")
               
               rank <- rbind(rank, df)
          }
     }

     row.names(rank) <- rank$state
     rank
}

