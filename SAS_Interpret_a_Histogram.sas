/* Interpret a Histogram */

/* Read the dataset */
proc import 
	datafile="/home/hglanz0/ds4a/data/countries.csv"
	out = countries
	dbms = csv
	replace;
run;

proc means data = countries;
	var gni_per_capita;
	output out = meansresults min = min_gni max = max_gni;
run;

data _null_;
	set meansresults;
	
	call symputx("min_gni", min_gni + (max_gni - min_gni)/(21*2));
	call symputx("bin_width", (max_gni - min_gni)/21);
run;

title "Gross National Income Per Capita Worldwide";
proc sgplot data = countries;
	histogram gni_per_capita / fillattrs=(color=lightblue) binwidth = &bin_width binstart = &min_gni;
	xaxis label = "GNI Per Capita ($)";
run;