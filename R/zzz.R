.onLoad = function(libname, pkgname){ 
  # default options
  evalq(opts_knit$set(kfigr.link=TRUE, kfigr.prefix=FALSE), 
       envir=getNamespace('knitr'))
  # anchor hook definition
  evalq(
    knit_hooks$set(anchor = function(before, options, envir) {
      if (before){  
        invisible(index(options$label, options$anchor))
        paste('<a name="', options$label, '"></a>', sep='')
      }
    }), envir=getNamespace('knitr'))

  # Auto-Generate Label
  evalq(
    knit_hooks$set(autolab = function(before, options, envir) {
      if (before){
        if(autolab){
          invisible(index(options$label, options$anchor))
          lab <- figr(options$label,link=FALSE,prefix=TRUE,type=options$anchor)
          lab <- paste(lab,". ",sep='')
          return(lab)
          }
        }}), envir=getNamespace('knitr'))

  anchorenv <- new.env(parent=getNamespace("kfigr"))
  assign("anchorenv", anchorenv, envir=getNamespace("kfigr"))
  assign("types", character(0), envir=anchorenv)
  assign("index", list(), envir=anchorenv)
  assign("history", list(), envir=anchorenv)
}
