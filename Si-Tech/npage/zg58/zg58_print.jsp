<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*1352 ����Ʊר��ҳ��
*1300,1302��(����ƱҲ�õ�)
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	
		String groupId = (String)session.getAttribute("groupId");
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
		
		String op_code = "zg58";
		String bill_type = "2";
		String sm_name = "";
	/////////////////////////////////
	
	/***add by zhanghonga@2008-09-25,�������ͳһ�Ӵ�,�����˴���������.��"1352 �����վ�".s1352_select.jsp������***/
	String pageOpCode = WtcUtil.repNull(request.getParameter("pageOpCode"));
	String pageOpName = WtcUtil.repNull(request.getParameter("pageOpName"));
	String pageActivePhone = WtcUtil.repNull(request.getParameter("phoneno"));
	/************************************************************************************************************/
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String contractno = request.getParameter("contractno");
	String workNo = request.getParameter("workno");
	String nopass = (String)session.getAttribute("password");
	String payAccept = request.getParameter("payAccept");
	String loginAccept = request.getParameter("loginAccept");
	String check_seq = request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");
	String pay_money = request.getParameter("pay_money");
	
	String s_sm_code="";
	String s_id_no="";
	String s_sm_name="";
	String[] inParam_dcustmsg = new String[2];
	inParam_dcustmsg[0]="select to_char(id_no),a.sm_code,b.sm_name from dcustmsg a,ssmcode b where phone_no=:s_no and substr(a.belong_code,0,2) = b.region_code and a.sm_code = b.sm_code";
	inParam_dcustmsg[1]="s_no="+pageActivePhone;

	//xl add ������֯�ڵ��ѯӪҵ������
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	String s_yyt_name="";

	String re_op_time = request.getParameter("re_op_time");
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
	<wtc:service name="TlsPubSelBoss"  outnum="3" >
		<wtc:param value="<%=inParam_dcustmsg[0]%>"/>
		<wtc:param value="<%=inParam_dcustmsg[1]%>"/>
	</wtc:service>
	<wtc:array id="retList_dcustmsg" scope="end" />
<%
	if(retList_dcustmsg.length>0)
	{
		s_id_no=retList_dcustmsg[0][0];
		s_sm_code=retList_dcustmsg[0][1];
		s_sm_name=retList_dcustmsg[0][2];
	}
	if(loginAccept==null){
	 %>
      <wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept1"/>
	 <%
	  loginAccept=loginAccept1;
	}
	
	String total_date = request.getParameter("total_date");
	String checkno = request.getParameter("checkNo");

	String returnPage = "../zg58/zg58_1.jsp";
  if (request.getParameter("returnPage") != null) {
	   returnPage = request.getParameter("returnPage");
	}
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");

	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
    
	String[] inParas = new String[6];
	inParas[0] = workNo;
	inParas[1] = contractno;
	inParas[2] = total_date;
	inParas[3] = payAccept.trim();
	inParas[4] = loginAccept;
	inParas[5] = nopass;/*xl ������ʱ��Ȩ 20110328*/
%>

<%
	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String s_invoice_flag="";
	String cust_name = request.getParameter("textfield7");
%>


	<wtc:service name="s1300PrintRe" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="35">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%   
	String return_code = "999999";
	if(result!=null&&result.length>0){
		return_code = result[0][0];
	}
 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>

<!--xl add ��ƱԤռ-->
<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=pageActivePhone%>"  outnum="8" >
		 
		<wtc:param value="<%=payAccept%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=re_op_time%>"/><!--op_time-->
		<wtc:param value="<%=pageActivePhone%>"/>
		<wtc:param value="<%=s_id_no%>"/><!--id_no-->
		<wtc:param value="<%=contractno%>"/>
		<wtc:param value=""/><!--s_check_num-->
		<wtc:param value=""/><!--��Ʊ���� ��һ�ε���ʱ ���� ���ڷ�����tpcallBASD�Ľӿ�ȡ��-->
		<wtc:param value=""/><!--��Ʊ���� ��-->
		<wtc:param value="<%=s_sm_code%>"/><!--sm_code -->
		<wtc:param value="<%=pay_money%>"/><!--Сд���-->
		<wtc:param value=""/><!--��д���-->
		<wtc:param value=""/><!--��ע-->
	 
		<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
		<wtc:param value=""/><!--�ݿ�-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/>

		<!--��basd�� 0��Ԥռ 1��ȡ��Ԥռ ���������Ҫ�� -->
		<wtc:param value="<%=cust_name%>"/><!--cust_name-->
		<!--xl add ������� ��Ʊ���� �������� ����ͺ� ��λ ���� ���� regionCode groupId �Ƿ���-->
		<wtc:param value="0"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=groupId%>"/> 
		<wtc:param value="1"/>
