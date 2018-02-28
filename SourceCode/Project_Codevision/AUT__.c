
/*
Project :  ROBOCON PUNE INDIA 2008         
Version :          2008
Date    : 1/28/2008
Author  : Tran Van Truong-Le Hong Lien                
Company :        IT-POWER   
Comments:     
Chip type           : ATmega16
Program type        : Application
Clock frequency     : 12.000000 MHz
Memory model        : Small
*/
#include <mega16.h>  
//CAC HANG SO  
#define Tien            1
#define Start           1
#define Stop            0    
#define Lui 		1
#define Vach 		1
#define Nen 		0
#define Dung 		0
#define   Len  		1 
#define   Xuong 	1 
#define   Ra  		1 
#define   Vao  		1         
//Do rong xung-thay doi toc do dong co  
#define   VanTocTrai  OCR2
#define   VanTocPhai  OCR0
//So vach ngang
int SoLanQuaVachNgang;                         
//=>> Giam min trai -> giam max trai 

#define intTraiMin         21//20.5//17//15//23.6//22//129//Dinh muc trai 22.6   
#define intTraiTrungBinh   33.5//31//29//172      
#define intTraiMax         43//43//43//255      
#define intCuaTrai         17.5//17//15.5//13.5//11.5//10.5//8.5//20.5//22//129
#define stTrai             9.5//11//9
//---------------------------------------------
#define intPhaiMin         20//18//16//22.8//22.7//20.3//17//13//17//20.5//22//129//Dinh muc phai 17.
#define intPhaiTrungBinh   33//31//29//172 
#define intPhaiMax         43//43//43//255      
#define intCuaPhai         16.5//12.5//10.5//9.5//7.5//18.8//18.7//16.3//20.9//16.9//11//11//20.5//22//129  
#define stPhai             9//10//8
//Bien thien van toc 
int  vt = intTraiTrungBinh;     
int  vp = intPhaiTrungBinh;
//Cac dinh muc van toc 
// unsigned int   VanT oc[7]={
//  
//       0, //0 MIN-Voi van toc nay chac Robot khong chay duoc,,,
//       vt, //1 
//       vt*2,//2
//       vt*3,       //3
//       vt*4,       //4
//       vt*6,       //5
//       vt*6-3       //6 MAX -Voi toc do nay thi Robot co the boc dau roi,,       
//       //Van toc max =43*6`=255
//       //Van toc trung binh =43*4=172 ; 172/6=29
//       //Van toc cham = 43*3=129      ; 129/6=22     
// };                 
//Bien thien van toc 
//DINH NGHIA BIEN 
//int intVachNgang ;          
bit bitVungTrai;
bit bitVungPhai;    
//DINH NGHIA CAM BIEN 
#define SensorTrungTamTrai		PINA.3
#define SensorTrai			PINA.2
#define SensorTraiNgoai			PINA.1
#define SensorTrungTamPhai		PINA.4
#define SensorPhai		        PINA.5
#define SensorPhaiNgoai			PINA.6
#define SensorDemTrai			PINA.7
#define SensorDemPhai			PINA.0 
//=============== DONG CO PHAI =====================
#define DongCoPhaiTien		 	PORTB.0
#define DongCoPhaiLui                   PORTB.1
//Xung->dong co phai
#define Pulse_Phai	 		PORTB.2 
//=============== DONG CO TRAI =====================
#define   DongCoTraiTien    	 	PORTB.2
#define   DongCoTraiLui    	 	PORTB.4
//Xung->dong co trai
#define   Pulse_Trai		        PORTB.5	
//==============DONG CO CUON =======================
#define DongCoCuonXuong		        PORTB.5
#define DongCoCuonLen			PORTB.6
#define DongCoKep		        PORTD.1
#define DongCoNha			PORTD.2            
//#define     CoKep		        PORTD.1
//#define      CoNha			PORTD.2            
//==========PHIM CHIEN THUAT========================
#define Phim1   		        PIND.5
#define Phim2   			PIND.6            
#define Phim3   		        PINC.7
#define Phim4   			PINC.6//test ok            
#define Phim5   		        PINC.4//ok test
#define Phim6  			        PINC.5//ok test            
//==========HANH HA - A NHAM ,, HANH TRINH ========================
//#define hToCentral  		        PINC.2
//#define hToUp   			PINC.5 
#define hGovida  			PINC.0 
#define hAut     			PINC.1           
//=================DONG CO KEP =========================
//chua biet dinh nghia the nao ???
//#define DongCoIn			
//#define DongCoOut                                                 
//CAC CHUONG TRINH CON 
//Khoi tao Atmega16
void Initial();     
//Vi tri robocon      
unsigned  int RoboconLocation();
//Dieu khien robocon 
void RoboconController(unsigned  int control);     
// Dieu khien huong ro bot 
void RoboconVector(unsigned  int vec); 
//Dieu khien van toc 
void VanTocTraiPhai(int,int);
//Do duong, theo vach trang
void Running();
//Dem so vach ngang
void CounterIsLine();
//---Ham delays 1 mili giay---
void Delay(unsigned int SoMS);
//Dinh muc van toc 
 unsigned int   spTrai(int);      
 unsigned int   spPhai(int);   
 void Max();     
 void Min();
 void Ave(); 
 void Turn();
