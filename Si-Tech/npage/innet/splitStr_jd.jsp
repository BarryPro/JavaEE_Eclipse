<%! 
/**将字符串按照tok分解取值**/
String oneTok(String strIn,char tok,int locIn)throws Exception
{
	  String  temStr=strIn;
	try
		{
	   if(strIn.charAt(0)==tok) {
		   temStr=strIn.substring(1,strIn.length());
	   }
	   if(strIn.charAt(strIn.length()-1)==tok) {
		   temStr=temStr.substring(0,temStr.length()-1);
	   }
		 int temLoc;
		 int temLen;
		 for(int ii=0;ii<locIn-1;ii++)
		 {
		     temLen=temStr.length();
		     temLoc=temStr.indexOf(tok);
		     temStr=temStr.substring(temLoc+1,temLen);
		 }
		 }catch(Exception e){
			 //e.printStackTrace();
		 }   
		 if(temStr.indexOf(tok)==-1){
			 return temStr;
		 }else{
			 return temStr.substring(0,temStr.indexOf(tok));
		 }
}

/**将字符串按照tok分解后,取得子字符串总数**/
int getTokNums(String strIn,char tok)throws Exception
{
  String temStr=strIn;
	   int temLen;
	   int temNum=1;
	   int temLoc=0;
	try{
	   if(strIn.charAt(0)==tok) temStr=strIn.substring(1,strIn.length());
	   if(strIn.charAt(strIn.length()-1)==tok) temStr=temStr.substring(0,temStr.length()-1);

	   while(temStr.indexOf(tok)!=-1)
	   {	
	      temLen=temStr.length();
	      temLoc=temStr.indexOf(tok);
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   }catch(Exception e){

		 }  
		 return temNum; 
}


String[][] getBillParamIn(String StrIn,String work_no,String work_name,HashMap hm1,HashMap hm2,String payType)throws Exception
{ 
System.out.println("============payType==========" + payType);
	String work_time, tmpStr, tmpKey;
	int classId = 0;
	String [][] classInfo = null;
	int range=0;
	int tmpcol=getTokNums(StrIn,'|') + 3;
	System.out.println("============wanghfa==========" + StrIn);
	System.out.println("=====in====="+getTokNums(StrIn,'|'));
	try{   
		classInfo=new String[3][tmpcol];
		work_time=new java.text.SimpleDateFormat("yyyy      MM      dd", Locale.getDefault()).format(new java.util.Date());	
		try{							
			classInfo[0][0]=(String)hm1.get("操作时间");classInfo[1][0]="0";classInfo[2][0]=work_time;
			classInfo[0][1]=(String)hm1.get("操作工号");classInfo[1][1]="0";classInfo[2][1]=work_no;
			classInfo[0][2]=(String)hm1.get("工号姓名");classInfo[1][2]="0";classInfo[2][2]=work_name;
				
			range=3;
		}catch(Exception e){
			e.printStackTrace();
		}
		

		
		for (int i = 1; i <= getTokNums(StrIn,'|'); i++){ 
			tmpStr = oneTok(StrIn,'|',i);

			tmpKey = oneTok(tmpStr,'：',1);

			System.out.println("------tmpKey--------"+tmpKey);
			
			
			if(hm1.get(tmpKey)!=null){
					System.out.println("============hm1========== 有标题");
					classInfo[0][range]=(String)hm1.get(tmpKey);
					classInfo[1][range]=Integer.toString(range);
					classId = Integer.parseInt(classInfo[0][range]);
					if(classId >= 30020 && classId < 30032) {
							if(payType.equals("BX")||payType.equals("BY")){
								classInfo[2][range] = tmpStr;
							}else{
								classInfo[2][range] = "　";
							}
					}else{
							classInfo[2][range] = tmpStr;
					}
			}else if(hm2.get(tmpKey)!=null){
					System.out.println("============hm2========== 无标题");
					classInfo[0][range]=(String)hm2.get(tmpKey);
					classInfo[1][range]=Integer.toString(range);
					classId = Integer.parseInt(classInfo[0][range]);
					classInfo[2][range] = oneTok(tmpStr, '：', 2);
			}
			
			

			System.out.println("============wanghfa==========" + classInfo[0][range]);
			System.out.println("============wanghfa==========" + classInfo[1][range]);
			System.out.println("============wanghfa==========" + classInfo[2][range]);



			tmpStr="";
			range++;
		}

		

	}catch(Exception e){
			e.printStackTrace();
	}  

	for(int i=0;i<classInfo.length;i++){
		for(int j=0;j<classInfo[i].length;j++){
			System.out.println("classinfo["+i+"]["+j+"]"+classInfo[i][j]);
		}
	}
	
	return classInfo;
}
%>