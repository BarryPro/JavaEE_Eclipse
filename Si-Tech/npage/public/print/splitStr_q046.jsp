<%! 
/**将字符串按照tok分解取值**/
String oneTok(String strIn,char tok,int locIn)throws Exception
{
	String  temStr=strIn;
	try{
		if(strIn.charAt(0)==tok) {
			temStr=strIn.substring(1,strIn.length());
		}
		if(strIn.charAt(strIn.length()-1)==tok) {
			temStr=temStr.substring(0,temStr.length()-1);
		}
		int temLoc;
		int temLen;
		for(int ii=0;ii<locIn-1;ii++){
			temLen=temStr.length();
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
		}
	}catch(Exception e){
		e.printStackTrace();
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
		if(strIn.charAt(0)==tok)
			temStr=strIn.substring(1,strIn.length());
		if(strIn.charAt(strIn.length()-1)==tok)
			temStr=temStr.substring(0,temStr.length()-1);

		while(temStr.indexOf(tok)!=-1){
			temLen=temStr.length();
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
			temNum++;
		}
	}catch(Exception e){}  
	return temNum; 
}



String[][] getParamIn(String city,String orderArrayId,String StrIn,String work_name,HashMap hm)throws Exception
{

	String cust_info,opr_info,tmpStr,tmpKey,tmpValue,work_time,opContent,head_info;
	String[] mytemp;
	String [][] classInfo = null;
	String infoStr=StrIn; 
	String workName=work_name;
	int    range=0;
	try{   
		
		work_time=new java.text.SimpleDateFormat("yyyy 年 MM 月 dd 日 HH 时 mm 分", Locale.getDefault()).format(new java.util.Date());	

		cust_info=oneTok(infoStr,'＃',1).trim();
		opr_info=oneTok(infoStr,'＃',2).trim();
		opContent=oneTok(infoStr,'＃',3).trim();


		int tmpcol=getTokNums(cust_info,'|')*2+getTokNums(opr_info,'|')+8;
		classInfo=new String[4][tmpcol+1];
		classInfo[0][0]=(String)hm.get("地市");classInfo[1][0]="0";classInfo[2][0]=city;classInfo[3][0]="0";
		classInfo[0][1]=(String)hm.get("订单号");  classInfo[1][1]="0";classInfo[2][1]=orderArrayId;classInfo[3][1]="0";
		classInfo[0][2]=(String)hm.get("登记时间");classInfo[1][2]="0";classInfo[2][2]=work_time;classInfo[3][2]="0";
		classInfo[0][3]=(String)hm.get("客户信息");classInfo[1][3]="0";classInfo[2][3]="客户信息";classInfo[3][3]="0";

		range=3;
		for (int i=1;i<=getTokNums(cust_info,'|');i++){
			tmpStr=oneTok(cust_info,'|',i);
			tmpKey=oneTok(tmpStr,'：',1);
			tmpValue=oneTok(tmpStr,'：',2);
			classInfo[0][range+1]=(String)hm.get(tmpKey);
			classInfo[1][range+1]=Integer.toString(range);
			classInfo[2][range+1]=tmpKey+"：";
			classInfo[3][range+1]="0";
			classInfo[0][range+2]=(String)hm.get(tmpKey)+"0";//内容classcode
			classInfo[1][range+2]=Integer.toString(range);
			classInfo[2][range+2]=tmpValue;
			classInfo[3][range+2]="0";
			tmpStr="";
			range+=2;
		}
		
		classInfo[0][range+1]=(String)hm.get("登记信息");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]="登记信息";
		classInfo[3][range+1]="0";
		classInfo[0][range+2]=classInfo[0][range+1]+"0";
		classInfo[1][range+2]=Integer.toString(range);
		classInfo[2][range+2]="（以下是您的登记信息，请你仔细核对，如有问题请向营业员咨询）";
		classInfo[3][range+2]="0";
		range+=2;

		classInfo[0][range+1]=(String)hm.get("登记事项");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]="登记事项：";
		classInfo[3][range+1]="0";
		classInfo[0][range+2]=classInfo[0][range+1]+"0";
		classInfo[1][range+2]=Integer.toString(range);
		classInfo[2][range+2]=opContent;
		classInfo[3][range+2]="0";
		range+=2;

		for (int j=1;j<=getTokNums(opr_info,'|');j++){ 
			tmpStr=oneTok(opr_info,'|',j);
			classInfo[0][range+1]=(String)hm.get("受理内容");
			classInfo[1][range+1]=Integer.toString(range);
			if(getTokNums(tmpStr,'^')>1){
				classInfo[2][range+1]=oneTok(tmpStr,'^',1);
				classInfo[3][range+1]=oneTok(tmpStr,'^',2);
			}else{
				classInfo[2][range+1]=tmpStr;
				classInfo[3][range+1]="0";
			}
			range++;
		}

		classInfo[0][range+1]=(String)hm.get("经办人信息");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]="经办人信息";
		classInfo[3][range+1]="0";
		/*
		classInfo[0][range+1]=(String)hm.get("用户尾信息");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]="用户尾信息";
		classInfo[3][range+1]="0";
		classInfo[0][range+2]=classInfo[0][range+1]+"0";
		classInfo[1][range+2]=Integer.toString(range);
		classInfo[2][range+2]="以上资料属实，已阅读并同意以上受理信息、背面所载之条款及各登记事项约定的协议内容。";
		classInfo[3][range+2]="0";
		range+=2;

		classInfo[0][range+1]=(String)hm.get("签字");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]="申请人/经办人签字";
		classInfo[3][range+1]="0";
		range++;

		classInfo[0][range+1]=(String)hm.get("章戳");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]="业务受理章戳";
		classInfo[3][range+1]="0";
		range++;

		classInfo[0][range+1]=(String)hm.get("页尾信息");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]="网上服务中心：www.ct10000.com";
		classInfo[3][range+1]="0";
		range++;
		*/