//Run - Line Or Ti
void RunAs(int);
void Up();
void Down();
void StopUp();
void StopDown();
void In();
void StopIn();
void Out();
void StopOut();
void RunOf(int);
void RunAsTime(int); 
void FStop();          
void TurnLeft();
void TurnRight();   
//Phuong an chien thuat   
void Vic1();
void Vic2();
void Vic3();
void Vic4();
void Vic5();
void Vic6();
// End phuong an            
//=========================================CHUONG TRINH CHINH DAY============================
interrupt [EXT_INT0] void ext_int0_isr(void)
{                                                 
// Place your code here                                                  
}
             
void main(void)
{      
        //Khoi tao chip
        Initial();   
        Out();Up();
        Delay(800);
        StopOut();    
        Delay(2200);StopUp();    
        while(Phim1&&Phim2&&Phim3&&Phim4&&Phim5&&Phim6){}
       	if(Phim1==0){ Vic1();}                             
	else if(Phim2==0){Vic2();}                   
	else if(Phim3==0){Vic3();}
	else if(Phim4==0){Vic4();}  
	else if(Phim5==0){Vic5();}  
	else if(Phim6==0){Vic6();}   
	else return;
}                                                                    
//=== END MAIN ============              

//====DINH MUC VAN TOC ==============      
 unsigned int   spTrai(int i){      
        switch(i){
                case 0:{
                        return 0;                
                }
                case 1:{
                        return(vt);                
                }
                case 2:{
                         return(vt*2);                
                }
                case 3:{
                        return(vt*3);                
                }       
                case 4:{
                        return(vt*4);                
                }
                case 5:{
                        return(vt*5);                
                }
                case 6:{
                        return(vt*6);                
                }                                                   
        }
}
 unsigned int   spPhai(int i){      
        switch(i){
                case 0:{
                        return 0;                
                }
                case 1:{
                        return(vp);                
                }
                case 2:{
                         return(vp*2);                
                }
                case 3:{
                        return(vp*3);                
                }       
                case 4:{
                        return(vp*4);                
                }
                case 5:{
                        return(vp*5);                
                }
                case 6:{
                        return(vp*6);                
                }                                                   
        }
}


void Max(){
        vt=intTraiMax; 
        vp=intPhaiMax;            
} 
 
void Min(){
        vt=intTraiMin;
        vp=intPhaiMin;
        
                     
}
void Ave(){
        vt=intTraiTrungBinh;              
        vp=intPhaiTrungBinh;              

}
void Turn(){
        vt=intCuaTrai;              
        vp=intCuaPhai;                         
          

} 
void St(){
        vt=stTrai;              
        vp=stPhai;      
          

}           
        
