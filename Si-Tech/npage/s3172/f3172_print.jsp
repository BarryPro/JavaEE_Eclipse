   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-11
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
 
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

  //20100528 liuxmc ��ӷ�Ʊ��α��
		java.util.Random r = new java.util.Random();
		int ran = r.nextInt(9999);
		int ran1 = r.nextInt(10)*1000;
		if((ran+"").length()<4){
			ran = ran+ran1;
		}
		System.out.println("ran��" + ran);
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("realKey��"+realKey);

 	String s_yyt_name="";
  String parm = (String)request.getParameter("parm");//��ˮ
  String contract_no = (String)request.getParameter("contract_no");
  String phoneNo = request.getParameter("phoneNo");
  //��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");          								//����
	String workName =(String)session.getAttribute("workName"); 
  String regionCode = (String)session.getAttribute("regCode");
  String groupId = (String)session.getAttribute("groupId");
  String ifRed = request.getParameter("ifRed");
  //xl add
  String paySeq = request.getParameter("payAccept");
	String check_seq = request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");
  String smop_code = "3172";
  String bill_code = request.getParameter("bill_code");
	String returnPage = "f3172_1.jsp";
	String total_date=new java.text.SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
  String s_id_no="";
  String sm_name  =request.getParameter("s_sm_name");
  String s_sm_code =request.getParameter("s_sm_code");
  String result0  =  "";			//0	������                
	String result1 =  "";				//1	������Ϣ	            
	String result2  =  "";         
	String result3  = "";     
	String result4  =  "";          
	String result5  =  "";           
	String result6  = "";       
	String result7  =  "";             
	String result8  =  "";
	String result9  = "";
	String result10  =  "";
	String result11  =  "";  
	String result12  = "";
	String result13  =  "";
	String result14  =  "";     
	String result15  = "";   
	String result16  =  "";   
	String result17  =  "";
  
  
   
	String[] inParas = new String[4];
	inParas[0] = workNo;
	inParas[1] = contract_no;
	inParas[2] = total_date;
	inParas[3] = parm;
    
  for(int i=0;i<inParas.length;i++){
 		System.out.println("--------------------------inParas["+i+"]:------------------"+inParas[i]);
 	}
	//acceptList = callView.callFXService("s3185Cfm", inParas, "16");
	
	//hq add ����contract_no��ѯid_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +"a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contract_no;
		
	//xl add ������֯�ڵ��ѯӪҵ������
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	
	
	//xl add for sunby ���췢Ʊ��ӡչʾ
	String s_name_new="";
	String[] inParam_name = new String[2];
	inParam_name[0]="select b.unit_name from dconmsg a,dgrpcustmsg b where a.con_cust_id=b.cust_id and a.contract_no=:contract_no";
	inParam_name[1]="contract_no="+contract_no;
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam_name[0]%>"/>
		<wtc:param value="<%=inParam_name[1]%>"/>
	</wtc:service>
	<wtc:array id="new_name_arr" scope="end" />
<%
	if(new_name_arr!=null&&new_name_arr.length>0)
	{
		s_name_new = new_name_arr[0][0];
	}
%>

	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
		
		
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
	<wtc:param value="<%=inParam_idno[0]%>"/>
	<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
		
		
    <wtc:service name="s3185Cfm" outnum="16" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />			
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%	
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}
	
		
	String return_code = code;
	String error_msg = msg;
	

 	if(id_no_arr!=null&&id_no_arr.length>0){
        	s_id_no = id_no_arr[0][0];
        	phoneNo = id_no_arr[0][1].trim();
  }
	
	
 	System.out.println("--------------------return_code:-----------------"+return_code);
 	System.out.println("--------------------error_msg:------------------"+error_msg);
 	
 	
 	
