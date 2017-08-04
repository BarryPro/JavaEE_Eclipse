<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-15 页面改造,修改样式
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<form name = "frm" method = "post">
<HEAD><TITLE>一点支付冲正</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<%
    //定义变量
    //输入参数：帐务日期，缴费流水，机构代码，工号，权限代码。
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
    String totaldate  = request.getParameter("totaldate").trim();//帐务月份
    String phoneNo = request.getParameter("phoneNo");
    String contractno = request.getParameter("contractNo");
    if (contractno == null) {
        contractno = request.getParameter("contractno");
    }
    String loginaccept = request.getParameter("loginaccept").trim();//流水号
     
     
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String workno = baseInfo[0][2];
    //String workname = baseInfo[0][3];
    //String orgcode = baseInfo[0][16];//机构代码
    //String[][] password = (String[][])arr.get(4);//读取工号密码 
    //String nopass = password[0][0];
    
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String orgcode = (String)session.getAttribute("orgCode");
    /*tianyang add for pos */
    String groupId = (String)session.getAttribute("groupId");
    String nopass = (String)session.getAttribute("password");
    
    String op_code = "3190" ;
     
    String optime = request.getParameter("jfsj");
	String payMoney = request.getParameter("jfje");
	String payNote = request.getParameter("note");
    String inParas[] = new String[9];
    inParas[0] = workno;
    inParas[1] = nopass ;
	inParas[2] = contractno;
    inParas[3] = loginaccept ;
    inParas[4] = totaldate;
	inParas[5] = optime;
	inParas[6] = payMoney;
	inParas[7] = workno;
	inParas[8] = payNote;
    /*
    String outNum="17";
     
    int[] lens={12,5};
     
    ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
    
    CallRemoteResultValue value=  viewBean.callService("1",orgcode.substring(0,2),"s1310Init",outNum, lens, inParas); 
    ArrayList list  = value.getList();
    */
  /* chenhu add */
  			double dPayMoney = 0-Double.parseDouble(payMoney);
  			String sPayMoney = String.valueOf(dPayMoney);
%>
      <!-- chenhu add -->
<wtc:service name="bs_ChnPayLimit" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="5">
	<wtc:param value="<%=workno%>"/>
  <wtc:param value="<%=sPayMoney%>"/>
    </wtc:service>
    <wtc:array id="result4"   scope="end" />
    <wtc:array id="result5"  scope="end" /> 	
    <wtc:array id="result6"  scope="end" />
    <wtc:array id="result7"  scope="end" />
    <wtc:array id="result8"  scope="end" />
<%      
							 String t_return_code = result4[0][0].trim();
				String t_return_msg = result5[0][0].trim();
				String flag_status  = result6[0][0].trim(); 
				String pledge_fee  = result7[0][0].trim(); 
				String total_money = result8[0][0].trim(); 
				System.out.println("chenhu test ############################ test t_return_code is "+t_return_code);
				System.out.println("chenhu test ############################ test t_return_msg is "+t_return_msg);
				System.out.println("chenhu test ############################ test flag_status is "+flag_status);
				if(!t_return_code.equals("000000")){
%>
 <script language='jscript'>			
						rdShowMessageDialog("查代理商账户错误！<br>错误代码：'<%=t_return_code%>'。<br>错误信息：'<%=t_return_msg%>'。",0);
						history.go(-1);
	</script>	    
<%		
				}
if (t_return_code.equals("000000")){
%>
<input type = "hidden" name = "workno" value = "<%=workno%>"> 
<input type = "hidden" name = "contractno" value = "<%=contractno%>"> 
<input type = "hidden" name = "payAccept" value = "<%=loginaccept%>"> 
	
	<wtc:service name="s3190Cfm" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="5">
    	<wtc:param value="<%=inParas[0]%>"/>
        <wtc:param value="<%=inParas[1]%>"/>
        <wtc:param value="<%=inParas[2]%>"/>
        <wtc:param value="<%=inParas[3]%>"/>
        <wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
    </wtc:service>
    <wtc:array id="result" start="0"  length="5"  scope="end" />
    
<%
    //String[][] result = (String[][])list.get(0);
    
    String return_code =result[0][0];
    String return_message =result[0][1];
    String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>


<%
    if (return_code.equals("000000")) {
        String totalDate=result[0][3];
		%><input type ="hidden" name = "total_date" value = "<%=totalDate%>">  <%
		%>
		 <script language='JavaScript'>
			var prtFlag=0;
			prtFlag = rdShowConfirmDialogPrint("一点支付冲正成功！是否打印发票？");
			if (prtFlag==1){
			document.frm.action="PrintInvoice.jsp";
			document.frm.submit();
			}else{ 
				rdShowMessageDialog("交易完成!",2);
  				document.location.replace("f3190_1.jsp");
			 }
		</script>
		<%}
else{
%>
<script language='JavaScript'>
		rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_message%>'。",0);
		history.go(-1);
</script>
<%}%>

<%
} else
  {
%> <script language='jscript'>
	       rdShowMessageDialog("冲正失败！<br>错误代码：'<%=t_return_code%>' <br>错误信息：'<%=t_return_msg%>'",0);
	       history.go(-1);
      </script>
<%            
  }%>
 </form>
</html>