//---End dinh muc van toc 
  
//====VI TRI ROBOT ====
//------Vi tri robot -> Kiem tra Sensor ----------
unsigned  int RoboconLocation(){  
//        0       0       0       0       0       0       0       0
//        1       2       3       4       5       6       7       8
    
       //vi tri trung tam 2 sensor 4,5 =vach
        if(SensorTrungTamTrai == Vach & SensorTrungTamPhai==Vach)        
         	return 0 ; 
        //vung trai 2
        if(SensorTrungTamTrai==Vach & SensorTrai==Vach)
                return 22 ;
         //vung trai 1
 	if(SensorTrungTamTrai==Vach)
 	        return 21;
 	//vung phai 2
       	 if(SensorTrungTamPhai==Vach & SensorPhai==Vach)
 	        return 12 ;
        //vung phai 1
        if(SensorTrungTamPhai== Vach)
 	        return 11 ; 
        
       	//vung trai 4
        if(SensorTrai==Vach & SensorTraiNgoai==Vach)
 	        return 24 ;
        //vung trai 3
       	if( SensorTrai==Vach)
 	        return 23 ;
        //vung phai 4
       	 if(SensorPhai==Vach & SensorPhaiNgoai==Vach)
 	        return 14 ;
        //vung phai 3
       	 if( SensorPhai==Vach)
 	        return 13 ;
       	
       	//vung trai 5
       	if(SensorTraiNgoai==Vach)
	        return 25 ; 	       
        //vung phai 5
       	 if( SensorPhaiNgoai==Vach)
 	        return 15 ;
       	//vung phai 6
       	 if(bitVungPhai)
 	        return 16 ;	
         // vung trai 6
       	if(bitVungTrai)
 	        return 26 ;

}
//--End kiem tra cam bien ---
//=====DIEU KHIEN MOTOR-> DIEU KHIEN TRANG THAI ROBOT  
// Dieu khien huong Robot 
void RoboconVector(unsigned  int vec){
 switch(vec){
        case 1:    {
                DongCoTraiTien=Start;
                DongCoTraiLui =Stop; 
                DongCoPhaiTien=Start;
                DongCoPhaiLui=Stop;
              }                                    
                 break;
        case 2:{
                DongCoTraiTien=Stop;
                DongCoTraiLui =Start; 
                DongCoPhaiTien=Stop;
                DongCoPhaiLui=Start;
                }     
                 break;
        //Trai     
        case 3:{   
                //DC trai
                DongCoTraiTien=Stop;
                DongCoTraiLui =Start; 
                //DC phai
                DongCoPhaiTien=Start;
                DongCoPhaiLui=Stop;
        
        }     
        break;
        //Phai 
        case 4:{
                DongCoTraiTien=Start;
                DongCoTraiLui =Stop; 
                DongCoPhaiTien=Stop;
                DongCoPhaiLui=Start;
        }     
                break;
    }    
} 
//Set van toc 
void VanTocTraiPhai(int trai, int phai){
              VanTocTrai=spTrai(trai); 
              VanTocPhai=spPhai(phai);
          
      }
