<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>

<%
            //得到输入参数
   String mode_code = WtcUtil.repStr(request.getParameter("mode_code")," ");
   String region_code = WtcUtil.repStr(request.getParameter("region_code")," ");
   String op_code=request.getParameter("op_code");
   String  groupId = (String)session.getAttribute("groupId");       
            
    
    /* liujian 安全加固修改 2012-4-6 16:18:13 begin */
    String workNo = (String)session.getAttribute("workNo");
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
	  
			System.out.println("aaaaaaaaaaaaa"+mode_code);
			System.out.println("bbbbbbbbbbbbb"+region_code);
            System.out.println("cccccccccccccccc"+op_code);
			String sqlStr = "";
			String mode_note = "";
			//sqlStr = "select trim(mode_note) from sBillModeDes where region_code='" + region_code + "' and mode_code='" + mode_code + "'";
			//retArray1 = callView1.sPubSelect("1",sqlStr);
%>
		<wtc:service name="s1270NoteNew" routerKey="region" routerValue="<%=region_code%>" outnum="7" >
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=region_code%>"/>
			<wtc:param value="<%=mode_code%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=groupId%>"/>
		</wtc:service>
		<wtc:array id="result3" scope="end"/>
<%			
			if(result3!=null){
				if(result3.length>0){
						mode_note = result3[0][4];
						System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						System.out.println("mode_note="+mode_note);
				}
			}
			mode_note = mode_note.replaceAll("\"","");
			mode_note = mode_note.replaceAll("\'","");
				    
			System.out.println("cccccccccccccc"+mode_note);
					
%>
var response = new AJAXPacket();
var mode_note = "<%=mode_note%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("mode_note",mode_note);
core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 