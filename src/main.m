
function []=test4()


s = [1 1 2 4 3 5 6 3 4 5 11 15 8 9 10 11 16 8 20 10 11 13 13 17 18 19 20 21 22 23 18 19 25 20 26 21 22 23 25 29 30 31 32 29 35 35 30 31 32 36 36 38 39 40 41 39 40 41 42 43 44 45 44 45 47 48];
t = [2 4 5 5 4 6 7 8 9 10 7 8 9 10 11 12 18 19 9 21 13 14 23 18 19 20 21 22 23 24 27 25 28 26 29 30 31 32 26 30 31 32 33 35 34 39 40 41 36 37 42 39 40 41 42 43 44 45 46 44 45 46 48 49 48 49];

x = [18.3091 85.5134 2.1801 151.3737 242.0995 317.8854 334.0580 75.2978 226.2412 323.2763 451.3086 445.9178 489.0445 533.5189 11.9555 6.5647 6.5647 28.1280 164.2466 319.2332 413.5728 493.0876 576.6456 689.8531 238.3706 405.4865 77.9933 321.9286 509.2601 575.2978 638.6402 704.6779 854.2736 498.4784 590.1226 813.8423 928.3976 546.9960 622.4677 693.8962 766.6725 839.4488 734.3275 801.7129 869.0984 947.2655 856.9690 910.8774 985.0013];
y = [90.6639 8.6967 477.8014 272.2528 151.1936 53.2990 8.7697 590.1947 378.9987 256.8613 86.3779 26.5814 113.0954 58.3880 660.1692 809.0242 903.1718 880.2710 714.8766 510.0420 385.3601 275.9453 166.5305 13.8588 814.1132 595.2837 994.7748 938.7952 698.3372 548.2099 399.3550 246.6832 48.2099 919.7112 788.6679 311.5687 162.7137 987.1412 821.7468 661.4415 502.4084 333.1972 924.8003 756.8613 590.1947 400.6272 994.7748 857.3702 681.7977];
[m,n]=size(t);
    for (p=1:n)
        w(p)=distance(x,y,s(p),t(p));
    
    end
    

A = imread('mapcapture.PNG');
A1=imresize(A,[1000 1000]);
figure;
image(A1);
title('Select 2 points and press enter!', 'FontSize', 20,'color','b');

[xselect, yselect] = getpts;
    dmin1= sqrt ((x(1)-xselect(1)).^2 + (y(1)-yselect(1)).^2);
    for (p=2:49)
       d1= sqrt ((x(p)-xselect(1)).^2 + (y(p)-yselect(1)).^2);
       if (d1<dmin1)
          dmin1=d1;
          startpoint=p;
       end
    end
    
    dmin2= sqrt ((x(1)-xselect(2)).^2 + (y(1)-yselect(2)).^2);
    for(p=2:49)
       d2= sqrt ((x(p)-xselect(2)).^2 + (y(p)-yselect(2)).^2); 
       if (d2<dmin2)
           dmin2=d2;
           endpoint=p;
           
       end
    end
    
  
    
    s(n+1)=50;
    s(n+2)=51;
    t(n+1)=startpoint;
    t(n+2)=endpoint;
    x(50)=xselect(1);
    x(51)=xselect(2);
    y(50)=yselect(1);
    y(51)=yselect(2);
    w(n+1)=dmin1;
    w(n+2)=dmin2;
    
    
G = graph(s,t,w);
figure;
plotnode=plot(G,'XData',x,'YData',y);
plotnode.LineStyle='--';
ax = gca;
ax.YDir = 'reverse';
ax.XLim = [0 1000];
ax.YLim = [0 1000];


    [P,d] = shortestpath(G,50,51)
   % [P,d,e] = shortestpath(G,50,51);
    highlight(plotnode,P,'EdgeColor','r');
    highlight(plotnode,P,'LineStyle','-');
   % highlight(plotnode,'Edges',e);
   highlight(plotnode,P,'LineWidth',3);
   highlight(plotnode, P ,'NodeColor','r')
   
   title({'NODES FIGURE:';['The shortest path between 2 selected points is ',num2str(d),' m']}, 'FontSize', 12,'color','b');

   
figure;
hold on;
B = imread('mapcapture.PNG');
B1=imresize(B,[1000 1000]);
image(B1);

[m,n]=size(P);
for (p=1:(n-1))
    s2(p)=p;
    t2(p)=p+1;
end
for (p=1:n)
    x2(p)=x(P(p));
    y2(p)=y(P(p));
    P2(p)=p;
end

G2 = graph (s2,t2);
plotnode2=plot(G2,'XData',x2,'YData',y2);
ax = gca;
ax.YDir = 'reverse';
ax.XLim = [0 1000];
ax.YLim = [0 1000];
highlight(plotnode2,P2,'EdgeColor','r');
highlight(plotnode2,P2,'LineWidth',3);
highlight(plotnode2,P2,'NodeColor','r');
title({'MAP FIGURE:';['The shortest path between 2 selected points is ',num2str(d),' m']}, 'FontSize', 12,'color','b');
   
end
function d=distance(x,y,i,j)
    d = sqrt((x(i)-x(j)).^2 + (y(i)-y(j)).^2);
end


