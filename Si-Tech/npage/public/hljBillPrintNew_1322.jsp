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
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA realKey��"+realKey);
		
		
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
	String vir_no = request.getParameter("vir_no"); 
	//String check_seq = request.getParameter("check_seq"); 
	String check_seq = request.getParameter("ocpy_begin_no"); 
	String prNum = request.getParameter("prNum");
	if(prNum==null || prNum.equals("")) {
		prNum ="";
	}
	String invoiceNoteStr = (String)request.getParameter("invoiceNoteStr")==null?"":(String)request.getParameter("invoiceNoteStr"); //diling add ���ӷ�Ʊ��ע for ���ڵ���ǰ̨��Ʊ��ӡ������@2012/3/22
	String infoStr="";
	infoStr=retInfo;
  int tiaozhuan=0;
	String groupId = (String)session.getAttribute("groupId");
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	String s_yyt_name="";
	String bill_code = request.getParameter("bill_code");

 %>

 <wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
<%
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}
%> 

<%!	/**���ַ�������tok�ֽ�ȡֵ**/
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
		String sqlss =" select * from dcustmsg where phone_no ='"+oneTok(infoStr,7)+"'";
		String id_no="";
		System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ oneTok(infoStr,7) is "+oneTok(infoStr,7));
	%>
		<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11">
		<wtc:sql><%=sqlss%></wtc:sql>
	  </wtc:pubselect>
	  <wtc:array id="result1111" scope="end"/>
	<%
	System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ oneTok(infoStr,7) is "+oneTok(infoStr,7)+" and retCode11 is "+retCode11);
	//if(retCode11.equals("000000")||(retCode11=="000000")){
	if(result1111!=null &&result1111.length>0)
	{
	id_no=result1111[0][0];
	//out.println(id_no);
  }else {
  	//out.println("ȥidʧ���˰���");
	%>
		<script language="javascript">//alert("no value");</script>
	<%
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
	var localPath = "C:/billLogo.jpg";
  try
  {
 //alert("��ӡ��ʼ��������");
     //��ӡ��ʼ��
	
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	 var startCol=20;
     var startRow=7;
    /*20100528 liuxmc ��ӷ�Ʊ��α��*/
     
     printctrl.DrawImage(localPath,8,10,40,18);
	 
	 printctrl.Print(20,10,9, 0, oneTok(infoStr,"|",2)+oneTok(infoStr,"|",3)+oneTok(infoStr,"|",4));
	 printctrl.Print(115, 10, 9, 0, "���η�Ʊ����: <%=check_seq%>"); 
 
	printctrl.Print(13, 12, 9, 0, "�ͻ����ƣ�"+oneTok(infoStr,"|",5));

	 printctrl.Print(13, 13, 9, 0, "ҵ�����:���ŷ�Ʊ��ӡ");
	 printctrl.Print(125, 13, 9, 0, "�ͻ�Ʒ��: ");
	 
	 printctrl.Print(13, 15, 9, 0, "�ֻ����룺"+oneTok(infoStr,"|",7));
     printctrl.Print(48, 15, 9, 0, "Э����룺"+oneTok(infoStr,"|",6));
	 printctrl.Print(82, 15, 9, 0, "��������: ");
	 printctrl.Print(115, 15, 9, 0, "��ͬ��:");
	 printctrl.Print(115, 16, 9, 0, "֧Ʊ��:");
	 
	 printctrl.Print(115, 17, 9, 0, "����ͳ������:  ");

	 printctrl.Print(13,19,9,0, "�ϼƽ�(��д)"+oneTok(infoStr,"|",11));
	 printctrl.Print(60,19,9,0, "(Сд)"+"��"+oneTok(infoStr,"|",10)); //oneTok(infoStr,11);
											
	 printctrl.Print(13,21,9,0, "(��Ŀ)");
	        
	        printctrl.Print(13,23,9,0,oneTok(infoStr,"|",12));
			printctrl.Print(13,25,9,0,oneTok(infoStr,"|",13));
			printctrl.Print(13,27,9,0,oneTok(infoStr,"|",14));
			printctrl.Print(13,29,9,0,oneTok(infoStr,"|",15));



	 // end
	
  
	printctrl.Print(13, 31, 9, 0, "��ˮ�ţ�<%=loginAccept%>");

	printctrl.Print(54, 31, 9, 0, "��Ʊ�ˣ�<%=loginName%>");

	printctrl.Print(85, 31, 9, 0, "���ţ�<%=work_no%>");

	printctrl.Print(110, 31, 9, 0, "Ӫҵ����<%=s_yyt_name%>");
 
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
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>

</HTML>    
<%
	//liuxmc add  ��Ʊ���ӻ����������
		int ss=0;
		/*String[] inParas0 = new String[16];
		inParas0[0] = realKey+"";
		 
		inParas0[1] = loginAccept;
		inParas0[2] = op_code;
    inParas0[3] = work_no;
    inParas0[4] = oneTok(infoStr,2)+""+oneTok(infoStr,3)+""+oneTok(infoStr,4);
    inParas0[5] = oneTok(infoStr,7);
    inParas0[6] = id_no;
    inParas0[7] = oneTok(infoStr,6);
    inParas0[8] = oneTok(infoStr,11);
    inParas0[9] = oneTok(infoStr,10);
    inParas0[10] = oneTok(infoStr,12);
    inParas0[11] = oneTok(infoStr,13);
    inParas0[12] = oneTok(infoStr,14);
	inParas0[13] = oneTok(infoStr,15);
	inParas0[14] = oneTok(infoStr,8);
	inParas0[15] = oneTok(infoStr,9);
 */
    	    
 
		//�°淢ƱԤռ��ӡ
		String[] inParas0 = new String[29];
		//inParas0[0] = realKey+"";
		inParas0[0] = loginAccept;//��ˮ
		inParas0[1] = "zg55";//
		inParas0[2] = work_no;
		inParas0[3] = "";//û����
		inParas0[4] = oneTok(infoStr,7).trim();
		inParas0[5] = "0";//id_no ֻ������� ʵ�ڲ����ڳ������Լ�ȡһ��
		inParas0[6] = "0";//contract_no
		 
		inParas0[7] = "";//֧Ʊ���� 
		//xl add ��ƱԤռ״̬������ begin
		//��Ʊ���� ��Ʊ��� ���� group_id ��ע ��Ʊ���� 
		inParas0[8] = check_seq;//��Ʊ����;
		inParas0[9] = bill_code;//��Ʊ����;
		inParas0[10] = oneTok(infoStr,6);//Ʒ��
		inParas0[11] = oneTok(infoStr,10);//Сд���
		inParas0[12] = oneTok(infoStr,11);//��д���
		inParas0[13] = "�ϰ漯�ŷ�Ʊ��ӡ" ;
		
		//���νɷѽ�� ����ÿ����Ŷ���ɶ
		//xl add ��ƱԤռ״̬������ end
		inParas0[14] = "";//��ֵ˰��
		inParas0[15] = "0";//��ֵ˰��
		inParas0[16] = "0";//��ֵ˰��
		inParas0[17] = "0";//��ӡ����
		inParas0[18] = oneTok(infoStr,5).trim();//cust_name
		inParas0[19] = "";
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = "1";
		inParas0[27] ="0";//ͨ�û��� 
		System.out.println("====ִ�� s1300PrintInDB ��ʼ=======");
		String[][] result2 = new String[][]{};
%>		
		<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
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
			<wtc:param value="<%=inParas0[13]%>"/>
			<wtc:param value="<%=inParas0[14]%>"/>
			<wtc:param value="<%=inParas0[15]%>"/>
			<wtc:param value="<%=inParas0[16]%>"/>
			<wtc:param value="<%=inParas0[17]%>"/>
			<wtc:param value="<%=inParas0[18]%>"/>
			<wtc:param value="<%=inParas0[19]%>"/>
			<wtc:param value="<%=inParas0[20]%>"/>
			<wtc:param value="<%=inParas0[21]%>"/>
			<wtc:param value="<%=inParas0[22]%>"/>
			<wtc:param value="<%=inParas0[23]%>"/>
			<wtc:param value="<%=inParas0[24]%>"/>
			<wtc:param value="<%=inParas0[25]%>"/>
			<wtc:param value="<%=inParas0[26]%>"/>
			<wtc:param value="<%=inParas0[27]%>"/> 
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
					   // rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.",0);
						  rdShowMessageDialog("���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.������룺"+"<%=result2[0][0]%>",0);
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
		//inParas01[0] = String.valueof(ran+1);
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
		<wtc:service name="s1300PrintInDB" routerKey="region" routerValue="<%=regionCode%>"  outnum="2" >
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
					    rdShowMessageDialog("2���ӷ�Ʊ���ʧ��,ӪҵԱû��¼�뷢Ʊ�������¼��ķ�Ʊ�����Ѿ���ӡ���.",0);
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
		%>