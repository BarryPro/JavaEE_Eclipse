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
String[][] getParamIn(String StrIn,String work_no,String work_name,HashMap hm,String favPassDesc)throws Exception
{ 
/*
  HashMap hm=new HashMap();
	hm.put("操作时间","10466");
	hm.put("操作工号","10087");
	hm.put("工号姓名","10091");
	hm.put("客户姓名","10574");
	hm.put("手机号码","10190");
	hm.put("客户地址","10064");
	hm.put("证件号码","10066");
	hm.put("受理内容","10697");
	hm.put("备注","10698");
**/
  String cust_info,opr_info,note_info,note_info1,note_info2,note_info3,note_info4,tmpStr,tmpKey,work_time;  
  String [][] classInfo = null;
  String infoStr=StrIn; 
  String workNo=work_no;
  String workName=work_name;
  int    range=0;
  int tmpcol=getTokNums(infoStr,'|')+2;
  System.out.println("=====in====="+getTokNums(infoStr,'|'));
  System.out.println((String)hm.get("操作时间"));
try{   
     classInfo=new String[3][tmpcol];
     work_time=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());	
   try{
	 	    classInfo[0][0]=(String)hm.get("操作时间");classInfo[1][0]="0";classInfo[2][0]=work_time+"   "+favPassDesc;
	 	    classInfo[0][1]=(String)hm.get("操作工号");classInfo[1][1]="0";classInfo[2][1]=workNo;
	 	    classInfo[0][2]=(String)hm.get("工号姓名");classInfo[1][2]="0";classInfo[2][2]=workName;
 	      range=2;
 	    }catch(Exception e){
				
     }  
		  cust_info=oneTok(infoStr,'#',1).trim();
		  opr_info=oneTok(infoStr,'#',2).trim();
		  note_info1=oneTok(infoStr,'#',3).trim();
		  note_info2=oneTok(infoStr,'#',4).trim();
		  note_info3=oneTok(infoStr,'#',5).trim();
		  note_info4=oneTok(infoStr,'#',6).trim();
		  

		 	
		  note_info1 = note_info1.replaceAll("\"","");
			note_info1 = note_info1.replaceAll("\'","");
			note_info1 = note_info1.replaceAll("\r\n","   ");  
			note_info1 = note_info1.replaceAll("\r","   "); 
			note_info1 = note_info1.replaceAll("\n","   "); 
			
			note_info2 = note_info2.replaceAll("\"","");
			note_info2 = note_info2.replaceAll("\'","");
			note_info2 = note_info2.replaceAll("\r\n","   ");  
			note_info2 = note_info2.replaceAll("\r","   "); 
			note_info2 = note_info2.replaceAll("\n","   "); 
			
			note_info3 = note_info3.replaceAll("\"","");
			note_info3 = note_info3.replaceAll("\'","");
			note_info3 = note_info3.replaceAll("\r\n","   ");  
			note_info3 = note_info3.replaceAll("\r","   "); 
			note_info3 = note_info3.replaceAll("\n","   "); 
			
			note_info4 = note_info4.replaceAll("\"","");
			note_info4 = note_info4.replaceAll("\'","");
			note_info4 = note_info4.replaceAll("\r\n","   ");  
			note_info4 = note_info4.replaceAll("\r","   "); 
			note_info4 = note_info4.replaceAll("\n","   "); 
		 
		  note_info=note_info1+note_info2+note_info3+note_info4;
		  
		  
			 for (int i=1;i<=getTokNums(cust_info,'|');i++){ 
			       tmpStr=oneTok(cust_info,'|',i);
			       tmpKey=oneTok(tmpStr,'：',1);
				     classInfo[0][range+1]=(String)hm.get(tmpKey);
				     classInfo[1][range+1]=Integer.toString(range);
				     classInfo[2][range+1]=tmpStr;
				     tmpStr="";
				     range++;
			 }
			 for (int j=1;j<=getTokNums(opr_info,'|');j++){ 
			     	 tmpStr=oneTok(opr_info,'|',j);
			         classInfo[0][range+1]=(String)hm.get("受理内容");
				     classInfo[1][range+1]=Integer.toString(range);
				     classInfo[2][range+1]=tmpStr;
				     tmpStr="";
				     range++;
		   }
	   	 for (int k=1;k<=getTokNums(note_info,'|');k++){ 
		         tmpStr=oneTok(note_info,'|',k);
		         classInfo[0][range+1]=(String)hm.get("备注");
			     classInfo[1][range+1]=Integer.toString(range);
			     classInfo[2][range+1]=tmpStr;
			     tmpStr="";
			     range++;
		   }
	  
	  
	  
   }catch(Exception e){
			e.printStackTrace();
	 }  

System.out.println((String)hm.get("受理内容"));
for(int i=0;i<classInfo.length;i++){
	for(int j=0;j<classInfo[i].length;j++){
		System.out.println("classinfo["+i+"]["+j+"]"+classInfo[i][j]);
	}
}

	  return classInfo;
}
%>

