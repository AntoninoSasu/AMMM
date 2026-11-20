 int nTasks=...; 
 int nCPUs=...; 
 
 range T=1..nTasks; 
 range C=1..nCPUs; 
 
 float rt[T]=...; 
 float rc[C]=...;
 
 //int K=3;
 
 dvar boolean x_tc[T][C];
 
 //dvar float+ x_tc[t in T, c in C]; 
 
 //dvar float+ z; // Objective 
 
 execute{
 	var totalLoad = 0;
 	var totalCapacity = 0;
 	
 	for( var t=1; t<=nTasks; t++){
 		totalLoad += rt[t];
 	}
 	
 	for( var c=1; c<=nCPUs; c++){
 	  	totalCapacity += rc[c];
 	}
 	
 	if (totalLoad > totalCapacity) {
 	  	writeln("Total capacity not enough for the total load");
 	  	stop();
 	}
 	
 	writeln("Total load: " + totalLoad + " Total capacity: " + totalCapacity);
 }
 
 
 minimize sum(t in T) (rt[t] * (1 - sum (c in C)x_tc[t,c])); 
 
 subject to{ 
 
 // Constraint 2 
 forall(c in C) 
 	sum(t in T) rt[t] * x_tc[t,c] <= rc[c]; 
 	
 //sum(t in T) sum(c in C) x_tc[t,c] >= nTasks - K;
 
 forall(t in T)
   sum(c in C) x_tc[t,c] <= 1;
 	
 // Constraint 3 
 //forall(c in C) 
 	//z >= (1/rc[c])*sum(t in T) rt[t]* x_tc[t,c]; 
 	
 }
 
 execute{
 	
 	for(var c=1; c<=nCPUs;c++){
 	 	var load=0;
 	 	for(var t=1;t<=nTasks;t++){
 	 	 	load+=(rt[t] * x_tc[t][c]);
 	 	 	if (x_tc[t][c] == 1) {
 	 	 		writeln("CPU " + c + " performs task " + t);
     		} 	 	 		
 	 	}
 	 	load = (1/rc[c])*load;
 	 	writeln("CPU " + c + " loaded at " + 100*load + "%");
 	}
 }
 