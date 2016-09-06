
feature.importance <- function(data, column.y){
  y <- data[, column.y]
  data <- data[, -column.y]
  names <- names(data)
  feature.types <- table(sapply(data, class))
  features <- c()
  test <- c()
  statistic <- numeric()
  p.values <- numeric()
  
  ## Quantitative Response
  
  if (class(y) %in% c("numeric", "integer")){
    for (i in 1: ncol(data)){
      
      # Quantitative Feature
      if (class(data[, i]) %in% c("numeric", "integer")){
        features <- c(features, names[i])
        cortest <- cor.test(y, data[, i])
        test <- c(test, "Correlation")
        statistic <- c(statistic, round(cortest$statistic, 2))
        p.values <- c(p.values, round(cortest$p.value, 4))
        
      }  
      
      # Qualitative Feature
      else if (class(data[, i]) %in% c("character", "factor")){
        features <- c(features, names[i])
        kwtest <- kruskal.test(as.numeric(y), factor(data[, i]))
        test <- c(test, "Kruskal-Wallis")
        statistic <- c(statistic, round(kwtest$statistic, 2))
        p.values <- c(p.values, round(kwtest$p.value, 4))
      }
    }
  } 
  
  ## Qualitative Response
  
  if (class(y) %in% c("character", "factor")){
    for (i in 1: ncol(data)){
      
      # Quantitative Feature
      if (class(data[, i]) %in% c("numeric", "integer")){
        features <- c(features, names[i])
        kwtest <- kruskal.test(factor(data[, i]), as.numeric(y))
        test <- c(test, "Kruskal-Wallis")
        statistic <- c(statistic, round(kwtest$statistic, 2))
        p.values <- c(p.values, round(kwtest$p.value, 4))
      } 
      
      # Qualitative Feature
      else if (class(data[, i]) %in% c("character", "factor")){
        
        t <- table(data[, i], y)
        
        if (length(t[t < 5]) == 0){
          features <- c(features, names[i])
          chisq <- chisq.test(data[, i], y)
          test <- c(test, "Chi-squared")
          statistic <- c(statistic, round(chisq$statistic, 2))
          p.values <- c(p.values, round(chisq$p.value, 4))
        }
        
#         if (length(t[t < 5]) > 0){
#           fishertest <- try(fisher.test(data[, i], y),silent = T)
#           test <- c(test, "Fisher's Exact")
#           statistic <- try(c(statistic, round(fishertest$statistic, 2)), silent = T)
#           p.values <- try(c(p.values, round(fishertest$p.value, 4)), silent = T)
#         }
      }
    }
  }
  
  output <- as.data.frame(cbind(features, test, 
                                statistic, 
                                p.values),
                          row.names = F)
  return(output)
  
}

feature.importance(iris, 5)
feature.importance(default.data, 25)


