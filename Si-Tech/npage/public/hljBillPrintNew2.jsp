<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.04
********************/
%>
<!-------------------------------------------->
<!---����:  2003-10-23                    ---->
<!---����:  sunzhe                        ---->
<!---����:  fPubSimpSel.jsp               ---->
<!---���ܣ� ��ӡȷ�Ͻ���                  ---->
<!---�޸ģ�                               ---->



<!--
Setup ��ʾ��ӡ���öԻ��� 1 ��ʾ 0 ����ʾ
StartPrint ��ʼ��ӡ
PageStart �µ�ҳ
Print 
����1 x���꣨0 - 100��һ�����꣩
����2 y���꣨0 - 100��һ�����꣩
����3 �ֺţ�0 - 100��0Ϊϵͳȱʡ�ֺţ�
����4 �ִ�ϸ��0 - 10��0Ϊϵͳȱʡ��
����5 Ҫ��ӡ���ַ���

PageEnd ҳ����
StopPrint ֹͣ��ӡ
<!-------------------------------------------->
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<HTML>
<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>

<% 
		int ran=0;
		java.util.Random r = new java.util.Random();
		 ran = r.nextInt(9999);
		int ran1 = r.nextInt(10)*1000;
		if((ran+"").length()<4){
			ran = ran+ran1;
		}
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("realKey��"+realKey);
		
		
		String bill_type = "2";

    String work_no =(String)session.getAttribute("workNo");
    String loginName =(String)session.getAttribute("workName");
    String org_code =(String)session.getAttribute("orgCode");
    String regionCode = org_code.substring(0,2);
		String nopass = (String)session.getAttribute("password");	

	request.setCharacterEncoding("GBK");
	String retInfo=request.getParameter("retInfo");
	String infoStr2=request.getParameter("infoStr2");
	String dirtPage=request.getParameter("dirtPage");
	String op_code = request.getParameter("op_code");
	String loginAccept = request.getParameter("loginAccept");
	String prNum = request.getParameter("prNum");
	if(prNum==null || prNum.equals("")) {
		prNum ="";
	}
	
	
	String infoStr="";
	infoStr=retInfo;
  int tiaozhuan=0;
