
# Set up the state environment
.HWenv <- new.env()
assign("problem",1,envir=.HWenv)
assign("item",0,envir=.HWenv)
assign("thisproblem","NOT.INITIALIZED",envir=.HWenv)
assign("thisitem","NOT.INITIALIZED",envir=.HWenv)
assign("thislabel",0,envir=.HWenv)
#' Start a document
QuizR.start <- function(docname){
    res = paste(
    "<link rel='stylesheet' href='testing.css' type='text/css' media='screen'/>",
    "<script src='jquery-1.7.2.js' type='text/javascript'></script>",
    "<script src='testing.js' type='text/javascript'></script>",
    "<span class='QpageHeader'></span>",
    sep="")
    return(res)
}
#' Labelling of problems and items
nextProb <- function(name=NULL){
  if (is.null(name)){ # automatic numbering
    name = get("problem",envir=.HWenv)
    assign("problem",1+name,envir=.HWenv)
  }
  assign("thisproblem",name,envir=.HWenv)
  assign("item",0,envir=.HWenv)
  assign("thislabel",0,envir=.HWenv)
  return(paste("<span id='",name,"' class='Qproblem'></span>",sep=""))
}
nextItem <- function(name){
  # automatic numbering sequence
  nm <- get("item",envir=.HWenv)
  assign("item",1+nm,envir=.HWenv)
  if (missing(name)){ # use the automatic number
    name = get("item",envir=.HWenv)
  }
  assign("thisitem",name,envir=.HWenv)
  return(name)
}
nextLabel <- function(val=NULL){
  if (is.null(val)) val <- get("thislabel",envir=.HWenv)
  assign("thislabel",1+val,envir=.HWenv)
  return(1+val)
}

#' Single choice, part of an item
QuizChoice <- function(text="TEXT",
                     prob=get("thisproblem",envir=.HWenv), # should this be null?
                     item=get("thisitem",envir=.HWenv),
                     hint="",
                     right=FALSE){
  right <- ifelse(right,"Yes","No")
  res = paste(
    "<span class='Qchoice' id='",item,"'>",
    text,"<span class='Qhint'>",
    hint,"</span><span class='Qright'>",right,
    "</span></span>",
    sep="")
  return(res)
}
#' True or false
TorF <- function(ans=FALSE,
                 prob=get("thisproblem",envir=HWenv), # should this be null?
                 item=nextItem(),
                 hint="(hint)"){
  t_hint<-ifelse(ans,'',hint)
  f_hint<-ifelse(ans,hint,'')
  res <- paste("<span class='Qset' id='",item,"'>",sep="")
  res <- paste(res,QuizChoice("True",right=ans,hint=t_hint),
               "or",QuizChoice("False",right=!ans,hint=f_hint),
               sep="")
  res <- paste(res,"</span>",sep="") #finish up the Qset
  return(res)
}
#' Select one from many short choices
manyChoices <- function(...,
                        prob=get("thisproblem",envir=.HWenv),
                        item = nextItem(),
                        hint = "") {
  res <- paste("<span class='Qset' id='",item,"'>",sep="")
  choices <- list(...)
  nms <- names(choices)
  for (k in 1:length(choices)) {
    res = paste(res, 
                QuizChoice(choices[[k]],right=nms[k]=="correct",hint=hint))
  }
  res <- paste(res,"</span>",sep="") #finish up the Qset
  return(res)
}      