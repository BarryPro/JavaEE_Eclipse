<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String opCodeIn = WtcUtil.repNull(request.getParameter("opCode"));
	String powerCode = (String)session.getAttribute("powerCode");
	
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("----------powerCode-----------"+powerCode);
	String powerCodeArr[] = powerCode.split("\\,");
	
	String kfFlagOc = "";
	String tempStr = "";
	for(int i=0 ;i<powerCodeArr.length;i++){
		System.out.println("-------------powerCodeArr[i]-------------"+powerCodeArr[i]);
		tempStr = powerCodeArr[i].trim();
		if(!tempStr.equals("")){
			String sqlStr = "select pass_flag from sfunccodekf where function_code = '"+opCodeIn+"' and role_code = '"+tempStr+"'  and kf_flag='1' "		;
			System.out.println("----------sqlStr-----------"+sqlStr);
	%>
	
	   <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
	  	 <wtc:sql><%=sqlStr%></wtc:sql>
	 	  </wtc:pubselect>
		 <wtc:array id="result_t" scope="end"/>
	
	<%
	 	 if(!kfFlagOc.equals("0")){	
			 	if(result_t.length>0&&result_t[0][0]!=null){
				 	kfFlagOc = result_t[0][0];
			 	}
		 	}else{
		 		break;
		 	}
 	}
 }
 System.out.println("---------------kfFlagOc------ajaxOcLimit.jsp-------------"+kfFlagOc);
%>

var response = new AJAXPacket();
response.data.add("kfFlagOc","<%=kfFlagOc%>");
core.ajax.receivePacket(response);
 