//
void RoboconController(unsigned  int control){
        RoboconVector(1); //
        switch(control){
        
        case 0:    
               VanTocTraiPhai(6,6);  
               // VanTocTrai=VanToc[6];
               //VanTocPhai=VanToc[6];    
        break;
        case 11:     
                // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
                VanTocTraiPhai(5,6);                     
            
        break;
        case 12:
                // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
                VanTocTraiPhai(4,6)  ;
                bitVungTrai=1;
                bitVungPhai=0;
     
        break;
        case 13:
                // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
                VanTocTraiPhai(3,6);
                bitVungTrai=1;
                bitVungPhai=0;

        
        break;
        case 14:
               // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
               VanTocTraiPhai(2,6);
               bitVungTrai=1;
               bitVungPhai=0;

             
        break;
        case 15:
               // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
               VanTocTraiPhai(1,6);                                                
                bitVungTrai=1;
                bitVungPhai=0;             
        break;
        case 16:
               // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
               VanTocTraiPhai(6,0);                                    
                    
        break;            
       case 21:
               // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
               VanTocTraiPhai(6,5);                
                    
        break;
        case 22:
               // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
               VanTocTraiPhai(6,4);                
               bitVungTrai=0;
               bitVungPhai=1;            
                  
               break;
         case 23:
               // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
               VanTocTraiPhai(6,3);                
               bitVungTrai=0;
               bitVungPhai=1;                
        break;
         case 24:
               // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
               VanTocTraiPhai(6,2);                
               bitVungTrai=0;
               bitVungPhai=1;                    
        break;
         case 25:
               // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
               VanTocTraiPhai(6,1);                
               bitVungTrai=0;
               bitVungPhai=1;                    
        break;
         case 26:
               // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
               VanTocTraiPhai(0,6);                


 }
} 
//=====DO DUONG ,DAY ============
//--Chay theo vach trang  --
void    Running(){       
      RoboconController(RoboconLocation());          
}   
//---Count Line ---
void CounterIsLine(){
 unsigned int y=3100;
unsigned int x = 100000;//50000;//20000 
	bit	QuaVachNgang = 0;	
	if((SensorDemTrai==Nen)&&(SensorDemPhai==Nen))
		return;					
	if(SensorDemTrai==Vach){		
		while(x>0){	
			x--;
			//DoDuong();
			Running();			
			if(SensorDemPhai==Vach && QuaVachNgang==0)
			{
				SoLanQuaVachNgang++;
				//P3_7 = 1 ; // Bao dem 
				QuaVachNgang = 1;
				while(y>0){
				        y--;
				        Running();
				}								
		  	}
			if (QuaVachNgang==1 & SensorDemPhai==Nen)
				return;
		}
	}
	else if(SensorDemPhai==Vach){		
		while(x>0){	
			x--;
			//DoDuong();		
			Running();
			if((SensorDemTrai==Vach) &( QuaVachNgang==0)){
				SoLanQuaVachNgang ++ ;	
				//P3_7 = 1 ; // Bao dem 
				QuaVachNgang=1;
				while(y>0){
				        y--;
				        Running();
				}				
			}
			if (QuaVachNgang==1 && SensorDemTrai==Nen)
				return;
		}
	}
}	
                                            

//--End dem vach ngang--       
//---Ham delays 1 mili giay---
void Delay(unsigned int SoMS)
{
 	unsigned long Time;
	while (SoMS--){
		for(Time=0;Time<300;Time++);
        }                      
}       
//---Dieu khien Robocon---

void RunAs(int intSoVachNgang )
{	
	
	do{ 
		Running();      
		//kiem tra qua vach ngang
                CounterIsLine();
	}
	while(SoLanQuaVachNgang < intSoVachNgang);
	SoLanQuaVachNgang = 0 ;
	FStop();
}
void RunOf(int intSoVachNgang )
{	
	Turn();
	do{ 
		Running();      
		//kiem tra qua vach ngang
                CounterIsLine();
	}
	while(SoLanQuaVachNgang < intSoVachNgang);
	//DelayMS(700) ;      
	SoLanQuaVachNgang = 0 ;     
	FStop();
}     
     
void RunAsTime(int intThoiGian)
{		
 	unsigned long Time; 	
	while (intThoiGian--)
	{
		for(Time=0;Time<300;Time++)		
		Running();			
	}  
	FStop();
} 
void FStop(){
	//Pulse_Trai = Stop;
	//Pulse_Phai = Stop ;
	DongCoTraiTien=!Tien;
	DongCoPhaiTien=!Tien;
	DongCoPhaiLui=!Lui;
	DongCoTraiLui=!Lui;
}  

