clear
clc
clf

f = @(x1,x2)(2*x1.^2.*x2+31*x1.^4+18*x2.^2+3);
[x,y] = meshgrid(-7:0.1:7);
contour(x,y,f(x,y),50)
hold on
%%
x0 = [-3; -3];
xk = x0;

d = [1 0;
     0 1];

alfa = 3;
beta = -0.5;
s10 = -1;
s20 = -1;

eps = 1e-4;
plot(xk(1),xk(2),'*r')

s = [s10; s20];
k = 0;

while k<100
    
   c = [0; 0];
   oscilation = 0;
   success = [0; 0];
   fail = [0; 0];
   
   while (oscilation == 0)
   
       for i = 1:2
        xnext=[xk(1) + s(i)*d(1,i);xk(2) + s(i)*d(2,i)];
        fnext=f(xnext(1),xnext(2));
        factual= f(xk(1),xk(2));
           if fnext <= factual
              xvechi=[xk(1);xk(2)];
              xk = xk + s(i) * d(:,i);
              plot([xvechi(1),xk(1)],[xvechi(2),xk(2)])
              drawnow

              success(i) = 1;
              c(i) = c(i) + s(i);
              s(i) = s(i) * alfa;
          
           else
               
              fail(i) = 1;
              s(i) = s(i)*beta;
               
           end
          
       end
       
       if  (success == [1;1]) & (fail == [1;1])
       
           oscilation = 1;
                
       end
   
   end
   
   a1 = c(1)*d(:,1) + c(2)*d(:,2);
   a2 = c(2)*d(:,2);
   
   b1 = a1;  d(:,1) = b1/norm(b1);
   b2 = a2 - a2'*b1/(norm(b1))^2 * b1;
   d(:,2) = b2/norm(b2);
   k = k + 1;
   hold on
   plot([xvechi(1),xk(1)],[xvechi(2),xk(2)])
   drawnow
   if norm([xvechi(1)-xk(1),xvechi(2)-xk(2)])<eps
        break;
    end
end