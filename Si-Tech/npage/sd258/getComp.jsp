<%
  /*
   * 功能: 无线监控设备营销活动申请 d258
   * 版本: 1.8.2
   * 日期: 2011/3/17
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
System.out.println("12344444-------------");
   //得到输入参数
	String login_accept = WtcUtil.repStr(request.getParameter("login_accept")," ");
	String opcode = WtcUtil.repStr(request.getParameter("opcode")," ");
	String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
	String paper_code = WtcUtil.repStr(request.getParameter("paper_code")," ");
	String award_code = WtcUtil.repStr(request.getParameter("award_code")," ");
	String award_detailcode = WtcUtil.repStr(request.getParameter("award_detailcode")," ");
	String gift_code = WtcUtil.repStr(request.getParameter("gift_code")," ");
	String paper_money = WtcUtil.repStr(request.getParameter("paper_money")," ");
	String consume_term = WtcUtil.repStr(request.getParameter("consume_term")," ");
	String opNote = WtcUtil.repStr(request.getParameter("opNote")," ");
	String gift_name = WtcUtil.repStr(request.getParameter("gift_name")," ");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
  String work_no =(String)session.getAttribute("workNo");
  String pass = (String)session.getAttribute("password");
  String ip_Addr =(String)session.getAttribute("ip_Addr");
  
  String paraAray[] = new String[16];
	paraAray[0] =login_accept;
	paraAray[1] ="01";
	paraAray[2] = opcode;
	paraAray[3] = work_no;
	paraAray[4] = pass;
	paraAray[5] = phone_no;
	paraAray[6] = "";
	paraAray[7] = paper_code;
	paraAray[8] = award_code;
	paraAray[9] = award_detailcode;
	paraAray[10] = gift_code;
	paraAray[11] = paper_money;
	paraAray[12] = consume_term;
	paraAray[13] = opNote;
	paraAray[14] = ip_Addr;
	paraAray[15] = gift_name;
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[0]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[1]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[2]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[3]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[4]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[5]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[6]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[7]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[8]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[9]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[10]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[11]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[12]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[13]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[14]);
	System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[15]);
%>
<wtc:service name="sd258Init" routerKey="regionCode" routerValue="<%=regionCode%>"  outnum="2" >
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
<wtc:param value="<%=paraAray[10]%>"/>
<wtc:param value="<%=paraAray[11]%>"/>
<wtc:param value="<%=paraAray[12]%>"/>
<wtc:param value="<%=paraAray[13]%>"/>	
<wtc:param value="<%=paraAray[14]%>"/>
<wtc:param value="<%=paraAray[15]%>"/>		
</wtc:service>
<wtc:array id="result1" scope="end" />


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);