void XuatPhat(){
        Turn();
        RunAsTime(80);//qua vung xuat phat

} 
void Up(){
DongCoCuonLen=1;
}
void Down(){
DongCoCuonXuong=1;
}  
void StopUp(){
DongCoCuonLen=0;
}
void StopDown(){
DongCoCuonXuong=0;
}       
void In(){
DongCoKep=1;
}    
void StopIn(){
DongCoKep=0;
}        
void Out(){
DongCoNha=1;
}
void StopOut(){
DongCoNha=0;
}  
void TurnLeft(){
       	FStop();
	Delay(300);                  
        Min();
while((SensorDemPhai==0)|(SensorTrungTamTrai==Vach)){
	DongCoPhaiTien = Tien;
	DongCoPhaiLui=!Tien; 	
	DongCoTraiTien  =  !Tien;
        DongCoTraiLui	 = Lui;
        VanTocTraiPhai(5,5);
	}

	do {
	VanTocTraiPhai(5,5);
	DongCoPhaiTien = Tien;      
	DongCoTraiTien =  !Tien;
  	DongCoTraiLui	 = Lui;
      }
while((SensorTrungTamPhai!=Vach)||(SensorTrungTamTrai!=Vach));
	DongCoTraiLui = !Lui; 
	DongCoPhaiTien = Tien;
	FStop();
	Delay(300);                  
}
//---          
void TurnRight(){
	FStop();
	Delay(300);                  
        Min();
while((SensorDemTrai==0)|(SensorTrungTamPhai==Vach)){
	DongCoTraiTien = Tien;
	DongCoTraiLui=!Tien; 	
	DongCoPhaiTien  =  !Tien ;
        DongCoPhaiLui	 = Lui ;
        VanTocTraiPhai(5,5);
	}
	do {
	VanTocTraiPhai(5,5);
	DongCoTraiTien = Tien  ;
	DongCoPhaiTien =  !Tien ;
  	DongCoPhaiLui	 = Lui ;
 	}
	while((SensorTrungTamTrai!=Vach)|(SensorTrungTamPhai!=Vach));
	DongCoPhaiLui = !Lui;
	DongCoTraiTien = Tien ;
	FStop();
	Delay(300);
}     
//Go to govia cuop qua vang 
void ToCentral( )
{ 

}     
//-------------------------------------------------------------------------  
//=============CAC PHUONG AN CHIEN THUAT===================================
void Vic1(){
int x=5000000;//wait phim 
        XuatPhat();
        RunOf(2);
        TurnRight();
        RunOf(1);
        Min();RunAs(2);
        RunOf(1);
        TurnLeft();
        RunOf(4);
        St();
        RunAsTime(35);
        FStop();
        //cho
        while(hAut){}
        //    
        while(x>0){x--;}
        while(hAut){}  
        Delay(1500);               
        while(hGovida){       
        Down();}    
        StopDown();
        Delay(200);               
        In();                 
        Delay(900);
        StopIn();    
        Down();Delay(1000);StopDown();       
        Delay(8000);
        //Delay(3000);//mod         
        Up();Delay(2100);StopUp;  
        Delay(1000);
        FStop();//mod
        RunOf(1);
        FStop();     
        while(1);
            
  }
void Vic2(){
        int x=5000000;//wait phim 
        XuatPhat();
        RunOf(1);
        Min();RunAs(2);
        RunOf(1);
        TurnRight();
        RunOf(1);
        Min();RunAs(2);
        RunOf(1);
        TurnLeft();
        RunOf(2);
        St();
        RunAsTime(38);
        FStop();
        //cho
        while(hAut){}
        //    
        while(x>0){x--;}
        while(hAut){}  
        Delay(1500);               
        while(hGovida){       
        Down();}    
        StopDown();
        Delay(200);               
        In();                 
        Delay(900);
        StopIn();    
        Down();Delay(1000);StopDown();       
        Delay(8000);         
        Up();Delay(2000);StopUp;  
        Delay(1000);  
        RunOf(1);
        FStop();
        while(1);
                
        }                            

