function [A,b] = coefficient_3Ddistance_matrix1(M,D_R,Dx,Dy,Dz,z,mu,My,Mx,Mz,M_l,lambda)
%[Dx,Dy,Dz] = gradient(D_R,1,1,1);
%Dx=derivatives(D_R,'y');
%Dy=derivatives(D_R,'x');
%Dz=derivatives(D_R,'z');
%Dx(:,:,:)=0;
%Dy(:,:,:)=0;
%Dz(:,:,:)=0;
[ht, wt] = size( M ) ;
tmp = repmat( 1 : 3*ht * wt, 11, 1 ) ;
rs =  tmp(:) ;	% Rows
cs = tmp(:) ; % Cols
ss = zeros( size( rs ) ) ; % Values
bu=zeros(ht*wt,1);
bv=zeros(ht*wt,1);
bw=zeros(ht*wt,1);
b=zeros(3*ht*wt,1);
%%
cs(1:11:end) = rs(1:11:end)-(6*ht); %x-2
cs(2:11:end) = rs(2:11:end)-6;      %y-2
cs(3:11:end) = rs(3:11:end)-3*ht;	%x-1
cs(4:11:end) = rs(4:11:end)-3;      %y-1

cs(5:33:end) = rs(5:33:end);	    %u
cs(6:33:end) = rs(6:33:end)+1;	    %u_{v}
cs(7:33:end) = rs(7:33:end)+2;	    %u_{z}
cs(16:33:end) = rs(16:33:end)-1;	%v_{u}
cs(17:33:end) = rs(17:33:end);	    %v
cs(18:33:end) = rs(18:33:end)+1;	%v_{z}
cs(27:33:end) = rs(27:33:end)-2;	%w_{u}
cs(28:33:end) = rs(28:33:end)-1;	%w_{v}
cs(29:33:end) = rs(29:33:end);	    %w

cs(8:11:end) = rs(8:11:end)+3;        %y+1
cs(9:11:end) = rs(9:11:end)+3*ht;     %x+1
cs(10:11:end) = rs(10:11:end)+6;      %y+2
cs(11:11:end) = rs(11:11:end)+(6*ht); %x+2
%%
ss(5:33:end)=12;
ss(6:33:end)=0;
ss(7:33:end)=0;

ss(16:33:end)=0;
ss(17:33:end)=12;
ss(18:33:end)=0;

ss(27:33:end)=0;
ss(28:33:end)=0;
ss(29:33:end)=12;

ss(1:11:end)=1;
ss(2:11:end)=1;
ss(3:11:end)=-4;
ss(4:11:end)=-4;
ss(8:11:end)=-4;
ss(9:11:end)=-4;
ss(10:11:end)=1;
ss(11:11:end)=1;
%%
u_place=ss(5:33:end);
u_v_place=ss(6:33:end);
u_w_place=ss(7:33:end);
v_place=ss(17:33:end);
v_u_place=ss(16:33:end);
v_w_place=ss(18:33:end);
w_place=ss(29:33:end);
w_v_place=ss(28:33:end);
w_u_place=ss(27:33:end);
for ij=1:Mz
for i=1:My
    for j=1:Mx
        if z(i,j,ij)==1   
            u_v_place(i+((j-1)*My))=mu.*Dx(i,j,ij).*Dy(i,j,ij);
            u_w_place(i+((j-1)*My))=mu.*Dx(i,j,ij).*Dz(i,j,ij);
            
            v_u_place(i+((j-1)*My))=mu.*Dy(i,j,ij).*Dx(i,j,ij);
            v_w_place(i+((j-1)*My))=mu.*Dy(i,j,ij).*Dz(i,j,ij);
            
            w_u_place(i+((j-1)*My))=mu.*Dz(i,j,ij).*Dx(i,j,ij);
            w_v_place(i+((j-1)*My))=mu.*Dz(i,j,ij).*Dy(i,j,ij);
            
            u_place(i+((j-1)*My))=12+(mu.*(Dx(i,j,ij)^2));
            v_place(i+((j-1)*My))=12+(mu.*(Dy(i,j,ij)^2));
            w_place(i+((j-1)*My))=12+(mu.*(Dz(i,j,ij)^2));
            
            bu(i+((j-1)*My)) = -mu.*(D_R(i,j,ij).*Dx(i,j,ij));
            bv(i+((j-1)*My)) = -mu.*(D_R(i,j,ij).*Dy(i,j,ij));
            bw(i+((j-1)*My)) = -mu.*(D_R(i,j,ij).*Dz(i,j,ij));
        end
    end
