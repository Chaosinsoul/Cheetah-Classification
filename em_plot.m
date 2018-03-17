function [  ] = em_plot( error,k )
Dimension1 = [1,2,4,8,16,24,32,40,48,56,64];
x = Dimension1;
FG1 = plot(x,error(1,:),'-o');

hold on 
FG2 = plot(x,error(2,:),'-o');

hold on 
FG3 = plot(x,error(3,:),'-o');

hold on 
FG4 = plot(x,error(4,:),'-o');

hold on 
FG5 = plot(x,error(5,:),'-o');
hold off 

legend('FG1','FG2','FG3','FG4','FG5')
xlabel('Number of Dimension');
ylabel('PoE');
end

