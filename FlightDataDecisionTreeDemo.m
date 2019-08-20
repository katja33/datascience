opts = delimitedTextImportOptions("NumVariables", 89);

% Specify range and delimiter
opts.DataLines = [3, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "ABRK", "ACMT", "AIL_1", "AIL_2", "ALTS", "APFD", "ATEN", "A_T", "BLV", "BPGR_1", "BPGR_2", "BPYR_1", "BPYR_2", "CALT", "CASS", "CRSS", "DFGS", "DWPT", "EAI", "ELEV_1", "ELEV_2", "EVNT", "FADF", "FADS", "FGC3", "FIRE_1", "FIRE_2", "FIRE_3", "FIRE_4", "FLAP", "FQTY_1", "FQTY_2", "FQTY_3", "FQTY_4", "GLS", "GPWS", "HDGS", "HF1", "HF2", "HYDG", "HYDY", "ILSF", "LATP", "LGDN", "LGUP", "LMOD", "LOC", "LONP", "MNS", "MRK", "MW", "N1CO", "OIPL", "OIP_1", "OIP_2", "OIP_3", "OIP_4", "OIT_1", "OIT_2", "OIT_3", "OIT_4", "PACK", "PH", "POVT", "PTRM", "PUSH", "SAT", "SMKB", "SMOK", "SNAP", "SPLG", "SPLY", "SPL_1", "SPL_2", "TAI", "TAT", "TCAS", "TMAG", "TMODE", "VHF1", "VHF2", "VHF3", "VMODE", "VSPS", "WAI_1", "WAI_2", "WOW", "WSHR"];
opts.SelectedVariableNames = ["ABRK", "ACMT", "AIL_1", "AIL_2", "ALTS", "APFD", "ATEN", "A_T", "BLV", "BPGR_1", "BPGR_2", "BPYR_1", "BPYR_2", "CALT", "CASS", "CRSS", "DFGS", "DWPT", "EAI", "ELEV_1", "ELEV_2", "EVNT", "FADF", "FADS", "FGC3", "FIRE_1", "FIRE_2", "FIRE_3", "FIRE_4", "FLAP", "FQTY_1", "FQTY_2", "FQTY_3", "FQTY_4", "GLS", "GPWS", "HDGS", "HF1", "HF2", "HYDG", "HYDY", "ILSF", "LATP", "LGDN", "LGUP", "LMOD", "LOC", "LONP", "MNS", "MRK", "MW", "N1CO", "OIPL", "OIP_1", "OIP_2", "OIP_3", "OIP_4", "OIT_1", "OIT_2", "OIT_3", "OIT_4", "PACK", "PH", "POVT", "PTRM", "PUSH", "SAT", "SMKB", "SMOK", "SNAP", "SPLG", "SPLY", "SPL_1", "SPL_2", "TAI", "TAT", "TCAS", "TMAG", "TMODE", "VHF1", "VHF2", "VHF3", "VMODE", "VSPS", "WAI_1", "WAI_2", "WOW", "WSHR"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts = setvaropts(opts, 1, "WhitespaceRule", "preserve");
opts = setvaropts(opts, 1, "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
flightData1Hz = readtable("C:\Users\misa3\Documents\MATLAB\20190819_DataScience\flightData_1Hz.csv", opts);

X = [flightData1Hz(:,1:4) flightData1Hz(:,6:end)];
X = table2array(X);
Y = flightData1Hz.ALTS;

% Train a regression tree
MdlDefault = fitrtree(X, Y, 'MaxNumSplits', 10, 'CrossVal', 'on');
view(MdlDefault.Trained{1},'Mode', 'graph');

% Visualize
figure;
plot(flightData1Hz.ALTS/1000);
hold on
plot(flightData1Hz.VMODE);
plot(flightData1Hz.LONP/10);
plot(flightData1Hz.ILSF/100000);
legend('Altitude','x83','x48','x42');
xlabel('Time')