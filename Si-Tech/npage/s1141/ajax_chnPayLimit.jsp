<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String sum_money =  request.getParameter("sum_money");
	String orgCode = (String) session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0, 2);
  String pay_flag="";
  String outPledge="";
  String total_pay="";   
	System.out.println("========sum_money================"+sum_money);
%>

	<wtc:service name="bs_ChnPayLimit" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=sum_money%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String errorCode = retCode;
	String errorMsg = retMsg;

  if(tempArr == null)
  {
	   errorMsg = "bs_ChnPayLimit信息为空!<br>errorCode: " + errorCode + "<br>errorMsg+" + errorMsg;  
  }
  else
  {
	  if (errorCode.equals("000000")&tempArr.length>0 ){
		    pay_flag = tempArr[0][2];             //标识
		    outPledge = tempArr[0][3];            //代办押金
		    total_pay = tempArr[0][4];            //日积累额度
	  }
	 }	
	 
	 System.out.println("=========gaopengSeeLog20140228========="+errorCode+"=========errorMsg================="+errorMsg+"======pay_flag===="+pay_flag+"==outPledge=="+outPledge+"==total_pay="+total_pay);
%>


var response = new AJAXPacket();
response.data.add("pay_flag","<%=pay_flag%>");
response.data.add("outPledge","<%=outPledge%>");
response.data.add("total_pay","<%=total_pay%>");
response.data.add("retCode","<%=errorCode%>");
response.data.add("retMsg","<%=errorMsg%>");
core.ajax.receivePacket(response);