end
end
b(1:3:end)=bu;
b(2:3:end)=bv;
b(3:3:end)=bw;
ss(5:33:end)=u_place;
ss(6:33:end)=u_v_place;
ss(7:33:end)=u_w_place;
ss(17:33:end)=v_place;
ss(16:33:end)=v_u_place;
ss(18:33:end)=v_w_place;
ss(29:33:end)=w_place;
ss(28:33:end)=w_v_place;
ss(27:33:end)=w_u_place;
%% boundaries
first_rows=[1:3*ht:3*ht*wt]';
second_rows=[2:3*ht:3*ht*wt]';
third_rows=[3:3*ht:3*ht*wt]';
fourth_rows=[4:3*ht:3*ht*wt]';
fivth_rows=[5:3*ht:3*ht*wt]';
sixth_rows=[6:3*ht:3*ht*wt]';

five_b_last_rows=[3*ht-5:3*ht:3*ht*wt]'; % five before last row at each block matrix
four_b_last_rows=[3*ht-4:3*ht:3*ht*wt]'; % four before last row at each block matrix
three_b_last_rows=[3*ht-3:3*ht:3*ht*wt]'; % three before last row at each block matrix
two_b_last_rows=[3*ht-2:3*ht:3*ht*wt]';
one_b_last_rows=[3*ht-1:3*ht:3*ht*wt]';
last_rows=[3*ht:3*ht:3*ht*wt]';

size_first_rows=size(first_rows,1);
size_second_rows=size(second_rows,1);
size_third_rows=size(third_rows,1);
size_fourth_rows=size(fourth_rows,1);
size_fivth_rows=size(fivth_rows,1);
size_sixth_rows=size(sixth_rows,1);

