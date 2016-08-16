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
     (`pvs;(0,2;1;0,1,2;0,1,2,3);)               / indices - keys to `ProcessModelVariable
     (`nodes;(0,3,4;0,1,3,4;2,3,4;0,1,3,4);))            / indices - keys to `ProcessModelNode
   )
  (`ProcessVariable
   .((`name;`id`amount`total`city;)             / symbol
     (`value;0,1,2,3;))           / index - key to `Data
   )
  (`Task
   .((`name;`updateExpenses`checklist`completed`review;)             / symbol
     (`ts_accepted;-6817.120,-6940.241,-6882.554,-6785.232;)    / double - timestamp accepted
     (`ts_completed;-6807.127,-6900.248,-6832.559,-6755.236;)   / double - timestamp completed
     (`ts_created;-6819.124,-6940.641,-6882.574,-6786.232;)     / double - timestamp created
     (`assignee;1,2,2,1;))        / index - key to `User table
   )
  (`Process
   .((`name;`manageExpenses`findMissing`doNext`updateValues`runLatest`seeAll;)             / symbol
     (`tsm;-6807.120,-6900.241,-6832.554,-6755.232,-6761.371,-6800.304;)            / double - timestamp of last update
     (`tsc;-6814.125,-6911.143,-6890.704,-6758.232,-6762.354,-6800.318;)            / double - timestamp of creation
     (`initiator;1,1,2,0,2,1;)        / index - key to `User table
     (`pvs;(0,2;1;0,1,2;0,1,2,3;0,1,2;0,2);)               / indices - keys to `ProcessVariable
     (`tasks;(1,2;();();3;0;());)             / indices - keys to `Task
     (`pm;0,1,2,3,2,0;))              / index - key to ProcessModel
   )
  (`Type
   .,(`name
      `INTEGER `DOUBLE `STRING `DATE
      )
   )
  (`Data
   .((`type;0,1,1,2;)             / index - key to `Type
     (`value;(23;232.04;750.00;"Albuquerque");))            / any type - the actual value stored
   ))