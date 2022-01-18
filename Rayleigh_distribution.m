x = [0:0.01:8];
p1 = raylpdf(x,0.5);
p2 = raylpdf(x,1.0);
p3 = raylpdf(x,2.0);
p4 = raylpdf(x,3.0);

figure;
plot(x,p1,'r','LineWidth',1.5);
hold on
plot(x,p2,'g','LineWidth',1.5);
hold on
plot(x,p3,'b','LineWidth',1.5);
hold on
plot(x,p4,'black','LineWidth',1.5);