size_five_b_last_rows=size(five_b_last_rows,1);
size_four_b_last_rows=size(four_b_last_rows,1);
size_three_b_last_rows=size(three_b_last_rows,1);
size_two_b_last_rows=size(two_b_last_rows,1);
size_one_b_last_rows=size(one_b_last_rows,1);
size_last_rows=size(last_rows,1);
%% u boundary
for i=5:33:size(rs,1)
    for ii=1:size_first_rows
        if (cs(i)==first_rows(ii)) % this is chose the first row of each block
            ss(i-1)=0;  %4:y-1
            ss(i-3)=0;  %2:y-2
            ss(i+3)=-8; %8:y+1
            ss(i+5)=1;  %10:y+2
            if (cs(i)==first_rows(1)) || (cs(i)==first_rows(2)) || (cs(i)==first_rows(size_first_rows-1)) || (cs(i)==first_rows(size_first_rows))
                ss(i)=ss(i)+2; %5: diagonal
            else
                ss(i)=ss(i)+1; %5: diagonal
            end
        end
    end
    for ii=1:size_fourth_rows
        if (cs(i)==fourth_rows(ii)) % this is chose the first row of each block
            ss(i-3)=0;  %2:y-2
            if (cs(i)==fourth_rows(1)) || (cs(i)==fourth_rows(2)) || (cs(i)==fourth_rows(size_fourth_rows-1)) || (cs(i)==fourth_rows(size_fourth_rows))
                ss(i)=ss(i)+2; %5: diagonal
            else
                ss(i)=ss(i)+1; %5: diagonal
            end
        end
    end
    for ii=1:size_five_b_last_rows
        if (cs(i)==five_b_last_rows(ii)) % this is chose the first row of each block
            ss(i+5)=0;  %10:y+2
            if (cs(i)==five_b_last_rows(1)) || (cs(i)==five_b_last_rows(2)) || (cs(i)==five_b_last_rows(size_five_b_last_rows-1)) || (cs(i)==five_b_last_rows(size_five_b_last_rows))
                ss(i)=ss(i)+2; %5: diagonal
            else
                ss(i)=ss(i)+1; %5: diagonal
            end
        end
    end
    for ii=1:size_two_b_last_rows
        if (cs(i)==two_b_last_rows(ii)) % this is chose the last row of each block
            ss(i-1)=-8;  %4: y-1
            ss(i-3)=1;   %2:y-2
            ss(i+3)=0;   %8:y+1
            ss(i+5)=0;   %10:y+2
            if (cs(i)==two_b_last_rows(1)) || (cs(i)==two_b_last_rows(2)) || (cs(i)==two_b_last_rows(size_two_b_last_rows-1)) || (cs(i)==two_b_last_rows(size_two_b_last_rows))
                ss(i)=ss(i)+2;%5: diagonal
            else
                ss(i)=ss(i)+1;%5: diagonal
            end
        end
    end
    if cs(i)<=3*ht && cs(i)>0 % first block
        ss(i-2)=0; %3:x-1
        ss(i+4)=-8;%9:x+1
        ss(i+6)=1; %11:x+2
        ss(i-4)=0; %1:x-2
    end
    if cs(i)>=((3*ht*wt)-(3*ht))+1 && cs(i)<(3*ht*wt)%+1 % last block
        ss(i-2)=-8;%3:x-1
        ss(i+4)=0;%9:x+1
        ss(i+6)=0;%11:x+2
        ss(i-4)=1;%1:x-2
    end
    %if i<=(11*6*ht)  % the third row up to two before the last row in first and second block matrices
       if cs(i)<(6*ht)
        %-5 is becuase we dont consider y+1 to x+2 ( get rid of some
        %mismatches)
        if(cs(i)==two_b_last_rows(1)) || (cs(i)==two_b_last_rows(2)) || (cs(i)==five_b_last_rows(1)) || (cs(i)==five_b_last_rows(2))...
                ||(cs(i)==fourth_rows(1)) || (cs(i)==fourth_rows(2)) || (cs(i)==first_rows(1)) || (cs(i)==first_rows(2))
            ss(i)=ss(i);
        else
            ss(i)=ss(i)+1;
        end
    end
    %if i>((11*3*ht*wt)-(6*ht*11)) % the third row up to two before the last row in last and one before last block matrices
    if cs(i)>((3*ht*wt)-(6*ht))   
    if(cs(i)==two_b_last_rows(size_two_b_last_rows-1)) || (cs(i)==two_b_last_rows(size_two_b_last_rows)) || (cs(i)==five_b_last_rows(size_five_b_last_rows-1)) || (cs(i)==five_b_last_rows(size_five_b_last_rows))...
                ||(cs(i)==fourth_rows(size_fourth_rows-1)) || (cs(i)==fourth_rows(size_fourth_rows)) || (cs(i)==first_rows(size_first_rows-1)) || (cs(i)==first_rows(size_first_rows))
            ss(i)=ss(i);
        else
            ss(i)=ss(i)+1;
        end
    end
