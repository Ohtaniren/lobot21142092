PShape base, shoulder, upArm, loArm; //OBJファイルの3Dデータの表示
float rotX, rotY;//浮動小数点で変数設定（マウス操作の変数）
float theta1, theta2, theta3;//浮動小数点で変数設定（各アームの回転角）
float x,y,z;//浮動小数点で変数設定（追従する球の座標）


void setup(){
    size(1100, 1100, P3D);//画面サイズ
    x=50;
    y=50;
    z=50;//球の初期位置
    
    base = loadShape("r5.obj");
    shoulder = loadShape("r1.obj");
    upArm = loadShape("r2.obj");
    loArm = loadShape("r3.obj");
    //PShapeで設定した変数のファイル設定
    
    shoulder.disableStyle();
    upArm.disableStyle();
    loArm.disableStyle(); //描画情報を初期化した
}

void draw(){ 
    IK();//アームの回転角の情報
    background(32);//背景色
    smooth();//滑らかな描写をする
    lights(); //ライトを照らす
    directionalLight(51, 102, 126, -1, 0, 0);//ライトの光の向きの設定（右からの光）
   
    fill(#FFE308); 
    noStroke();
   
    translate(width/2,height/2);//原点を画面中央に移動
    rotateX(rotX);
    rotateY(-rotY); //マウスドラックの設定
    scale(-4);//座標の拡大と向きの変更
  
    pushMatrix();
      x += random(-1,1);
      y += random(-1,1);
      z += random(-1,1);
      x=constrain(x,-width/4,width/4);
      y=constrain(y,-height/4,height/4);
      z=constrain(z,-width/4,width/4);
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

void mouseDragged(){
    rotY -= (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.01;
}

void keyPressed(){
  if(key == 's'){
  noLoop();
  }
  else if(key == 'f'){
  loop();
  }
}
