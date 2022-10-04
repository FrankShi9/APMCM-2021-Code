clear

c1 = readtable('c1.xls');
c1 = table2array(c1);
c2 = readtable('c2.xls');
c2 = table2array(c2);
x = c1(:,1);
y = c1(:,2);
[Gmag, Gdir] = imgradient(c1);
figure
plot(c1(:,1), c1(:,2), c2(:,1), c2(:,2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqcurvefit() %curve fit prototype
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