end
%% v bounddary
for i=17:33:size(rs,1)
    for ii=1:size_second_rows
        if (cs(i)==second_rows(ii)) % this is chose the second row of each block
            ss(i-2)=0;  %4:y-1
            ss(i-4)=0;  %2:y-2
            ss(i+2)=-8; %8:y+1
            ss(i+4)=1;  %10:y+2
            if (cs(i)==second_rows(1)) || (cs(i)==second_rows(2)) || (cs(i)==second_rows(size_second_rows-1)) || (cs(i)==second_rows(size_second_rows))
                ss(i)=ss(i)+2; %17: diagonal
            else
                ss(i)=ss(i)+1; %17: diagonal
            end
        end
    end
     for ii=1:size_fivth_rows
        if (cs(i)==fivth_rows(ii)) % this is chose the first row of each block
            ss(i-4)=0;  %2:y-2
            if (cs(i)==fivth_rows(1)) || (cs(i)==fivth_rows(2)) || (cs(i)==fivth_rows(size_fivth_rows-1)) || (cs(i)==fivth_rows(size_fivth_rows))
                ss(i)=ss(i)+2; %17: diagonal
            else
                ss(i)=ss(i)+1; %17: diagonal
            end
        end
     end
    for ii=1:size_four_b_last_rows
        if (cs(i)==four_b_last_rows(ii)) % this is chose the first row of each block
            ss(i+4)=0;  %8:y+2
            if (cs(i)==four_b_last_rows(1)) || (cs(i)==four_b_last_rows(2)) || (cs(i)==four_b_last_rows(size_four_b_last_rows-1)) || (cs(i)==four_b_last_rows(size_four_b_last_rows))
                ss(i)=ss(i)+2; %17: diagonal
            else
                ss(i)=ss(i)+1; %17: diagonal
            end
        end
    end
     for ii=1:size_one_b_last_rows
        if (cs(i)==one_b_last_rows(ii)) % this is chose the last row of each block
            ss(i-2)=-8;  %4: y-1
            ss(i-4)=1;   %2:y-2
            ss(i+2)=0;   %6:y+1
            ss(i+4)=0;   %8:y+2
            if (cs(i)==one_b_last_rows(1)) || (cs(i)==one_b_last_rows(2)) || (cs(i)==one_b_last_rows(size_one_b_last_rows-1)) || (cs(i)==one_b_last_rows(size_one_b_last_rows))
                ss(i)=ss(i)+2;%17: diagonal
            else
                ss(i)=ss(i)+1;%17: diagonal
            end
        end
     end
     if cs(i)<=3*ht && cs(i)>0 % first block
        ss(i-3)=0; %3:x-1
        ss(i+3)=-8;%9:x+1
        ss(i+5)=1; %11:x+2
        ss(i-5)=0; %1:x-2
     end
     if cs(i)>((3*ht*wt)-(3*ht))+1 && cs(i)<=(3*ht*wt)%+1 % last block
        ss(i-3)=-8;%3:x-1
        ss(i+3)=0;%9:x+1
        ss(i+5)=0;%11:x+2
        ss(i-5)=1;%1:x-2
     end
    if cs(i)<=(6*ht)  % the third row up to two before the last row in first and second block matrices
        if(cs(i)==one_b_last_rows(1)) || (cs(i)==one_b_last_rows(2)) || (cs(i)==four_b_last_rows(1)) || (cs(i)==four_b_last_rows(2))...
                ||(cs(i)==fivth_rows(1)) || (cs(i)==fivth_rows(2)) || (cs(i)==second_rows(1)) || (cs(i)==second_rows(2))
            ss(i)=ss(i);
        else
            ss(i)=ss(i)+1;
        end
    end
    if cs(i)>((3*ht*wt)-(6*ht))+1 % the third row up to two before the last row in last and one before last block matrices
        if(cs(i)==one_b_last_rows(size_one_b_last_rows-1)) || (cs(i)==one_b_last_rows(size_one_b_last_rows)) || (cs(i)==four_b_last_rows(size_four_b_last_rows-1)) || (cs(i)==four_b_last_rows(size_four_b_last_rows))...
                ||(cs(i)==fivth_rows(size_fivth_rows-1)) || (cs(i)==fivth_rows(size_fivth_rows)) || (cs(i)==second_rows(size_second_rows-1)) || (cs(i)==second_rows(size_second_rows))
            ss(i)=ss(i);
        else
            ss(i)=ss(i)+1;
        end
    end
