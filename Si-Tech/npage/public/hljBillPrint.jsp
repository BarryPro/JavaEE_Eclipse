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
<%@ include file="/npage/public/publicPrintBillNum.jsp" %>
<HTML>
<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>
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

    String work_no =(String)session.getAttribute("workNo");
    String loginName =(String)session.getAttribute("workName");
    String org_code =(String)session.getAttribute("orgCode");
    String op_code = "1210";
    String regionCode = org_code.substring(0,2);
		String nopass = (String)session.getAttribute("password");	
		String paraStr[]=new String[37];

		 	paraStr[0]=op_code;
			paraStr[1]=work_no;
			paraStr[2]=nopass;
			paraStr[3]=org_code;


	request.setCharacterEncoding("GBK");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
	
	//Billing�ṩȡ���������
	java.util.Random r = new java.util.Random();
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	
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
	     System.out.println("-------------1143----------print_workNo="+print_workNo);
        System.out.println("-------------1143----------print_accept="+print_accept);
        System.out.println("-------------1143----------print_opName="+print_opName);
	}else{
%>
	  <SCRIPT type=text/javascript>
      rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
      location="<%=dirtPage%>";
	  </SCRIPT>
<%
	}
  
 %>
<SCRIPT type=text/javascript>

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
function doPrint()
{
  var infoStr="<%=retInfo%>";
  
  try
  {
     //��ӡ��ʼ��
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	/*liujian 2013-3-7 9:00:35 ��ӡ��Ʊlogo�ͷ�Ʊ���� begin*/
	<%
			if(printLogoFlag.equals("N"))
			{
				%>
				//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
					printctrl.DrawImage(localPath,8,10,40,18);//��������
				<%
			}
		%>
	/*liujian 2013-3-7 9:00:35 ��ӡ��Ʊlogo�ͷ�Ʊ���� end*/
   var rowInit = Number('<%=rowInit%>');
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0; 
		
	  var startCol=20;
    var startRow=7;
	
    printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",2)+oneTok(infoStr,"|",3)+oneTok(infoStr,"|",4));
	  printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ʵ�ͨ��ҵ");
	  printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���η�Ʊ���룺<%=bill_number%>");
		 
		printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��α�룺<%=ran%>");	//��Ʊ��α��
		
        printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�<%=print_workNo%>");  //����
		printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"������ˮ��<%=print_accept%>");//��ˮ
		printctrl.PrintEx(100, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"ҵ�����ƣ�<%=print_opName%>");//ҵ������
		
		printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͻ����ƣ�"+oneTok(infoStr,"|",5));//�û�����
		printctrl.PrintEx(100, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�"+oneTok(infoStr,"|",6));//����
 
		printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ֻ����룺"+oneTok(infoStr,"|",7));//�ƶ�̨��
		printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Э����룺"+oneTok(infoStr,"|",8));//Э�����
		printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"֧Ʊ���룺");//֧Ʊ����	
		
		printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ϼƽ�(��д)"+oneTok(infoStr,"|",10));//�ϼƽ��(��д)
		printctrl.PrintEx(100,rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(Сд)"+"��"+oneTok(infoStr,"|",11));//���(Сд)
		
		
        printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(��Ŀ)");//��Ŀ 
        printctrl.PrintEx(50, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",9)); 
    
		 var imei_temp = oneTok(infoStr,"|",15);
		 if( imei_temp != null && imei_temp != "") {
			printctrl.PrintEx(20, rowInit + 8, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,imei_temp);//IMEINo
		 }
	    var busiStr=oneTok(infoStr,"|",12);
	    for(var i=0;i<getTokNums(busiStr,"~");i++)
	    	printctrl.PrintEx(20, rowInit + 9 +i*1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
        //  printctrl.Print(20,rowInit + 8 +i*1,9,0,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
        
		/********tianyang add at 20090928 for POS�ɷ�����****start*****/
		var payType = oneTok(infoStr,"|",17);
		if (payType=="BX"||payType=="BY") {
			printctrl.PrintEx(13, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�̻����ƣ���Ӣ��)��"+oneTok(infoStr,"|",18));
		  
		  printctrl.PrintEx(13, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���׿��ţ����Σ��� "+oneTok(infoStr,"|",19));
			printctrl.PrintEx(62, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�̻����룺"+oneTok(infoStr,"|",20));
			printctrl.PrintEx(100, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���κţ�"+oneTok(infoStr,"|",21));
			
			printctrl.PrintEx(13, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,  "�����кţ�"+oneTok(infoStr,"|",22));
			printctrl.PrintEx(62, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ն˱��룺"+oneTok(infoStr,"|",23));
			printctrl.PrintEx(100, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ȩ�ţ�"+oneTok(infoStr,"|",24));
			
			printctrl.PrintEx(13, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��Ӧ����ʱ�䣺"+oneTok(infoStr,"|",25));
			printctrl.PrintEx(62, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ο��ţ�"+oneTok(infoStr,"|",26));
			printctrl.PrintEx(100, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��ˮ�ţ�"+oneTok(infoStr,"|",27));
			
			printctrl.PrintEx(13, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�յ��кţ�"+oneTok(infoStr,"|",28));
			printctrl.PrintEx(62, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "ǩ�֣�");
		}
    /********tianyang add at 20090928 for POS�ɷ�����****end*******/

                 
                 




	    printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ʊ��"+oneTok(infoStr,"|",13)); //����Ա
		printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�տ"+oneTok(infoStr,"|",14));//�տ�Ա 
		printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ˣ�");//�Ƿ����������Ʒ�
		   
 
	//��ӡ����
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
 	  rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
  }
  finally
  {
     location="<%=dirtPage%>";
  }
}

 </SCRIPT>
<!--**************************************************************************************-->
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY  onload="doPrint()">
          
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