if ( return_code.equals("000000")||return_code.equals("0") ){
	result0 	= result_t[0][0];	//0	������ 
	result1 	= result_t[0][1];    //1	������Ϣ
	result2 	= result_t[0][2];            
	result3  	= result_t[0][3];
	result4  	= result_t[0][4];
	result5  	= result_t[0][5];    
	result6 	= result_t[0][6];
	result7 	= result_t[0][7];
	result8 	= result_t[0][8];             
	result9 	= result_t[0][9];
	result10 	= result_t[0][10];
	result11	= result_t[0][11];
	result12	= result_t[0][12];
	result13	= result_t[0][13];
	result14	= result_t[0][14];
	result15	= result_t[0][15];
	//result16	= result_t[0][16];
	//phoneNo =result5.trim();
	//if(phoneNo.equals("99999999999"))
  //phoneNo="";
    
%>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
 function printInvoice()
    {
        var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//�����С
		var fontType = "����";//����
		var fontStrongInit = 0;//�����ϸ
		var vR = 0;
		var lineSpace = 0;
        //alert(3);
        /*20100528 liuxmc ��ӷ�Ʊ��α��*/
		<%
			/*
			if(s_flag.equals("O"))
			{
				%>
				<%
			}
			if(s_flag.equals("N"))
			{
				%>
					printctrl.DrawImage(localPath,8,10,40,18);//��������
 
				<%
			}*/
		%>
		//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
							printctrl.DrawImage(localPath,8,10,40,18);//��������
        printctrl.Print(20, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
		printctrl.Print(115, 10, 9, 0, "���η�Ʊ����:<%=check_seq%>"); 
        /*******************************************/
        //printctrl.Print(13, 12, 9, 0, "��α�룺<%=ran%>");

		//printctrl.Print(13, 13, 9, 0, "��    �ţ�<%=workNo%>");
        //printctrl.Print(72, 13, 9, 0, "������ˮ��<%=result15%>");
		printctrl.Print(13, 12, 9, 0, "�ͻ�����:<%=s_name_new.trim()%>");
		printctrl.Print(13, 13, 9, 0, "ҵ�����:<%=result2%>");
		printctrl.Print(115, 13, 9, 0, "�ͻ�Ʒ��:<%=sm_name%>");
		              //��  ��
		printctrl.Print(13, 15, 9, 0, "�û����룺<%=phoneNo%>");
		printctrl.Print(13, 16, 9, 0, "Э����룺<%=result6%>");
		printctrl.Print(54, 16, 9, 0, "��������:<%=year+month%>");
		printctrl.Print(115, 16, 9, 0, "��ͬ��:");
		/*
		printctrl.Print(46, 15, 9, 0, "Э����룺<%=result6%>");
		printctrl.Print(82, 15, 9, 0, "��������:<%=year+month%>");
		printctrl.Print(115, 15, 9, 0, "��ͬ��:");
		*/
		printctrl.Print(115, 17, 9, 0, "֧Ʊ��:<%=result7%>");
		printctrl.Print(115, 18, 9, 0, "����ͳ������: ");
		printctrl.Print(16, 19, 9, 0, "ͨ�ŷ���Ѻϼ�:");
		printctrl.Print(16, 19, 9, 0, "���η�Ʊ���:(Сд)��<%=result9.trim()%> ��д���ϼ�:<%=result8.trim()%> ���ɽ�:");
		printctrl.Print(16, 21, 9, 0, "<%=result11%>");//��ע 
		printctrl.Print(16, 22, 9, 0, "<%=result12%>");//��ע 
		printctrl.Print(16, 23, 9, 0, "<%=result13%>");//��ע 
		printctrl.Print(16, 23, 9, 0, "<%=result14%>");//��ע
		//printctrl.Print(16, 22, 9, 0, "��ע1"<br>"��ע2"<br>");//��ע 
 
		
		//xl add ��Ʊ��                    �տ                     ���ˣ�
		printctrl.Print(13, 30, 9, 0, "��ˮ�ţ�<%=result15%>");
		printctrl.Print(54, 30, 9, 0, "��Ʊ�ˣ�<%=workName%>");
		printctrl.Print(85, 30, 9, 0, "���ţ�<%=workNo%>");
		printctrl.Print(110, 30, 9, 0, "Ӫҵ����<%=s_yyt_name%>");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
        //alert(5);
    }

    function ifprint()
    {
        printInvoice();
        document.location.replace("<%=returnPage%>");
    }
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
 
</body>     
</html>

<%
	
	//��Ʊ���ӻ����������
		String[] inParas0 = new String[29];
		inParas0[0] = parm;//��ˮ
		inParas0[1] = smop_code;//
		inParas0[2] = workNo;
		inParas0[3] = total_date;//û����
		inParas0[4] = phoneNo;
		inParas0[5] = s_id_no;//id_no ֻ������� ʵ�ڲ����ڳ������Լ�ȡһ��
		inParas0[6] = contract_no;//contract_no
		 
		inParas0[7] = realKey+"";//��α��
		System.out.println("=============sm_name====================="+sm_name);
		//xl add ��ƱԤռ״̬������ begin
		//��Ʊ���� ��Ʊ��� ���� group_id ��ע ��Ʊ���� 
		inParas0[8] = check_seq;//��Ʊ����;
		inParas0[9] = bill_code;//��Ʊ����;
		inParas0[10] =s_sm_code;//Ʒ��
		inParas0[11] =result9.trim();//Сд���
		inParas0[12] = result8.trim();//��д���
		inParas0[13] = "" ;
		
		//���νɷѽ�� ����ÿ����Ŷ���ɶ
		//xl add ��ƱԤռ״̬������ end


		//inParas0[14] ="1";//��Ʊ��ӡ
		inParas0[14] = "";//��ֵ˰��
		inParas0[15] = "0";//��ֵ˰��
		inParas0[16] = "0";//��ֵ˰��
		inParas0[17] = "0";//��ӡ����
		inParas0[18] = result4.trim();
		inParas0[19] = "";
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = ifRed;
		inParas0[27] ="0";//ͨ�û��� 
		 

		System.out.println("====ִ�� s1300PrintInDB ��ʼ=======");
		String[][] result22 = new String[][]{};
		//��ӡ��ʱ�� ����ˮ����״̬ Ԥռ�ĸ���Ϊ�Ѵ�ӡ
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
		System.out.println("====ִ�� szg12InDB ����=======");
		if(RetResult.length > 0)
		{
			result22 = RetResult;
			if((result22[0][0]!="000000")&&!result22[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,�������"+"<%=result22[0][0]%>"+",����ԭ��:"+"<%=result22[0][1]%>".",0);
					    document.location.replace("<%=returnPage%>");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("���ӷ�Ʊ���ʧ��,szg12InDB_pt���񷵻ؽ��Ϊ��.",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%			
		}
	}else{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("��Ʊ��ӡ����,����ϵ����Ա!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'��",0);
			window.close();
	 </script>
<%
	}
%>


