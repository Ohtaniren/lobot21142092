PShape base, shoulder, upArm, loArm; //OBJファイルの3Dデータの表示
float rotX, rotY;//浮動小数点で変数設定（マウス操作の変数）
float theta1, theta2, theta3;//浮動小数点で変数設定（各アームの回転角）
float x,y,z;//浮動小数点で変数設定（追従する球の座標）


void setup(){
    size(1000, 1000, P3D);//画面サイズ
    x = 40;
    y = 0;
    z = 0;//球の初期位置
    
    base = loadShape("r5.obj");
    shoulder = loadShape("r1.obj");
    upArm = loadShape("r2.obj");
    loArm = loadShape("r3.obj");//PShapeで設定した変数のファイル設定
    
}

void draw(){ 
    IK();//各アームの回転角の情報
    background(32);//背景色
    smooth();//滑らかな描写をする
    lights(); //ライトを照らす
    directionalLight(51, 102, 126, -1, 0, 0);//ライトの光の向きの設定（右からの光）
   
    fill(255); 
    noStroke();
   
    translate(width/2,height/2);//原点を画面中央に移動
    rotateX(rotX);
    rotateY(-rotY); //マウスドラックの設定
    scale(-4);//座標の拡大と向きの変更
  
    pushMatrix();
      x += random(-1,1);
      y += random(-1,1);
      z += random(-1,1);
      x = constrain(x,18,50);
      y = constrain(y,-48,50);//アームに当たらないような制限
      z = constrain(z,18,50);
      translate(x,y,z);
      sphere(5);
    popMatrix();//空間上をランダムに動く球
      
    translate(0,0,0);   
      shape(base);
     
    translate(0, 4, 0);
      rotateY(theta1);//theta 1
      shape(shoulder);
      
    translate(0, 25, 0);
      rotateX(theta2);//theta 2
      shape(upArm);
      
    translate(0, 0, 50);
      rotateX(theta3);//theta 3
       shape(loArm);
}

void IK(){
  float L1 = 25,L2 = 50,L3 = 50;
  float C3,S3;
  float M,N,A,B;
  
    C3 = -( sq(x) + sq(z) + sq(y-L1) - sq(L2) - sq(L3) ) / (2 * L2 * L3);
    S3 = -sqrt( 1 - sq(C3) );//elbowupにした
    M = L2 - L3 * C3;
    N = S3 * L3;
    A = sqrt( sq(x) + sq(z) );
    B = y - L1;
  
 theta1 = atan2( x , z );
 theta2 = atan2( N * A - B * M , N * B + M * A );
 theta3 = atan2( S3,C3 );
}//各アームの回転角の計算

void mouseDragged(){
    rotY -= (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.01;
}

void keyPressed(){
  if(key == 's'){
  noLoop();
  }
  else if(key == 'r'){
  loop();
  }
}//描写の停止と再生