String strs = oneTok(infoStr,12);
    String bill_number = request.getParameter("bill_number");
	String printLogoFlag = request.getParameter("printLogoFlag");	
  	
  //��ӡ��ʼֵ
	int rowInit = 9;
	int fontSizeInit = 9;
	int fontStrongInit = 0;//0Ϊ���Ӵ�
	String fontType = "����";
	String vR = "0";
		
		

 %>
	 <%!
 	/**���ַ�������tok�ֽ�ȡֵ**/
   public String oneTok(String str,int loc){
  
		   String temStr="";
		   temStr=str;
		   if(str.charAt(0)=='|')  temStr=str.substring(1,str.length());
		   
		   if(str.charAt((str.length())-1)=='|')  temStr=temStr.substring(0,(temStr.length()-1));
		    
		
			 int temLoc;
			 int temLen;
			 
		    for(int ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length();
		       temLoc=temStr.indexOf("|");
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf("|")==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf("|"));
		    }

		    
  
 /**���ַ�������tok�ֽ��,ȡ�����ַ�������**/
	public int getTokNums(String str){
	    String temStr="";
		   temStr=str;
	   if(str.charAt(0)=='~') temStr=str.substring(1,str.length());
	   if(str.charAt((str.length())-1)=='~') temStr=temStr.substring(0,(temStr.length()-1));
	
	   int temLen;
	   int temNum=1;
	   int temLoc;
	   while(temStr.indexOf("~")!=-1)
	   {	
	      temLen=temStr.length();
	      temLoc=temStr.indexOf("~");
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   return temNum;
	}
 %>
 <%
 
	String print_workNo = "";
	String print_accept = "";
	String print_opName = "";
	String printMessage = oneTok(retInfo,1);
 
	if(printMessage.length()>0){
	    String resSplitMsg[] = printMessage.split("\\s{1,}")  ;
	    if(resSplitMsg.length==3){
	      print_workNo = resSplitMsg[0];
        print_accept = resSplitMsg[1];
        print_opName = resSplitMsg[2];
	    }else if(resSplitMsg.length==2){
        print_workNo = resSplitMsg[0];
        print_accept = resSplitMsg[1];
        print_opName = "";
	    }else{
	      print_workNo = resSplitMsg[0];
        print_accept = "";
        print_opName = "";
	    }
	}else{
%>
	  <SCRIPT type=text/javascript>
      rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
      location="<%=dirtPage%>";
	  </SCRIPT>
<%
	}
 %>
	 <%
	String sqlss =" select * from dcustmsg where phone_no ='"+oneTok(infoStr,7)+"'";
	String id_no="";
	%>
		<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11">
		<wtc:sql><%=sqlss%></wtc:sql>
	  </wtc:pubselect>
	  <wtc:array id="result1111" scope="end"/>
	<%
	if(retCode11.equals("000000")){
	if(result1111.length>0) {
	id_no=result1111[0][0];
	}else {
		id_no =oneTok(infoStr,7);
	}
	//out.println(id_no);
  }else {
  	//out.println("ȥidʧ���˰���");
	}
%>
<SCRIPT type=text/javascript>
var locat ="";
var ranss="";
	/**���ַ�������tok�ֽ�ȡֵ**/
   function oneTok(str,tok,loc){
		   var temStr=str;
		   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
			 var temLoc;
			 var temLen;
		    for(ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length;
		       temLoc=temStr.indexOf(tok);
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf(tok)==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf(tok));
  }

	/**���ַ�������tok�ֽ��,ȡ�����ַ�������**/
	function getTokNums(str,tok){
	   var temStr=str;
	   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
	   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
	
	   var temLen;
	   var temNum=1;
	   while(temStr.indexOf(tok)!=-1)
	   {	
	      temLen=temStr.length;
	      temLoc=temStr.indexOf(tok);
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   return temNum;
	}
function loc() {
locat="2";
}
function rans() {
ranss="2";
}
function doPrint(ss)
{
	
	var infoStr=ss;
  try
  {
 //alert("��ӡ��ʼ��������");
     //��ӡ��ʼ��
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();
	 /*liujian 2013-3-7 9:00:35 ��ӡ��Ʊlogo�ͷ�Ʊ���� begin*/
	<%
		if(printLogoFlag.equals("N"))
		{
			%>
				var localPath = "c:/billLogo.jpg";
			//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
				printctrl.DrawImage(localPath,8,10,40,18);//��������
			<%
		}
	%>
	var rowInit = Number('<%=rowInit%>');
	var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
	var fontType = "����";//����
	var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
	var vR = 0;
	var lineSpace = 0;
	/*liujian 2013-3-7 9:00:35 ��ӡ��Ʊlogo�ͷ�Ʊ���� end*/
	  var startCol=20;
    var startRow=7;
    /*20100528 liuxmc ��ӷ�Ʊ��α��*/
    
   printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace, oneTok(infoStr,"|",2)+oneTok(infoStr,"|",3)+oneTok(infoStr,"|",4));
   printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ʵ�ͨ��ҵ");
   printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���η�Ʊ���룺<%=bill_number%>");

   if(ranss=="") {
		printctrl.PrintEx(13,rowInit + 2, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��α�룺<%=ran%>");
    }else {
		printctrl.PrintEx(13,rowInit + 2, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��α�룺<%=ran+1%>");
    ranss="";
    }
    
   printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��    �ţ�<%=print_workNo%>");//����
	 printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "������ˮ��<%=loginAccept%>");
	 printctrl.PrintEx(100, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "ҵ�����ƣ�<%=print_opName%>"); //����д��sql ��func_name
	 
	 printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ͻ����ƣ�"+oneTok(infoStr,"|",5));
	 printctrl.PrintEx(100, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��    �ţ�"+oneTok(infoStr,"|",6));
    
    
	 printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ֻ����룺"+oneTok(infoStr,"|",7));
	 printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "Э����룺");
	 printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "֧Ʊ���룺");
	 
	 printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ϼƽ�(��д)"+oneTok(infoStr,"|",10));
	 printctrl.PrintEx(100, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "(Сд)"+"��"+oneTok(infoStr,"|",11)); //oneTok(infoStr,11);
											
	 printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(��Ŀ)");//��Ŀ 
	 printctrl.PrintEx(50, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",9));        
	 
	 var imei_temp = oneTok(infoStr,"|",15);
	 if( imei_temp != null && imei_temp != "") {
		//printctrl.print(40,17,9,0,imei_temp);//IMEINo
		printctrl.PrintEx(20, rowInit + 8, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,imei_temp);//IMEINo
	 }
     var busiStr=oneTok(infoStr,"|",12);
	    for(var i=0;i<getTokNums(busiStr,"~");i++)
       //   printctrl.Print(20,18+i*1,9,0,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
       printctrl.PrintEx(20, rowInit + 9 +i*1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ


	 // end
	
	
    /*******************************************/  
  

		/********tianyang add at 20090928 for POS�ɷ�����****start*****/
		var printLine = 0;
		var payType = oneTok(infoStr,"|",17);
		if (payType=="BX"||payType=="BY") {
			printctrl.PrintEx(13, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�̻����ƣ���Ӣ��)��"+oneTok(infoStr,"|",18));
			
			printctrl.PrintEx(13, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���׿��ţ����Σ��� "+oneTok(infoStr,"|",19));
			printctrl.PrintEx(62, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�̻����룺"+oneTok(infoStr,"|",20));
			printctrl.PrintEx(100, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���κţ�"+oneTok(infoStr,"|",21));
			
			printctrl.PrintEx(13, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�����кţ�"+oneTok(infoStr,"|",22));
			printctrl.PrintEx(62, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ն˱��룺"+oneTok(infoStr,"|",23));
			printctrl.PrintEx(100, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ȩ�ţ�"+oneTok(infoStr,"|",24));
			
			printctrl.PrintEx(13, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��Ӧ����ʱ�䣺"+oneTok(infoStr,"|",25));
			printctrl.PrintEx(62, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ο��ţ�"+oneTok(infoStr,"|",26));
			printctrl.PrintEx(100, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��ˮ�ţ�"+oneTok(infoStr,"|",27));
			
			printctrl.PrintEx(13, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�յ��кţ�"+oneTok(infoStr,"|",28));
			printctrl.PrintEx(62, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "ǩ�֣�");
		}else if (payType=="EI") {
			printctrl.PrintEx(13, 23, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�̻����ƣ���Ӣ��)��"+oneTok(infoStr,"|",18));
			
			printctrl.PrintEx(13, 23, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���׿��ţ����Σ��� "+oneTok(infoStr,"|",19));
			printctrl.PrintEx(62, 23, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�̻����룺"+oneTok(infoStr,"|",20));
			printctrl.PrintEx(100, 23, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���κţ�"+oneTok(infoStr,"|",21));
			
			printctrl.PrintEx(13, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�����кţ�"+oneTok(infoStr,"|",22));
			printctrl.PrintEx(62, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ն˱��룺"+oneTok(infoStr,"|",23));
			printctrl.PrintEx(100, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ȩ�ţ�"+oneTok(infoStr,"|",24));
			
			printctrl.PrintEx(13, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��Ӧ����ʱ�䣺"+oneTok(infoStr,"|",25));
			printctrl.PrintEx(62, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ο��ţ�"+oneTok(infoStr,"|",26));
			printctrl.PrintEx(100, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��ˮ�ţ�"+oneTok(infoStr,"|",27));
			
			printctrl.PrintEx(13, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�յ��кţ�"+oneTok(infoStr,"|",28));
			printctrl.PrintEx(62, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "ǩ�֣�");
			var transTotalStr = replaceStr(oneTok(infoStr,"|",29));
			for(;printLine < transTotalStr.length/60; printLine++){
			//	printctrl.Print(13, 29+printLine, 7, 0, transTotalStr.substr(printLine*60,60));
				printctrl.PrintEx(13,27 + printLine ,fontType, fontSizeInit,vR, fontStrongInit,lineSpace, transTotalStr.substr(printLine*60,60));
			}
			printLine--;
		}
    /********tianyang add at 20090928 for POS�ɷ�����****end*******/

		
   	 printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��Ʊ��"+oneTok(infoStr,"|",13));
  	 printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�տ"+oneTok(infoStr,"|",14));
  	 printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���ˣ�");
	
	//��ӡ����
	printctrl.PageEnd();
	printctrl.StopPrint();
  //alert("��ӡ������������");
  }
  catch(e)
  {
 	  rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
  	alert(e.printstacktrace());	//wanghfa �����޸�
  }
   finally
  {
  if(locat=="2") {
    locat="";
    location="<%=dirtPage%>";
    }
  }

}
function replaceStr(str){
			str = str.replace(/\s+/g, " ");
			return str;
		}

 </SCRIPT>
<!--**************************************************************************************-->
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY >
          
    </BODY>
</FORM>
<!-------�����ӡ�ؼ�---------->
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
		codebase="/ocx/PrintEx.dll#version=1,1,0,5" 
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</HTML>    
<%
	/*liujian 2012-7-12 9:49:26 9994��Ʊ�����*/
	if(op_code == null || (op_code !=null && !"9994".equals(op_code))) {
	//liuxmc add  ��Ʊ���ӻ����������
		int ss=0;
		String busiStr=oneTok(infoStr,12);
		ss =getTokNums(busiStr);
		String[] inParas0 = new String[24 + ss];
		inParas0[0] = realKey+"";
		inParas0[1] = loginAccept;
		inParas0[2] = op_code;
    inParas0[3] = work_no;
    inParas0[4] = oneTok(infoStr,2)+""+oneTok(infoStr,3)+""+oneTok(infoStr,4);
    inParas0[5] = oneTok(infoStr,7);
    inParas0[6] = id_no;
    inParas0[7] = oneTok(infoStr,6);
    inParas0[8] = oneTok(infoStr,8);
    inParas0[9] = oneTok(infoStr,9);
    inParas0[10] = oneTok(infoStr,15);
    inParas0[11] = oneTok(infoStr,10);
    inParas0[12] = oneTok(infoStr,11);
    
    	   // out.println(12+ss);
    	    
    	    
	    for(int i=0;i<getTokNums(busiStr);i++) 
           inParas0[12+1+i] = oneTok(busiStr,i+1);  //ҵ����Ŀ
    
    /********tianyang add at 20090928 for POS�ɷ�����****start*****/
		String payType = oneTok(infoStr,17);
	  if(!oneTok(infoStr,21).equals(" ") || !oneTok(infoStr,22).equals(" ") ) {
    	   // out.println("wuwuwu"); 	 
    inParas0[ss+12+1] = oneTok(infoStr,18);
    inParas0[ss+12+2] = oneTok(infoStr,19);
    inParas0[ss+12+3] = oneTok(infoStr,20);
    inParas0[ss+12+4] = oneTok(infoStr,21);
    inParas0[ss+12+5] = oneTok(infoStr,22);
    inParas0[ss+12+6] = oneTok(infoStr,23);
    inParas0[ss+12+7] = oneTok(infoStr,24);
    inParas0[ss+12+8] = oneTok(infoStr,25);
    inParas0[ss+12+9] = oneTok(infoStr,26);
    inParas0[ss+12+10] = oneTok(infoStr,27);
    inParas0[ss+12+11] = oneTok(infoStr,28);
      }

		System.out.println("====ִ�� s1300PrintInDB ��ʼ=======");
		String[][] result2 = new String[][]{};
%>		
		<wtc:service name="s1300PrintInDB" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
			<wtc:param value="<%=inParas0[0]%>"/>
			<wtc:param value="<%=inParas0[1]%>"/>
			<wtc:param value="<%=inParas0[2]%>"/>
			<wtc:param value="<%=inParas0[3]%>"/>
			<wtc:param value="<%=inParas0[4]%>"/>
			<wtc:param value="<%=inParas0[5]%>"/>
			<wtc:param value="<%=inParas0[6]%>"/>
			<wtc:param value="<%=inParas0[7]%>"/>
			<wtc:param value="<%=inParas0[8]%>"/>
			<wtc:param value="<%=inParas0[9]%>"/>
			<wtc:param value="<%=inParas0[10]%>"/>
			<wtc:param value="<%=inParas0[11]%>"/>
			<wtc:param value="<%=inParas0[12]%>"/>
				<%
				  for(int is=0;is<getTokNums(busiStr);is++) {
				  %>
				  <wtc:param value="<%=inParas0[12+1+is]%>"/>
				  <%
				  }			
				   if(!oneTok(infoStr,21).equals(" ") || !oneTok(infoStr,22).equals(" ") ) {
				%>
			<wtc:param value="<%=inParas0[ss+12+1]%>"/>
			<wtc:param value="<%=inParas0[ss+12+2]%>"/>
			<wtc:param value="<%=inParas0[ss+12+3]%>"/>
			<wtc:param value="<%=inParas0[ss+12+4]%>"/>
			<wtc:param value="<%=inParas0[ss+12+5]%>"/>
			<wtc:param value="<%=inParas0[ss+12+6]%>"/>
			<wtc:param value="<%=inParas0[ss+12+7]%>"/>
			<wtc:param value="<%=inParas0[ss+12+8]%>"/>
			<wtc:param value="<%=inParas0[ss+12+9]%>"/>
			<wtc:param value="<%=inParas0[ss+12+10]%>"/>
			<wtc:param value="<%=inParas0[ss+12+11]%>"/>
				<%}%>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
<%
		System.out.println("====ִ�� s1300PrintInDB ����=======");
		if(RetResult.length > 0)
		{
			result2 = RetResult;
			if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.",0);
					    					   		<%
			    if(!prNum.equals("2")) {//�������Ҫ��ӡ�ڶ��·�Ʊ��
			    %>
		//	alert("111");
			    loc();

			  	<%}%>
					     //doPrint('<%=retInfo%>');
					    //document.location.replace("<%=dirtPage%>");
					    location="<%=dirtPage%>";
					</script>
        <%			
			}	else {
		%>
			<script language="JavaScript">
					   rdShowMessageDialog("���ӷ�Ʊ���ɹ�.");
					   //document.location.replace("<%=dirtPage%>");
					   		<%
			    if(!prNum.equals("2")) {//�������Ҫ��ӡ�ڶ��·�Ʊ��
			    %>
		//	alert("111");
			    loc();

			  	<%}%>
					   doPrint('<%=retInfo%>');
					   
					</script>
		<%

		}						
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,s1300PrintInDB���񷵻ؽ��Ϊ��.",0);
					    					   		<%
			    if(!prNum.equals("2")) {//�������Ҫ��ӡ�ڶ��·�Ʊ��
			    %>
		//	alert("111");
			    loc();

			  	<%}%>
					    //doPrint('<%=retInfo%>');
					   //document.location.replace("<%=dirtPage%>");
					   location="<%=dirtPage%>";
					</script>
<%			
		}
		else {
		%>
			<script language="JavaScript">
									   		<%
			    if(!prNum.equals("2")) {//�������Ҫ��ӡ�ڶ��·�Ʊ��
			    %>
		//	alert("111");
			    loc();

			  	<%}%>
					    //doPrint('<%=retInfo%>');
					    location="<%=dirtPage%>";
					</script>
		<%
		}

		%>
		<%
			if(prNum.equals("2")) {//�������Ҫ��ӡ�ڶ��·�Ʊ��
				%>
			<script language="JavaScript">
					 // alert("222222222222");
					</script>
		<%
		
		//liuxmc add  ��Ʊ���ӻ����������
		int ssm=0;
		//out.println("-------------------"+infoStr2);
		String[] inParas01 = new String[26];
		inParas01[0] = (realKey+1)+"";
		inParas01[1] = loginAccept;
		inParas01[2] = op_code;
    inParas01[3] = work_no;
    inParas01[4] = oneTok(infoStr2,2)+""+oneTok(infoStr2,3)+""+oneTok(infoStr2,4);
    inParas01[5] = oneTok(infoStr2,7);
    inParas01[6] = id_no;
    inParas01[7] = oneTok(infoStr2,8);
    inParas01[8] = oneTok(infoStr2,6);
    inParas01[9] = oneTok(infoStr2,9);
    inParas01[10] = oneTok(infoStr2,15);
    inParas01[11] = oneTok(infoStr2,10);
    inParas01[12] = oneTok(infoStr2,11);
    
    	    String busiStr1=oneTok(infoStr2,12);
    	    ssm =getTokNums(busiStr1);
	    for(int i=0;i<getTokNums(busiStr1);i++)
           inParas01[12+1+i] = oneTok(busiStr1,i+1);  //ҵ����Ŀ
    
    /********tianyang add at 20090928 for POS�ɷ�����****start*****/
    	  if(!oneTok(infoStr,21).equals(" ") || !oneTok(infoStr,22).equals(" ") ) {
    	    //out.println("wuwuwu"); 	
		String payType1 = oneTok(infoStr2,17);
    inParas01[ssm+12+1] = oneTok(infoStr2,18);
    inParas01[ssm+12+2] = oneTok(infoStr2,19);
    inParas01[ssm+12+3] = oneTok(infoStr2,20);
    inParas01[ssm+12+4] = oneTok(infoStr2,21);
    inParas01[ssm+12+5] = oneTok(infoStr2,22);
    inParas01[ssm+12+6] = oneTok(infoStr2,23);
    inParas01[ssm+12+7] = oneTok(infoStr2,24);
    inParas01[ssm+12+8] = oneTok(infoStr2,25);
    inParas01[ssm+12+9] = oneTok(infoStr2,26);
    inParas01[ssm+12+10] = oneTok(infoStr2,27);
    inParas01[ssm+12+11] = oneTok(infoStr2,28);
    }

		System.out.println("====ִ�� s1300PrintInDB ��ʼ=======");
		String[][] result21 = new String[][]{};
		%>
		<wtc:service name="s1300PrintInDB" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
			<wtc:param value="<%=inParas01[0]%>"/>
			<wtc:param value="<%=inParas01[1]%>"/>
			<wtc:param value="<%=inParas01[2]%>"/>
			<wtc:param value="<%=inParas01[3]%>"/>
			<wtc:param value="<%=inParas01[4]%>"/>
			<wtc:param value="<%=inParas01[5]%>"/>
			<wtc:param value="<%=inParas01[6]%>"/>
			<wtc:param value="<%=inParas01[7]%>"/>
			<wtc:param value="<%=inParas01[8]%>"/>
			<wtc:param value="<%=inParas01[9]%>"/>
			<wtc:param value="<%=inParas01[10]%>"/>
			<wtc:param value="<%=inParas01[11]%>"/>
			<wtc:param value="<%=inParas01[12]%>"/>
				<%
				  for(int is=0;is<getTokNums(busiStr1);is++) {
				  %>
				  <wtc:param value="<%=inParas01[12+1+is]%>"/>
				  <%
				  }
				  	  if(!oneTok(infoStr,21).equals(" ") || !oneTok(infoStr,22).equals(" ") ) {
    	    //out.println("wuwuwu"); 				
				%>
			<wtc:param value="<%=inParas01[ss+12+1]%>"/>
			<wtc:param value="<%=inParas01[ss+12+2]%>"/>
			<wtc:param value="<%=inParas01[ss+12+3]%>"/>
			<wtc:param value="<%=inParas01[ss+12+4]%>"/>
			<wtc:param value="<%=inParas01[ss+12+5]%>"/>
			<wtc:param value="<%=inParas01[ss+12+6]%>"/>
			<wtc:param value="<%=inParas01[ss+12+7]%>"/>
			<wtc:param value="<%=inParas01[ss+12+8]%>"/>
			<wtc:param value="<%=inParas01[ss+12+9]%>"/>
			<wtc:param value="<%=inParas01[ss+12+10]%>"/>
			<wtc:param value="<%=inParas01[ss+12+11]%>"/>
				<%}%>
		</wtc:service>
		<wtc:array id="RetResult2" scope="end"/>
		<%
		System.out.println("====ִ�� s1300PrintInDB ����=======");
		if(RetResult2.length > 0)
		{
			result21 = RetResult2;
			if((result21[0][0]!="000000")&&!result21[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.",0);
					    loc();
					    rans();
					   // doPrint('<%=infoStr2%>');
					    //document.location.replace("<%=dirtPage%>");
					    location="<%=dirtPage%>";
					</script>
        <%			
			}	else {
		%>
			<script language="JavaScript">
					   rdShowMessageDialog("���ӷ�Ʊ���ɹ�.");
					   loc();
					   rans();
					   //document.location.replace("<%=dirtPage%>");
					   doPrint('<%=infoStr2%>');
					   
					</script>
		<%
		}					
		}
		else if(RetResult2 == null || RetResult2.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,s1300PrintInDB���񷵻ؽ��Ϊ��.",0);
					    loc();
					    rans();
					    //doPrint('<%=infoStr2%>');
					   //document.location.replace("<%=dirtPage%>");
					   location="<%=dirtPage%>";
					</script>
<%			
		}
		else {
		%>
			<script language="JavaScript">
			    	loc();
			    	rans();
					  //doPrint('<%=infoStr2%>');
					  location="<%=dirtPage%>";
					</script>
		<%
		}	
		}			
		}else { 
			System.out.println("----liujian----no 1300---");	
		%>
		<script language="JavaScript">
			loc();
			doPrint('<%=retInfo%>');
		</script>
		<%}%>