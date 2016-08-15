/ note that the variable `h refers to the dictionary defined in dictionary.k
/call the appropriate helper functions based on the query definition 
runQuery:{
:[x.context.reportType~`pm;+applyPmContext[x.columns[]@\:`name;x.context.value]]}
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
a:+((h.Process.pm@*:'=h.Process.pm)
   =h.Process.pm)
b:()    
f:{if[x[0] _in y;b,:x[1]]}
f[;x]' a
b}

/ takes the query as an argument
applyPContext:{
:[x.context.contextType~`pm; returnOrLookup[;`Process;pmToProcessIndex[x.context.value]]' x.columns[]@\:`name;x.context.contextType~`p;returnOrLookup[;`Process;x.context.value]' x.columns[]@\:`name];' `invalidContextType}

returnOrLookup:{
:[x~`creator;h.User.username[((h@y).`creator)[z]];(x~`pvs)&(y~`ProcessModel);h.ProcessModelVariable.name[((h@y).`pvs)[z]];x~`nodes;h.ProcessModelNode.name[((h@y).`nodes)[z]];((h@y)@x)[z]]}

rtdHelper:{.+(x;y)}

/ takes two parameters: a list of aliases from the query, and the values returned
/ by runQuery

resultToDictionary:{
rtdHelper[x;]' y}

/ a main function to put things together (at least for now)
main:{
a:runQuery[x]
q:resultToDictionary[(x.columns@\:`alias);a]
c: (x.pagingInfo.startIndex)_ q
d:(:[x.pagingInfo.batchSize<#c;(x.pagingInfo.batchSize)#c;c])
i:.((`startIndex;x.pagingInfo.startIndex;)
(`batchSize;x.pagingInfo.batchSize;)
(`total;#q)
(`result;d))
i}