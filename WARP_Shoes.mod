reset;

#sets
set PN; # set of products
set M; # set of machine numbers
set RM; # set of raw materials
set SN := 1..10; # set of store number
set WN; # set of warehouses
set Year := 1997..2003; # set of years
set Month := 1..12; # set of months


#Parameters
param sp{PN} default 0;  # sales price
param d{PN, Year, Month, SN} default 0;    # unit cost of foods
param o{M}  default 0; # operating cost of machine
param a{PN, M} default 0; # average duration for each product and machine
param c{RM} default 0; # cost of raw material
param q{PN, RM} default 0; # quantity of raw materials required for product number
param max_supply{RM} default 0; # maximum supply of raw material
param w_cap{WN}; # max capacity of warehouses
param w_op{WN}; # operating cost of warehouses
param max_sec := 28*12*3600; # maximum number of seconds a worker may do in a week
param min_to_sec := 1/60; # unit conversion - min to seconds
param pay_per_sec := 25/3600; # pay of employee per second
param loss_from_missed_demand := 10; # loss as a result of missed demand
param extra_w_cap := 10; # cost to add additional space to warehouse
param bom_budget := 10000000; # budget for raw materials


#variables
var x{PN} integer >= 0; #amount of each food
var w_used{WN} binary >= 0; # warhouses used
var extra_w{WN} integer >=0;


#model
maximize profit:
	sum{n in PN} (
		sp[n]*x[n] #revnue from sales
		- (sum{rm in RM} c[rm]*q[n, rm]*x[n]) # BOM
		- (loss_from_missed_demand *  (2*((sum{sn in SN} (sum{y in Year} sum{m in Month} d[n,y,m,sn])/(7*12)))- x[n])) #losses from missed demand
		- (sum{m in M} (min_to_sec*o[m] + pay_per_sec)*a[n, m]*x[n]) # cost of operating machines and labour
		)
	- sum{w in WN} (
		w_op[w]*w_used[w] # operation cost of warehouse
		); 

subject to co1: (sum{n in PN} sum{rm in RM} c[rm]*q[n, rm]*x[n]) <= bom_budget; #cost of raw materials
subject to co2{m in M}: (sum{n in PN} a[n, m]*x[n]) <= max_sec; #max working hours per week
subject to co3{rm in RM}: (sum{n in PN} q[n, rm]*x[n]) <= max_supply[rm]; #max supply of materials
subject to co4{n in PN}: x[n] <= (sum{w in WN} (w_cap[w] * w_used[w])); #max warehouse capacity