for(int i=0;i<classInfo[0].length;i++){
    if(classInfo[0][i] == null){
        classInfo[0][i] = classInfo[0][i] + "0";
    }
}
	  

   }catch(Exception e){
			e.printStackTrace();
	 }  

System.out.println("-------------------------retInfo----------------");
	for(int i=0;i<classInfo.length;i++){
		for(int j=0;j<classInfo[i].length;j++){
			System.out.print(classInfo[i][j]+"    ");
		}
		System.out.println();
	}
	  return classInfo;
}



String[][] getParamInForBill(String c,String StrIn,String work_no,String work_name,HashMap hm)throws Exception
{
  String phoneNo,opType,custName,tmpStr,tmpKey,work_time,detail,amount,city,accept;
  String [][] classInfo = null;
  String infoStr=StrIn; 
  String workNo=work_no;
  String workName=work_name;
  String content="";
  int    range=0;
  int tmpcol=getTokNums(infoStr,'|')*2+7;
  String idNo = "";
  String memo = "";
   

try{   
     classInfo=new String[4][tmpcol+1];
     work_time=new java.text.SimpleDateFormat("yyyy    MM    dd", Locale.getDefault()).format(new java.util.Date());	

	phoneNo=oneTok(infoStr,'#',1).trim();
	opType=oneTok(infoStr,'#',2).trim();
	custName=oneTok(infoStr,'#',3).trim();
	detail=oneTok(infoStr,'#',4).trim();
	amount=oneTok(infoStr,'#',5).trim();
	idNo =oneTok(infoStr,'#',6).trim();
	accept=oneTok(infoStr,'#',7).trim();
	memo=oneTok(infoStr,'#',8).trim();
	
	System.out.println("----------------memo--------------"+memo);
	
	classInfo[0][0]=(String)hm.get("登记时间");classInfo[1][0]="0";classInfo[2][0]=work_time;			classInfo[3][0]="0";
	classInfo[0][1]=(String)hm.get("号码");    classInfo[1][1]="0";classInfo[2][1]=phoneNo;				classInfo[3][1]="0";
	classInfo[0][2]=(String)hm.get("业务种类");classInfo[1][2]="0";classInfo[2][2]=opType;				classInfo[3][2]="0";
	classInfo[0][3]=(String)hm.get("客户名称");classInfo[1][3]="0";classInfo[2][3]=custName;			classInfo[3][3]="0";
	classInfo[0][4]=(String)hm.get("大写金额");classInfo[1][4]="0";classInfo[2][4]=changeBig2(amount)+"整";
	
	
	classInfo[3][4]="0";
	classInfo[0][5]=(String)hm.get("小写金额");classInfo[1][5]="0";classInfo[2][5]=amount;				        classInfo[3][5]="0";
	classInfo[0][6]=(String)hm.get("操作流水");classInfo[1][6]="0";classInfo[2][6]="           "+accept;	classInfo[3][6]="0";
	classInfo[0][7]=(String)hm.get("用户ID");    classInfo[1][7]="0";classInfo[2][7]=idNo;				              classInfo[3][7]="0";
	classInfo[0][8]=(String)hm.get("操作工号");classInfo[1][8]="0";classInfo[2][8]=work_no;               classInfo[3][8]="0";
	classInfo[0][9]=(String)hm.get("备注信息");classInfo[1][9]="0";classInfo[2][9]=memo;                    classInfo[3][9]="0";
	
	
	range=9;
  

			
	boolean s=true;		
	for (int i=1;i<=getTokNums(detail,'|');i++){ 
		s=s^true;
		tmpStr=oneTok(detail,'|',i);
		tmpKey=oneTok(tmpStr,'：',1);
		content=oneTok(tmpStr,'：',2);

		classInfo[0][range+1]=(String)hm.get("交费名称");
		classInfo[1][range+1]=Integer.toString(range);
		classInfo[2][range+1]=tmpKey+"：";
		classInfo[3][range+1]=s?"1":"0";
		classInfo[0][range+2]=(String)hm.get("交费金额");
		classInfo[1][range+2]=Integer.toString(range);
		classInfo[2][range+2]=content;
		classInfo[3][range+2]=s?"1":"0";
		tmpStr="";
		tmpKey="";
		range+=2;
	 }



   }catch(Exception e){
			e.printStackTrace();
	 }  
System.out.println("-------------------------retInfo----------------");
	for(int i=0;i<classInfo.length;i++){
		for(int j=0;j<classInfo[i].length;j++){
		System.out.println("--------classInfo["+i+"]["+j+"]----------"+classInfo[i][j]+"    ");
		}
		System.out.println();
	}
	 
	  
	  
	  
	  return classInfo;
}
/*------------金额转换--------------*/

