<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺����.���ʻ���
 update zhaohaitao at 2008.12.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%		
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String groupId = (String)session.getAttribute("groupId");
	String work_no = baseInfo[0][2];
	String op_code = "1378";
	String sm_code = "";
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String phone_no = request.getParameter("phone_no");          
	String id_no = request.getParameter("id_no");            
	String owe_year = request.getParameter("owe_year");       
	String owe_month = request.getParameter("owe_month");  
	String owe_fee_pay = request.getParameter("owe_fee_pay");	
	String delay_fee_pay = request.getParameter("delay_fee_pay");	
	String money=Double.toString(Double.parseDouble(owe_fee_pay) + Double.parseDouble(delay_fee_pay));
	//String fee_pay_total = request.getParameter("fee_pay_total");	
	String op_note = request.getParameter("op_note");
	String owner_name = request.getParameter("owner_name");
  String s_sm_code="";
  String s_sm_name="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String s_invoice_flag="";   
	String contractno=""; 
	
	if (phone_no.startsWith("9")) {
	   sm_code="1";
	} else if (phone_no.startsWith("13")) {
	   sm_code="0";
	}
	String check_seq="";
	String s_flag="";
	
	String paraAray[] = null;
	//CallRemoteResultValue value = null; 
	String[][] result = new String[][]{};
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
	
	paraAray = new String[10];
	paraAray[0] = work_no;                //����
	paraAray[1] = op_code;                //��������
	paraAray[2] = s_sm_code;                //��֪��
	paraAray[3] = phone_no;               //�ֻ�����
	paraAray[4] = id_no;                  //�û�ID 
	paraAray[5] = owe_year;               //Ƿ����
	paraAray[6] = owe_month;              //Ƿ����
	paraAray[7] = owe_fee_pay;            //��Ƿ��
	paraAray[8] = delay_fee_pay;          //�����ɽ�
	paraAray[9] = op_note;                //��ע
	
   // value = viewBean.callService("0",null,"s1378Cfm","1", paraAray); 
   // result = value.getData();
	%>
	

		
	<wtc:service name="s1378Cfm" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end" />	
	<%
	

	result=result2;
	String return_code =retCode1;
	String error_msg = retMsg1;
    String login_accept = "";

	if (result != null) {
	   login_accept = result[0][0];
	   
	}

	//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg("501000"));
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script language="JavaScript" src="/js/common/common_util.js"></script>
<body>
<form action="" name="frm_print" method="post">
<input type="hidden" name="owner_name"  value="<%=owner_name%>">
<input type="hidden" name="phone_no"  value="<%=phone_no%>">
<input type="hidden" name="owe_fee_pay"  value="<%=owe_fee_pay%>">
<input type="hidden" name="delay_fee_pay"  value="<%=delay_fee_pay%>">
<input type="hidden" name="op_note"  value="<%=op_note%>">
<input type="hidden" name="login_accept"  value="<%=login_accept%>">


<input type="hidden" name="bill_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>">
<input type="hidden" name="id_no" value="<%=id_no%>">
<input type="hidden" name="s_sm_code" value="<%=s_sm_code%>">
<input type="hidden" name="s_sm_name" value="<%=s_sm_name%>">

</form>
</body>
</html>
<% if (return_code.equals("000000")) {%>

//String s_invoice_tmp="";

%>
<!--xl add ��ƱԤռ-->
<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=phone_no%>"  outnum="8" >
		 
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value=""/><!--op_time-->
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=id_no%>"/><!--id_no-->
		<wtc:param value="0"/>
		<wtc:param value=""/><!--s_check_num-->
		<wtc:param value=""/><!--��Ʊ���� ��һ�ε���ʱ ���� ���ڷ�����tpcallBASD�Ľӿ�ȡ��-->
		<wtc:param value=""/><!--��Ʊ���� ��-->
		<wtc:param value=""/>
		<wtc:param value="<%=money%>"/><!--Сд���-->
		<wtc:param value=""/><!--��д���-->
		<wtc:param value=""/><!--��ע-->
	 
		<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
		<wtc:param value=""/><!--�ݿ�-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/>

		<!--��basd�� 0��Ԥռ 1��ȡ��Ԥռ ���������Ҫ�� -->
		<wtc:param value="<%=owner_name%>"/>
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
		}
		else
		{
			return_note=bill_opy[0][1];
			s_invoice_flag="1";
			%>
				<script language="javascript">
					//alert("��ƱԤռʧ��!����ԭ��111:"+"<%=return_note%>");
					//history.go(-1);
				</script>
			<%
		}
	}
%>


<script language="JavaScript">
	if("<%=s_invoice_flag%>"=="0")
			{
				var prtFlag=0;
	 
				prtFlag=rdShowConfirmDialog("Ƿ�Ѵ߽ɳɹ�����ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",��Ʊ������"+"<%=bill_code%>"+",�Ƿ��ӡ�վ�?");
				if (prtFlag==1){
					//alert("��ӡ ������szg12InDB_pt");
					document.frm_print.action="s1378_print.jsp?check_seq="+"<%=ocpy_begin_no%>"+"&bill_code="+"<%=bill_code%>";
					document.frm_print.submit();
				}else{ 
					rdShowMessageDialog("�������!",2);
  		  	document.location.replace("s1378.jsp");
			 }
			}
			else
			{
				rdShowMessageDialog("�ɷ����,��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
				window.location.href="s1378.jsp";
			}
</script>
<% } else { %>   
    <script language="JavaScript">
	    rdShowMessageDialog("Ƿ�Ѵ߽�ʧ��!�������"+"<%=return_code%>,������Ϣ��"+"<%=error_msg%>");
        window.location="s1378.jsp";
        
        
  </script>
<%}%>