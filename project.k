/ note that the variable `h refers to the dictionary defined in dictionary.k
/ to get timestamp conversion functions:
\l db

/call the appropriate helper functions based on the query definition 
runQuery:{
  b:x.columns[]@\:`name
  c:x.context
  d: :[c.value~_n;c.value
       @c.value;,c.value
	   c.value]
  e:c.contextType 	   
  :[c.reportType~`pm;applyPmContext[b;d]
    c.reportType~`p;applyPContext[b;d;e]]}


/ start by narrowing down the context 
/ (only look at process models that match the value in the query)
/ so that subsequent operations are only run on the subset of data that 
/ we need. also, preemptively format appropriate columns and return only
/ the columns we need. this function should take in a list of values (process models to look at)
/ and a list of columns.
applyPmContext:{
returnOrLookup[;`ProcessModel;y]' x}

/ pass in the query.context.value as x
pmToProcessIndex:{
if[x~_n;:x]
a:+((h.Process.pm@*:'=h.Process.pm)
   =h.Process.pm)  
f:{if[x[0] _in y;:x[1]]}
/ if[1~#x;f:{if[x~y;:x[1]]}]
/ b:(,/ f[;x]' a) _dv _n
/ :[1~#b;:b@0;:b]}
(,/ f[;x]' a) _dv _n}

/ takes the query as an argument
applyPContext:{
:[z~`pm; returnOrLookup[;`Process;pmToProcessIndex[y]]' x
  z~`p;returnOrLookup[;`Process;y]' x]}

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


rtdHelper:{.+(x;y)}

/ takes three parameters: a list of aliases from the query, the values returned
/ by runQuery, and the length of context values

resultToDictionary:{
:[z~1;rtdHelper[x;y];rtdHelper[x;]' y]}

/ a main function to put things together (at least for now)
main:{
a:runQuery[x]
q:resultToDictionary[(x.columns@\:`alias);a;(~(_n~x.context.value))&(1~#x.context.value)]
c: (x.pagingInfo.startIndex)_ q
d:(:[x.pagingInfo.batchSize<#c;(x.pagingInfo.batchSize)#c;c])
i:.((`startIndex;x.pagingInfo.startIndex;)
(`batchSize;x.pagingInfo.batchSize;)
(`total;#q)
(`result;d))
i}