/ note that the variable `h refers to the dictionary defined in dictionary.k
/ to get timestamp conversion functions:
\l db

/ this function returns the indices of every value in a matching a value in b
/ taking the result of the function and doing _dv _n gives a nice vector
whereAll:{[a;b];{:[|/a[x]~/:b;x]}' !#a}

/ the functions in the contextValue map should be called on query.context.value
/ note to self: in the future, define the dictionary using a more readable syntax.
/ if there's time at the end, re-write this block for readability.
contextValue:.((`pm
  .,(`pm;{ :[x~_n;!#h.ProcessModel.name
        @x;,x
		x]};)
	)
	(`p
	  .((`p;{ :[x~_n;!#h.Process.name
        @x;,x
		x]};)
		(`pm;{tmp:whereAll[h.Process.pm;x] _dv _n
		    :[(tmp~())&(~(x~_n));:() 
			tmp~();!#h.Process.name
            @tmp;,tmp
		    tmp]};))
	)
	(`t
	.((`pm;{tmp:whereAll[h.Process.pm;x] _dv _n
		   :[(tmp~())&(~(x~_n));:() 
			tmp~();m:!#h.Process.name
            @tmp;m:,tmp
		    m:tmp]
			,/ h.Process.tasks[m]};)
	  (`p;{,/ h.Process.tasks[x]};)
	  (`t;{:[x~_n;!#h.Task.name
           @x;,x
		   x]};))	
	))
	
aggOperation[`count]:{#x}
aggOperation[`min]:{,.d.sz (&/.d.zs' x)}
aggOperation[`max]:{,.d.sz (|/.d.zs' x)}
aggOperation[`avg]:{tmp:.d.zs' x;,.d.sz (+/tmp)%#tmp}

/ returnOrLookup retrieves the value from the specified column,
/ for the specified report type, and formats the result if necessary.
/ if there's time later, convert this to a map, with the appropriate function at each key	
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
	x~`assignee;h.User.username[a]
    a]}
	
	
/ main function, takes in the query and calls the other various helper functions

main:{[query]
  c:query.context
  cn:query.columns[]@\:`name
  a:query.columns[]@\:`alias
  cv:(contextValue@(c.reportType))@c.contextType
  p:query.pagingInfo.column
  s:query.pagingInfo.startIndex
  b:query.pagingInfo.batchSize
  icg:query.columns[]@\:`groupBy
  aggops:query.columns[]@\:`aggregation
  :[c.reportType~`pm;d:`ProcessModel
    c.reportType~`p;d:`Process
	c.reportType~`t;d:`Task]
  :[(cn~(;;))|(cn~(;))|(cn~_n);' `noColumnSpecified
    (-1+#(!h@d))<(|/(!h@d)?/: cn);' `invalidColumn
    ~(#=cn)~#cn;' `duplicateColumn
    ~(#=a)~#a;' `duplicateAlias
	cv~_n;' `invalidContext
	(p~_n)|(#cn)~cn?p;' `pagingColumnInvalid]
  e:cv[c.value]
  if[1~|/icg
    cwg:cn@(=icg)@~*?icg
    cwagg:cn@(=icg)@*?icg
	galias:a@(=icg)@~*?icg
	aggalias:a@(=icg)@*?icg
	agg:aggops@(=icg)@*?icg
	agg:{:[x~_n;:`count;:x]}' agg
	groups: :[1~#cwg;returnOrLookup[;d;e]'cwg
	         (returnOrLookup[;d;e]'*cwg),'/:returnOrLookup[;d;e]'1_ cwg]
	gi: =,/groups
	cn:cwagg
	resagg:(returnOrLookup[;d;e]' cwagg)@\:gi
	resagg:,:'+{aggOperation[agg[x]]' resagg[x]}' !#agg
	resg:,:'*:'(,/groups)[gi]
    r:resg,'resagg
	a:galias,aggalias
    result:a,'/:,/'r
	total:#result
	result:.:'result]
  if[0~|/icg
	sr::[`asc~query.pagingInfo.order;<((h@d)@p)[e];>((h@d)@p)[e]]
	total:#sr
	:[(b~-1)|(-1+#sr)<(s+b);sr:s_ sr;sr:sr@s+!b]	
	r:returnOrLookup[;d;e@sr]'cn
	if[1<#r;r:+r]
	result:{.+(a;x)}' r]
  qr:.((`startIndex;s;)
      (`batchSize;b;)
      (`total;total)
      (`result;result))
  qr}