<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *author:王志超@2010-03-22 新增 
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

	
	<%
		System.out.println("--------------------ajaxGetMsg.jsp-------------------");
		String org_code = (String) session.getAttribute("orgCode");
		String region_code=org_code.substring(0,2);
		System.out.println("----------org_code-----------------"+org_code);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String phoneNo1 = request.getParameter("phone_no1");
		String phoneNo2 = request.getParameter("phone_no2");
		String workNo =  (String)session.getAttribute("workNo");
		String loginPwd = (String)session.getAttribute("password");
		String regionCode = (String)session.getAttribute("regCode");
		String strArray="var retAry;"; 
		String return_code = "111111";
		String errMsg="";
      /**
      StringBuffer strSQL = new StringBuffer();
      strSQL.append("select to_char(a.member_id),to_char(a.group_id),a.acc_nbr,to_char(a.serv_id),a.member_desc, ");
      strSQL.append("to_char(a.member_role_id),to_char(a.exp_date,'yyyymmdd hh24:mi:ss'),to_char(a.eff_date,'yyyymmdd hh24:mi:ss'),e.cust_name,to_char(a.state_date,'yyyymmdd hh24:mi:ss') ");
      strSQL.append("from group_instance_member a,dcustmsg d,dcustdoc e ");
      strSQL.append("where a.group_id in(select b.group_id ");
      strSQL.append("from group_instance_member b ,dcustmsg c ");
      strSQL.append("where b.serv_id=c.id_no ");
      strSQL.append("and c.phone_no='"+phoneNo1+"' ");
      strSQL.append("and b.member_role_id in(1001,1002) ");
      strSQL.append("and b.exp_date>sysdate  ");
      strSQL.append("and b.eff_date<sysdate)  ");
      strSQL.append("and a.serv_id=d.id_no  ");
      strSQL.append("and d.cust_id=e.cust_id ");
      strSQL.append("and a.exp_date>sysdate  ");
      strSQL.append("and a.eff_date<sysdate  ");
     
      String [] paraIn1 = new String[4];
	
		paraIn1[0] = "region";
		paraIn1[1] = org_code.substring(0,2);
		paraIn1[2] = strSQL.toString();
		paraIn1[3] = "";
		*/
%> 

	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
  
  <wtc:service name="s8439MsgQry" outnum="10" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="8439"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=loginPwd%>"/>
      <wtc:param value="<%=phoneNo1%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
  
	<wtc:array id="result" scope="end"/>
	  
<%
	if(!retCode.equals("000000")) {
		return_code="999999";
		errMsg=retMsg;
		System.out.println("----------------errMsg-----------------"+errMsg);
%>
		<%=strArray%>
<%	
	} else {
		System.out.println("----------------result.length-----------------"+result.length);
		if(result!=null&&result.length>0) {
			strArray = WtcUtil.createArray("retAry",result.length);
%>
	       <%=strArray%>
<%	
			for(int i=0;i<result.length;i++) {
			 
%>
				retAry[<%=i%>][0] = "<%=result[i][0]%>";
				retAry[<%=i%>][1] = "<%=result[i][1]%>";
				retAry[<%=i%>][2] = "<%=result[i][2]%>";
				retAry[<%=i%>][3] = "<%=result[i][3]%>";
				retAry[<%=i%>][4] = "<%=result[i][4]%>";
				retAry[<%=i%>][5] = "<%=result[i][5]%>";
				retAry[<%=i%>][6] = "<%=result[i][6]%>";
				retAry[<%=i%>][7] = "<%=result[i][7]%>";
				retAry[<%=i%>][8] = "<%=result[i][8]%>";
				retAry[<%=i%>][9] = "<%=result[i][9]%>";
				
<%
		     }
		     return_code="000000";
		}
		else
		{
%>
	       <%=strArray%>
<%	
		     return_code="111111";
		}
	}
%>		
	var response = new AJAXPacket();
	var return_code = "<%=return_code%>";
	var return_msg = "<%=errMsg%>";
	
	response.data.add("return_code",return_code);
	response.data.add("return_msg",return_msg);
	response.data.add("retAry",retAry);
	core.ajax.receivePacket(response);


 


