<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "���˲�Ʒ����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");                //����
	String nopass  = (String)session.getAttribute("password");                    	//��½����
	String regionCode = (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	
 	int errCode=0;
    String errMsg="";
 	
 	//��ȡ���е��Ż���Ϣ
 	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	String[] paramsIn=new String[6];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	
	retArray=callView.callFXService("s5238_MonthQry",paramsIn,"6");	
	callView.printRetValue();
	errCode = callView.getErrCode();
	errMsg = callView.getErrMsg();
	
	String[][]sOut_month_flag=(String[][])retArray.get(0);
	String[][]sOut_month_fee =(String[][])retArray.get(1);
	String[][]sOut_day_flag  =(String[][])retArray.get(2);
	String[][]sOut_day_fee   =(String[][])retArray.get(3);
	String[][]sOut_acc_detail=(String[][])retArray.get(4);
	String[][]sOut_acc_detail_name=(String[][])retArray.get(5);
	if(errCode != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	} 
%>

<html>
<head>
<base target="_self">
<title>�����Ż�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

//-----�ύ���������Ż�����-----
function doSubmit()
{	
	document.form1.action="f5238_opMonthCode_submit.jsp"; 
	document.form1.submit();
}

//-----�����շ���-----
function minusDayFee0()
{	
		if(!checkElement("month_fee")) 
    {
      document.all.month_fee.focus();
	    return;
    }
    
    document.all.day_fee.value = "0";
    
}

function minusDayFee1()
{	
		if(!checkElement("month_fee")) 
    {
      document.all.month_fee.focus();
	    return;
    }
    
    /* �շ���=�·���*12/365 */
    var monthFee = parseInt(document.all.month_fee.value);
    var dayFee = monthFee * 120000 / 365;
    var dayFee = Math.round(dayFee);
    document.all.day_fee.value = dayFee/10000;
}

//ѡ��һ����Ŀ��
function queryFeeCode()
{
	var retToField = "fee_code|fee_name|";
	var url = "f5238_queryFeeCode.jsp?retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
//ѡ�������Ŀ����
function queryAccDetail()
{
	if(document.all.fee_code.value=="") 
    {
        rdShowMessageDialog("��ѡ��һ����Ŀ��!");
	    return;
    }
	var retToField = "acc_detail|acc_detail_name|";
	var url = "f5238_queryFeeDetailCode.jsp?fee_code="+document.all.fee_code.value+"&retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
</script>
</head>

<body   onMouseDown="hideEvent()" onKeyDown="hideEvent()">

	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">��Ʒ��<%=mode_code%>�������Ż�����</div>
	</div>

 
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  		  	<TABLE   id="mainOne" cellspacing="0" >
	            <TBODY>
	  				<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;�Żݴ���</TD>
	  					<TD width="80%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr  >
	  					<TD height="22" class="blue">&nbsp;&nbsp;�Ż�����</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;����������</TD>
	  					<TD>
	  					<input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=4 v_name="����������" name=month_flag maxlength=4 value="<%=sOut_month_flag[0][0]%>"></input> <font color="red">(��λ��)</font>
	 	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�����շ���</TD>
	  					<TD>
	  						<input type=text  v_type="float" v_must=1 v_minlength=1 v_maxlength=15 v_name="�����շ���" name=month_fee maxlength=15 value="<%=sOut_month_fee[0][0]%>"></input> <font color="red">(��λԪ)</font>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;������ȡ��ʶ</TD>
	  					<TD>
	  						<input type="radio" onclick="minusDayFee0()" name="day_flag" value="0" <%=sOut_day_flag[0][0].equals("0")==true?"checked":""%><%=sOut_day_flag[0][0].equals("")==true?"checked":""%>>������
	  						<input type="radio" onclick="minusDayFee1()" name="day_flag" value="1" <%=sOut_day_flag[0][0].equals("1")==true?"checked":""%>>������
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�����շ���</TD>
	  					<TD>
	  						<input type=text  v_type="float" v_must=1 v_minlength=1 v_maxlength=15 v_name="������ȡ����" name=day_fee maxlength=15 value="<%=sOut_day_fee[0][0]%>"></input> <font color="red">(��λԪ)</font>
	  					</TD>
	  				</tr>
					<tr >
	  					<TD class="blue">&nbsp;&nbsp;һ����Ŀ��</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=0 v_maxlength=5 v_name="һ����Ŀ��" name=fee_code maxlength=5 size="5" value="" ></input>
	  						<input type=text  v_name="һ����Ŀ��" name=fee_name maxlength=40 value="" readonly></input>
	  						<input  type="button" name="query_feeCode" class="b_text" onclick="queryFeeCode()" value="ѡ��">
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;������Ŀ��</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=5 v_name="������Ŀ��" name=acc_detail maxlength=5 size="5" value="<%=sOut_acc_detail[0][0]%>"></input>
	  						<input type=text  v_name="������Ŀ��" name=acc_detail_name maxlength=40 value="<%=sOut_acc_detail_name[0][0]%>"></input>
	  						<input  type="button" class="b_text" name="query_accdetail" onclick="queryAccDetail()" value="ѡ��">
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<TABLE   cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button" class="b_foot" value="ȷ��" onClick="if (check(form1)) doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot_long"  value="ȡ������" onClick="window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;window.close()" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