</wtc:service>
<wtc:array id="bill_opy" scope="end"/>
<%
	if(bill_opy!=null&&bill_opy.length>0)
	{
		return_flag=bill_opy[0][0];
		if(return_flag.equals("000000"))
		{
			 ocpy_begin_no=bill_opy[0][2];
			 ocpy_end_no=bill_opy[0][3];
			 ocpy_num=bill_opy[0][4];
	         res_code=bill_opy[0][5];
			 bill_code=bill_opy[0][6];
			 bill_accept=bill_opy[0][7];
			 s_invoice_flag="0";
			 %>
				<script language="javascript">
					//alert("��ƱԤռ�ɹ�:"+"<%=ocpy_begin_no%>");
					//history.go(-1);
				</script>
			<%
		}
		else
		{
			return_note=bill_opy[0][1];
			s_invoice_flag="1";
			%>
				<script language="javascript">
					alert("��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
					//history.go(-1);
				</script>
			<%
		}
	}
%>
<%
	 String s_pay_note="";
	 s_pay_note ="���η�Ʊ���:(Сд)��"+result[0][9].trim()+",��д���ϼ�:"+result[0][8]+"���ɽ�:"+"<p>"+result[0][11]+"<p>"+result[0][12]+"<p>"+result[0][13];
	 System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	 System.out.println("loginAccept=="+loginAccept);
	 
	 String cnttOpCode = "".equals(pageOpCode)?"zg58":pageOpCode;
	 String cttOpName = "".equals(pageOpName)?"���Ź�˾Ԥ�滰���ͺͰ�����ȯ�":pageOpName;
	 String cnttWorkNo = workNo;
	 String retCodeForCntt = return_code;
	 String cnttLoginAccept = loginAccept.length()>0?loginAccept:"";
	 String cnttActivePhone = pageActivePhone;
	 String url = "";
	 /**pageActivePhone�����ȼ�������˺�**/
	 if(cnttActivePhone.length()>0){
			url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+pageActivePhone+"&opBeginTime="+opBeginTime+"&retMsgForCntt="+retMsg1+"&contactId="+pageActivePhone+"&contactType=user";	 
	 }else{
	 		String cnttContactId = contractno;
	 		String cnttUserType = "acc";
	 		url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType+"&opBeginTime="+opBeginTime+"&retMsgForCntt="+retMsg1;	
	 }
	 System.out.println("--------------ͳһ�Ӵ�url----:"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	 System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
%>


<% 	
	  String temp[]=new String[10];
		String info=new String();
		int record=0;
	if ( return_code.equals("000000") ){

	  String phoneNo =result[0][5].trim();
		if(phoneNo.equals("99999999999"))
	         phoneNo="";
	         
	    System.out.println("-----------1352-------result[0][16]="+result[0][16]);
  int length1=result[0][16].length();
			 if(length1>0)
			 {
			 int size=60;
			 System.out.println("-------------------------"+result[0][16].length());
			 info=result[0][16].trim();
			 System.out.println("-------------------------"+result[0][16]);
			 record=length1/size;
			 System.out.println("-------------------------"+record);
			 for(int j=0;j<=record;j++)
			 {
			 if(info.length()>=size)
			 {
			 temp[j]=info.substring(0,size);
		   info=info.substring(size);
		   }
		   else
		   temp[j]=info;
		   System.out.println("-------------------------"+j+"  "+temp[j]);
		   
		   
		  
		   }
		   }

%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<SCRIPT language="JavaScript">

function printInvoice()
{ 
	//alert("��ӡ�ˣ�");
	printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	
	/*20100528 liuxmc ��ӷ�Ʊ��α��*/
	//xl begin
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
					 
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//��������
 
				<%
			}*/
		%>
	printctrl.Print(20, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
	printctrl.Print(115, 10, 9, 0, "���η�Ʊ����:<%=ocpy_begin_no%>"); 
	
	printctrl.Print(13, 13, 9, 0, "�ͻ�����:<%=result[0][4]%>");
	printctrl.Print(72, 13, 9, 0, "ҵ�����:���Ź�˾Ԥ�滰���ͺͰ�����ȯ�");
	printctrl.Print(115, 13, 9, 0, "�ͻ�Ʒ��:<%=s_sm_name%>");

	printctrl.Print(13, 15, 9, 0, "�û����룺<%=pageActivePhone%>");	
	printctrl.Print(48, 15, 9, 0, "Э����룺<%=result[0][6]%>");
	printctrl.Print(82, 15, 9, 0, "��������:<%=year+month%>");
	printctrl.Print(115, 15, 9, 0, "��ͬ��:");

	printctrl.Print(115, 16, 9, 0, "֧Ʊ��:<%=result[0][7]%>");
	printctrl.Print(115, 17, 9, 0, "����ͳ������:");//ֻ��opcode=d340��
	printctrl.Print(16, 18, 9, 0, "ͨ�ŷ���Ѻϼ�:");
	printctrl.Print(16, 18, 9, 0, "���η�Ʊ���:(Сд)��<%=result[0][9].trim()%> ��д���ϼ�:<%=result[0][8]%>");
	printctrl.Print(16, 20, 9, 0, "<%=result[0][11]%>");//��ע 
	printctrl.Print(16, 21, 9, 0, "<%=result[0][12]%>");//��ע 
	printctrl.Print(16, 22, 9, 0, "<%=result[0][13]%>");//��ע 
	printctrl.Print(16, 22, 9, 0, "<%=result[0][14]%>");//��ע 
 
 	
/********tianyang add at 20090928 for POS�ɷ�����****start*****/
/* result[0][17] Ϊ "1"  ��pos�ɷ�(����) */
	//alert("test "+"<%=result[0][17]%>");
<%if (result[0][17] != null && result[0][17].equals("1")) {%>
 	printctrl.Print(13, 22, 9, 0, "<%=result[0][18].trim()%>");/*�̻����ƣ���Ӣ��)*/
	printctrl.Print(13, 23, 9, 0, "<%=result[0][29].trim()%>");/*���׿��ţ����Σ�*/
	printctrl.Print(72, 23, 9, 0, "<%=result[0][19].trim()%>");/*�̻�����*/
	printctrl.Print(115, 23, 9, 0, "<%=result[0][24].trim()%>");/*���κ�*/
	printctrl.Print(13, 24, 9, 0, "<%=result[0][21].trim()%>");/*�����к�*/
	printctrl.Print(72, 24, 9, 0, "<%=result[0][20].trim()%>");/*�ն˱���*/
	printctrl.Print(115, 24, 9, 0, "<%=result[0][27].trim()%>");/*��Ȩ��*/
	printctrl.Print(13, 25, 9, 0, "<%=result[0][25].trim()%>");/*��Ӧ����ʱ��*/
	printctrl.Print(72, 25, 9, 0, "<%=result[0][26].trim()%>");/*�ο���*/
	printctrl.Print(115, 25, 9, 0, "<%=result[0][28].trim()%>");/*��ˮ��*/
	printctrl.Print(13, 26, 9, 0, "<%=result[0][22].trim()%>");/*�յ��к�*/
	printctrl.Print(115, 26, 9, 0, "ǩ�֣�");
<%}%>
 
/*xl add 2��BQ��
�̻���� ���ն˱�� �������к� ���յ��к� ,���acquire_bank_no==0105���ӡ�������� �����ӡacquire_bank_no������ ������������ѡ����κ� ��ƾ֤��TraceNo���ο���RRN����Ч�� ���ֿ���ǩ��(����ȷ�����Ͻ��ף�ͬ�⽫����뱾���˻�)
*/
<%if (result[0][17] != null && result[0][17].equals("2")) {%>
 	printctrl.Print(13, 22, 9, 0, "<%=result[0][33].trim()%>");/*�������1*/
	printctrl.Print(13, 23, 9, 0, "<%=result[0][29].trim()%>");/*���׿��ţ����Σ�*/
	printctrl.Print(72, 23, 9, 0, "<%=result[0][19].trim()%>");/*�̻�����*/
	printctrl.Print(120, 23, 9, 0, "<%=result[0][24].trim()%>");/*���κ�*/
	printctrl.Print(13, 24, 9, 0, "<%=result[0][21].trim()%>");/*�����к�*/
	printctrl.Print(72, 24, 9, 0, "<%=result[0][20].trim()%>");/*�ն˱���*/
	printctrl.Print(120, 24, 9, 0, "<%=result[0][30].trim()%>");/*��Ч��*/
	printctrl.Print(72, 25, 9, 0, "<%=result[0][26].trim()%>");/*�ο���*/
	printctrl.Print(120, 25, 9, 0, "<%=result[0][28].trim()%>");/*��ˮ��*/
	printctrl.Print(13, 25, 9, 0, "<%=result[0][22].trim()%>");/*�յ��к�*/
	printctrl.Print(13, 26, 9, 0, "<%=result[0][34].trim()%>");/*note*/
	printctrl.Print(115, 26, 9, 0, "ǩ�֣�");
<%}%>

/********tianyang add at 20090928 for POS�ɷ�����****end*******/
	
	 
	//xl add ��Ʊ��                    �տ                     ���ˣ�
	printctrl.Print(13, 30, 9, 0, "��ˮ�ţ�<%=result[0][15]%>");
	printctrl.Print(54, 30, 9, 0, "��Ʊ�ˣ�<%=workname%>");
	printctrl.Print(85, 30, 9, 0, "���ţ�<%=workNo%>");
	printctrl.Print(110, 30, 9, 0, "Ӫҵ����<%=s_yyt_name%>");
	printctrl.PageEnd() ;
	printctrl.StopPrint() ; 

	
}
	 function doProcess(packet)
	 {
		var s_flag = packet.data.findValueByName("s_flag");	
		var s_code = packet.data.findValueByName("s_code");	//ò��ûɶ��
		var s_note = packet.data.findValueByName("s_note");	
		var s_invoice_code  = packet.data.findValueByName("s_invoice_code");//ò��Ҳûɶ��	
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		//s_flag="1";
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		if(s_flag=="1")
		{
			rdShowMessageDialog("Ԥռȡ���ӿڵ����쳣!");
			window.location.href="<%=returnPage%>";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("��ƱԤռȡ���ɹ�,��ӡ���!",2);
				window.location.href="<%=returnPage%>";
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��! �������:"+return_flag,0);

				//window.location.href="<%=returnPage%>";
			}
		}
	 }
function ifprint()
{
  			if("<%=s_invoice_flag%>"=="0")
			{
				if(rdShowConfirmDialog("��ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",�Ƿ��ӡ��Ʊ?")==1)
				{
					document.form.action='zg58_printInvoice.jsp?pageOpCode=<%=cnttOpCode%>&pageOpName=<%=cttOpName%>&contractno=<%=contractno%>' + '&payAccept=<%=payAccept%>' + '&total_date=<%=total_date%>' + '&workno=<%=workno%>' + '&returnPage=zg58_1.jsp'+'&check_seq=<%=ocpy_begin_no%>'+'&s_flag=N&pay_money=<%=pay_money%>&ocpy_begin_no=<%=ocpy_begin_no%>'+'&phoneno=<%=pageActivePhone%>'+'&bill_code=<%=bill_code%>'; 
					document.form.submit();
					//document.location.replace("<%=returnPage%>");
				}
				else{ 
						//����ȡ���ӿ�
						//alert("ȡ�� ������scancelInDB_pt ���������ҳ��һ��ʼ�ͻ����һ�� ��Ԥռ������һ����ȡ��Ԥռ");
						var pactket1 = new AJAXPacket("../s1300/sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
						//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
						pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
						pactket1.data.add("bill_code","<%=bill_code%>");
						pactket1.data.add("paySeq","<%=payAccept%>");
						pactket1.data.add("bill_code","<%=bill_code%>");
						pactket1.data.add("op_code","<%=op_code%>");
						pactket1.data.add("phoneNo","<%=pageActivePhone%>");
						pactket1.data.add("contractno","<%=contractno%>");
						pactket1.data.add("payMoney","<%=pay_money%>");
						pactket1.data.add("userName","");
						//alert("2 "+pactket1.data);
						 
						core.ajax.sendPacket(pactket1);
					 
						pactket1=null;
					 
			 }
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
				window.location.href="<%=returnPage%>";
			}
 }

 
</SCRIPT>

<body onload="ifprint()">
<FORM action="" method=post name=form>
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
</FORM>
</body>
</html>

<%
	//String sqlStr3 = "select id_no from dcustmsg where phone_no = '"+phoneNo+"'";
	//String[][] dcustArray1 = new String[][]{};
%>

<%
		
			
		//////////////////////////////////////////////

	}else{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'��",0);
			document.location.replace("<%=returnPage%>");
	 </script>
<%
	}
%>
