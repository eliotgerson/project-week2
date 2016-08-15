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