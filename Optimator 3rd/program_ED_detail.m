
tic
format long;
n=length(data(:,1));
     Aeq=ones(1,n);
     a=data(:,1)';		
          b=data(:,2');			
               c=data(:,3)';		
                    l=data(:,4)';	
                         u=data(:,5)';	
                         m_detail=48;

                         A=ones(1,n);
                          K=zeros(1,n); 
                         for i=1:m_detail
                             L_detail((i-1)*3+1:i*3)=l;
                               U_detail((i-1)*3+1:i*3)=u;
                                Aeq_detail((i-1)*3+1:i*3)=K;
                                 A1_detail((i-1)*3+1:i*3)=a;
                                  B1_detail((i-1)*3+1:i*3)=b;
                              CC_detail(i,(i-1)*3+1:i*3)=A;
                         end
Beq=0;
H_detail=2*diag(A1_detail);

P1_detail=quadprog(H_detail,B1_detail,Aeq_detail,Beq,CC_detail,Pd1_detail,L_detail,U_detail);

for i=1:m_detail
    PP_detail(i,:)= P1_detail((i-1)*3+1:i*3);
end
%{
for i=1:m*n
       C_pagi(i)=A1(i)*P1_pagi(i)^2+B1(i)*P1_pagi(i); 		%menghitung cost unit 1 2 3
       C_siang(i)=A1_siang(i)*P1_siang(i)^2+B1_siang(i)*P1_siang(i); 		%menghitung cost unit 1 2 3 selanjutnya
       C_malam(i)=A1_malam(i)*P1_malam(i)^2+B1_malam(i)*P1_malam(i); 		%menghitung cost unit 1 2 3 selanjutnya
end
    C_pagi(1)=A1(1)*P1_pagi(1)^2+B1(1)*P1_pagi(1);
    C_pagi(2)=A1(2)*P1_pagi(2)^2+B1(2)*P1_pagi(2);
    C_pagi(3)=A1(3)*P1_pagi(3)^2+B1(3)*P1_pagi(3);

    C_siang(1)=A1_siang(1)*P1_siang(1)^2+B1_siang(1)*P1_siang(1);
    C_siang(2)=A1_siang(2)*P1_siang(2)^2+B1_siang(2)*P1_siang(2);
    C_siang(3)=A1_siang(3)*P1_siang(3)^2+B1_siang(3)*P1_siang(3);

    C_malam(1)=A1_malam(1)*P1_malam(1)^2+B1_malam(1)*P1_malam(1);
    C_malam(2)=A1_malam(2)*P1_malam(2)^2+B1_siang(2)*P1_malam(2);
    C_malam(3)=A1_malam(3)*P1_malam(3)^2+B1_siang(3)*P1_malam(3);

    Tcost1_pagi=C_pagi(1)+m*c(1);
    Tcost2_pagi=C_pagi(2)+m*c(2);
    Tcost3_pagi=C_pagi(3)+m*c(3);

    Tcost1_siang=C_siang(1)+m_siang*c(1);
    Tcost2_siang=C_siang(2)+m_siang*c(2);
    Tcost3_siang=C_siang(3)+m_siang*c(3);

    Tcost1_malam=C_malam(1)+m_malam*c(1);
    Tcost2_malam=C_malam(2)+m_malam*c(2);
    Tcost3_malam=C_malam(3)+m_malam*c(3);

    Tcost_pagi=sum(C_pagi)+m*sum(c);
    Tcost_siang=sum(C_siang)+m_siang*sum(c);
    Tcost_malam=sum(C_malam)+m_malam*sum(c);
    
    Tcost = (Tcost_pagi + Tcost_siang + Tcost_malam)/3;
%}