void Vic3(){  
        int x=5000000;//wait phim 
        XuatPhat();
        RunOf(1); 
        Min();RunAs(3);
        RunOf(1);
        TurnRight();
        RunOf(1);   
        Min(); RunAs(2);   
        RunOf(1);   
        TurnLeft();
        //St();
        RunOf(1);
        //St();
        RunAsTime(50);
        FStop();
        //cho
        while(hAut){}
        //    
        while(x>0){x--;}
        while(hAut){}  
        Delay(1500);               
        while(hGovida){       
        Down();}    
        StopDown();
        Delay(200);               
        In();                 
        Delay(900);
        StopIn();    
        Down();Delay(1000);StopDown();       
        Delay(8000);         
        Up();Delay(2000);StopUp;  
        Delay(1000);  
        RunOf(1);
        FStop();     
        while(1);
}                    
void Vic4(){    
        int x=5000000;//wait phim 
        XuatPhat();
        RunOf(3); 
        TurnLeft();
        RunOf(1);
        RunAs(5);
        //St();
        RunOf(1);
        //St();
        RunAsTime(20);
        FStop();
        //cho
        while(hAut){}
        //    
        while(x>0){x--;}
        
        while(hAut){}  
        Delay(1500);               
        while(hGovida){       
        Down();}    
        StopDown();
        Delay(200);               
        In();                 
        Delay(900);
        StopIn();    
        Down();Delay(1000);StopDown();       
        Delay(8000);         
        Up();Delay(2000);StopUp;  
        Delay(1000);  
        RunOf(2);
        FStop();     
        while(1);

   
}
void Vic5(){  
        XuatPhat();
        RunOf(1);
        TurnRight();
        RunOf(1);
        Min();RunAs(3);
        RunOf(1);
        In();                 
        Delay(600);
        StopIn();    
        TurnLeft();
        RunOf(1);
        Min();
        RunAs(5);
        RunOf(2);
        TurnLeft();
        RunAs(3);
        while(1){
        RunOf(4);
        TurnRight();
        RunOf(1);
        RunAsTime(10);
        TurnRight();
        RunOf(4);
        TurnRight();
        RunOf(1);
        RunAsTime(10);
        TurnRight();
        Delay(5000); 
}
      
}
void Vic6(){
        XuatPhat();
        RunOf(1);
        Min();RunAs(3);
        RunOf(1);
        In();                 
        Delay(600);
        StopIn();   
        TurnRight();
        RunOf(1);
        Min();RunAs(1);
        RunOf(1);
        TurnLeft();
        RunOf(4);
        
        TurnLeft();
        RunAs(1);
    while(1){
        RunOf(4);
        TurnRight();
        RunOf(1);
        RunAsTime(10);
        TurnRight();
        RunOf(4);
        TurnRight();
        RunOf(1);   
        RunAsTime(10);
        TurnRight();
        Delay(5000); 
}       
}
//----End phuong an 

void Initial(){
// Declare your local variables here
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTB=0x00;
DDRB=0xFF;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=Out Func6=In Func5=In Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=T State5=T State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0x9F;

//-0--
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 125.000 kHz
// Mode: Fast PWM top=FFh
// OC0 output: Non-Inverted PWM
TCCR0=0x6A;
TCNT0=0x00;
OCR0=0x7F;   
//
TCCR2=0x6A;
TCNT2=0x00;
OCR2=0x6E;   
//---
//---


// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;   
// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;    
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00; 

//
// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Low level
// INT1: Off
// INT2: Off
GICR|=0x40;
MCUCR=0x00;
MCUCSR=0x00;
GIFR=0x40;    
///////////////
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 46.875 kHz
// Mode: Fast PWM top=FFh
// OC0 output: Non-Inverted PWM
TCCR0=0x6C;
TCNT0=0x00;
OCR0=0x00;
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 46.875 kHz
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
TCCR1A=0x00;
TCCR1B=0x04;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 46.875 kHz
// Mode: Fast PWM top=FFh
// OC2 output: Non-Inverted PWM
ASSR=0x00;
TCCR2=0x6E;
TCNT2=0x00;
OCR2=0x00;
// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;
// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;
}
