h:.((`User
   .((`username;`bugs.bunny`daffy.duck`elmer.fudd;)         / symbol - username
     (`fname;`bugs`daffy`elmer;)            / symbol - first name
     (`lname;`bunny`duck`fudd;))           / symbol - last name
   )
  (`ProcessModelNode
   .((`name;`addExpenses`lookupData`isValid`start`end;)             / symbol 
     (`x;0,2,5,4,6;)                / integer - coordinate x
     (`y;3,9,2,40,12;)                / integer - coordinate y
     (`chained;1,0,0,0,0;))         / integer [0-1]
   )
  (`ProcessModelVariable
   .((`name;`id`amount`total`city;)             / symbol 
     (`type;0,1,1,2;))            / index - key to `Type table
   )
  (`ProcessModel
   .((`name;`expenseReport`fleetManager`docLookup`requestNew;)             / symbol 
     (`tsm;2.0,3.7,1.5,4.4;)            / double - timestamp of last update
     (`tsc;0.6,6.2,5.4,3.1;)            / double - timestamp of creation
     (`creator;0,0,2,1;)          / index - key to `User table
     (`uuid;("a4556fgt";"poljj6ll";"56yyg4re";"ok877ygt");)              / charray - Universal Identified
     (`cleanup;0,1,1,0;)          / integer [0-1]
     (`pvs;(0,2;,1;0,1,2;0,1,2,3);)               / indices - keys to `ProcessModelVariable
     (`nodes;(0,3,4;0,1,3,4;2,3,4;0,1,3,4);))            / indices - keys to `ProcessModelNode
   )
  (`ProcessVariable
   .((`name;0#`;)             / symbol
     (`value;0#0;))           / index - key to `Data
   )
  (`Task
   .((`name;0#`;)             / symbol
     (`ts_accepted;0#0.0;)    / double - timestamp accepted
     (`ts_completed;0#0.0;)   / double - timestamp completed
     (`ts_created;0#0.0;)     / double - timestamp created
     (`assignee;0#0;))        / index - key to `User table
   )
  (`Process
   .((`name;0#`;)             / symbol
     (`tsm;0#0.0;)            / double - timestamp of last update
     (`tsc;0#0.0;)            / double - timestamp of creation
     (`initiator;0#0;)        / index - key to `User table
     (`pvs;();)               / indices - keys to `ProcessVariable
     (`tasks;();)             / indices - keys to `Task
     (`pm;0#0;))              / index - key to ProcessModel
   )
  (`Type
   .,(`name
      `INTEGER `DOUBLE `STRING `DATE
      )
   )
  (`Data
   .((`type;0#0;)             / index - key to `Type
     (`value;();))            / any type - the actual value stored
   ))