end
%% w boundaries
for i=29:33:size(rs,1)
    for ii=1:size_third_rows
        if (cs(i)==third_rows(ii)) % this is chose the second row of each block
            ss(i-3)=0;  %4:y-1
            ss(i-5)=0;  %2:y-2
            ss(i+1)=-8; %8:y+1
            ss(i+3)=1;  %10:y+2
            if (cs(i)==third_rows(1)) || (cs(i)==third_rows(2)) || (cs(i)==third_rows(size_third_rows-1)) || (cs(i)==third_rows(size_third_rows))
                ss(i)=ss(i)+2; %29: diagonal
            else
                ss(i)=ss(i)+1; %29: diagonal
            end
        end
    end
    for ii=1:size_sixth_rows
        if (cs(i)==sixth_rows(ii)) % this is chose the first row of each block
            ss(i-5)=0;  %2:y-2
            if (cs(i)==sixth_rows(1)) || (cs(i)==sixth_rows(2)) || (cs(i)==sixth_rows(size_sixth_rows-1)) || (cs(i)==sixth_rows(size_sixth_rows))
                ss(i)=ss(i)+2; %29: diagonal
            else
                ss(i)=ss(i)+1; %29: diagonal
            end
        end
    end
      for ii=1:size_three_b_last_rows
        if (cs(i)==three_b_last_rows(ii)) % this is chose the first row of each block
            ss(i+3)=0;  %10:y+2
            if (cs(i)==three_b_last_rows(1)) || (cs(i)==three_b_last_rows(2)) || (cs(i)==three_b_last_rows(size_three_b_last_rows-1)) || (cs(i)==three_b_last_rows(size_three_b_last_rows))
                ss(i)=ss(i)+2; %29: diagonal
            else
                ss(i)=ss(i)+1; %29: diagonal
            end
        end
      end
    for ii=1:size_last_rows
        if (cs(i)==last_rows(ii)) % this is chose the last row of each block
            ss(i-3)=-8;  %4: y-1
            ss(i-5)=1;   %2:y-2
            ss(i+1)=0;   %8:y+1
            ss(i+3)=0;   %10:y+2
            if (cs(i)==last_rows(1)) || (cs(i)==last_rows(2)) || (cs(i)==last_rows(size_last_rows-1)) || (cs(i)==last_rows(size_last_rows))
                ss(i)=ss(i)+2;%29: diagonal
            else
                ss(i)=ss(i)+1;%29: diagonal
            end
        end
    end
      if cs(i)<=3*ht && cs(i)>0 % first block
        ss(i-4)=0; %3:x-1
        ss(i+2)=-8;%9:x+1
        ss(i+4)=1; %11:x+2
        ss(i-6)=0; %1:x-2
      end
     if cs(i)>((3*ht*wt)-(3*ht))+1 && cs(i)<=(3*ht*wt)%+1 % last block
        ss(i-4)=-8;%3:x-1
        ss(i+2)=0;%9:x+1
        ss(i+4)=0;%11:x+2
        ss(i-6)=1;%1:x-2
     end
     if cs(i)<=(6*ht)  % the third row up to two before the last row in first and second block matrices
        if(cs(i)==last_rows(1)) || (cs(i)==last_rows(2)) || (cs(i)==three_b_last_rows(1)) || (cs(i)==three_b_last_rows(2))...
                ||(cs(i)==sixth_rows(1)) || (cs(i)==sixth_rows(2)) || (cs(i)==third_rows(1)) || (cs(i)==third_rows(2))
            ss(i)=ss(i);
        else
            ss(i)=ss(i)+1;
        end
    end
    if cs(i)>((3*ht*wt)-(6*ht))+2 % the third row up to two before the last row in last and one before last block matrices
        if(cs(i)==last_rows(size_last_rows-1)) || (cs(i)==last_rows(size_last_rows)) || (cs(i)==three_b_last_rows(size_three_b_last_rows-1)) || (cs(i)==three_b_last_rows(size_three_b_last_rows))...
                ||(cs(i)==sixth_rows(size_sixth_rows-1)) || (cs(i)==sixth_rows(size_sixth_rows)) || (cs(i)==third_rows(size_third_rows-1)) || (cs(i)==third_rows(size_third_rows))
            ss(i)=ss(i);
        else
            ss(i)=ss(i)+1;
        end
    end
end
%% selected values from inside image domain
ind = find(cs > 0) ;
rs = rs( ind ) ;
cs = cs( ind ) ;
ss = ss( ind ) ;
ind = find(cs < ( 3*ht * wt+1 ) ) ;
rs = rs( ind ) ;
cs = cs( ind ) ;
ss = ss( ind ) ;
%% Coefficient Matrix
A=sparse(rs,cs,ss);
end