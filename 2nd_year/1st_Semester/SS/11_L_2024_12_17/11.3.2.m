x = randn(10000,1);
y = 2*x + 3 + randn(10000,1);
z = [x y];
K = cov(z);

[eigvect,eigval]=eig(K);
m = mean(z);

factor_amplificare_axa_mica = 10;
factor_amplificare_axa_mare = 1.3;

p11 = m'-factor_amplificare_axa_mica*eigval(1,1)*eigvect(:,1);
p12 = m'+factor_amplificare_axa_mica*eigval(1,1)*eigvect(:,1);


p21 = m'-factor_amplificare_axa_mare*eigval(2,2)*eigvect(:,2);
p22 = m'+factor_amplificare_axa_mare*eigval(2,2)*eigvect(:,2);

figure;
plot(x,y,'*');
hold on;
plot([p11(1) p12(1)],[p11(2) p12(2)],'r');
plot([p21(1) p22(1)],[p21(2) p22(2)],'r');
axis equal
