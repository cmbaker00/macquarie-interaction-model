function MI_model()

p = gen_params();
p.alpha = 1;
p.Rp = p.P_eggs*p.P_breed/2;
p.rp = p.Rp*(1-exp(-p.r0));
p.Rs = p.S_eggs*p.S_breed/2;

p.rn = .25;
p.N0 = 200;
% p.S0 = 0
% p.alpha = 0.002
p.gamma = 0.001;
[t,y] = ode45(@(t,n) de_fun(t,n,p),[0,10],[p.S0/10,p.P0,p.N0]);
figure(1)
clf
plot(t,y)
legend('Skua','Petrel','Other','location','best')
end


function dndt = de_fun(t,n,p)
S = n(1); P = n(2); N = n(3);
% dndt = [p.gamma*S*(p.alpha*p.mu*p.phi*P^2+p.mu*N^2)/(p.phi*P+N) - p.theta*S;
dndt = [S*p.Rs*(1-exp(-1*(p.alpha*p.mu*p.phi*P^2+p.mu*N^2)/(p.phi*P+N))) - p.theta*S;
    p.rp*P - p.gamma*p.alpha*p.phi*P^2*S/(p.phi*P+N);
    p.rn*N - p.gamma*N^2*S/(p.phi*P+N)];
% if t > 1
%     keyboard
% end
end