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
