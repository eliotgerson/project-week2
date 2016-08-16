/ note that the variable `h refers to the dictionary defined in dictionary.k
/ to get timestamp conversion functions:
\l db

/ this function returns the indices of every value in a matching a value in b
/ taking the result of the function and doing _dv _n gives a nice vector
whereAll:{[a;b];{:[|/a[x]~/:b;x]}' !#a}

/ the functions in the contextValue map should be called on query.context.value
contextValue:.((`pm
  .,(`pm;{:[x~_n;!#h.ProcessModel.name
            @x;,x
		    x]};)
	)
	(`p
	  .((`p;{:[x~_n;!#h.Process.name
            @x;,x
		    x]};)
		(`pm;{tmp:whereAll[h.Process.pm;x] _dv _n
		      :[tmp~();!#h.Process.name
            @tmp;,tmp
		    tmp]};))
	))

/ returnOrLookup retrieves the value from the specified column,
/ for the specified report type, and formats the result if necessary	
returnOrLookup:{
  a:((h@y)@x)[z]
  :[x~`creator;h.User.username[a]
   (x~`pvs)&(y~`ProcessModel);h.ProcessModelVariable.name[a]
    x~`nodes;h.ProcessModelNode.name[a]
   (x~`pvs)&(y~`Process);h.ProcessVariable.name[a]
    x~`initiator;h.User.username[a]
   (x~`tsm)|(x~`tsc)|(x~`ts_accepted)|(x~`ts_completed)|(x~`ts_created);.d.sz' a
    x~`tasks;h.Task.name[a]
    x~`pm;h.ProcessModel.name[a]
    a]}
	
	
/ main function, takes in the query and calls the other various helper functions

main:{[query]
  c:query.context
  a:query.columns[]@\:`alias
  :[c.reportType~`pm;d:`ProcessModel
    c.reportType~`p;d:`Process
	c.reportType~`t;d:`Task]
  e:((contextValue@(c.reportType))@c.contextType)[c.value]
  cn:query.columns[]@\:`name
  r:returnOrLookup[;d;e]'cn
  if[1<#r;r:+r]
  result:{.+(a;x)}' r
  qr:.((`startIndex;query.pagingInfo.startIndex;)
      (`batchSize;query.pagingInfo.batchSize;)
      (`total;#result)
      (`result;result))
  qr}