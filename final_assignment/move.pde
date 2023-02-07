void IK(){
  float L1=25,L2=50,L3=50;
  float C3,S3;
  float M,N,A,B;
  
    C3=-(sq(x)+sq(z)+sq(y-L1)-sq(L2)-sq(L3))/(2*L2*L3);
    S3=-sqrt(1-sq(C3));//elbowupにした
    M=L2-L3*C3;
    N=S3*L3;
    A=sqrt(sq(x)+sq(z));
    B=y-L1;
  
  
 theta1=atan2(x,z);
 theta2=atan2(N * A - B * M , N * B + M * A);
 theta3=atan2(S3,C3);
}