private static String[] _UP={"零","壹","贰","叁","肆","伍","陆","柒","捌","玖"};
	private static String[] _UP2={"仟","佰","拾",""};
	private static String[] _UP3={"万","亿","兆","兆兆"};
	static String changeBig(String amount){//转换四位
		int l=amount.length();
		String result="";
		for(int i=l-1;i>=0;i--){
			char a=amount.charAt(i);
			if((int)a-48==0){//如果该位是0,则不输出单位
				if(!result.startsWith("零")){//如果重复出现零，就不输出
					result=_UP[((int)a-48)]+result;//不输出单位
				}
			}else{
				result=_UP[((int)a-48)]+_UP2[i+(4-l)]+result;//输出单位
			}
		}
		while(result.endsWith("零")){//去掉末尾的零
			result=result.substring(0,result.length()-1);
		}
		return result;
	}
	
	static String changeBigDot(String amount){
		String result="";
		if(amount.length()>=2){
			char a=amount.charAt(0);
			char b=amount.charAt(1);
			result=_UP[((int)a-48)]+"角"+_UP[((int)b-48)]+"分";
		}else{
			char a=amount.charAt(0);
			result=_UP[((int)a-48)]+"角";
		}
		return result;
	}
	
	static String addSpe(String amount,int splitsize){//给串加上分割符号
		String result="";
		int size=amount.length();
		int a=size%splitsize;
		result+=amount.substring(0,a)+",";
		for(int i=a;i<amount.length();i+=splitsize){
			result+=amount.substring(i,i+splitsize)+",";
		}
		if(result.startsWith(",")){
			result=result.substring(1,result.length());
		}

		return result.substring(0,result.length()-1);
	}
	static String changeBig2(String amountall){
		String result="";
		while(amountall.startsWith("0")){//截掉多余的0
			amountall=amountall.substring(1,amountall.length());
		}
		if(amountall.equals("")){
			result="零圆";
		}else{
			
			String[] amount=amountall.split("\\.");//如果有小数点，分割处理changeBig和changeBigDot
			
			String[] a=addSpe(amount[0],4).split(",");//按4位加标签','符，在分割
			for(int j=0,i=a.length-2;i>=0;i--,j++){
				result=changeBig(a[i])+_UP3[j]+result;//从低位向高位添加单位，如万，亿，兆
			}
			result=result+changeBig(a[a.length-1])+"圆";//然后拼上千以内的数
			if(amount.length>=2){
				result+=changeBigDot(amount[1]);//最后拼 角，分
			}
		}
		return result;
	}

%>