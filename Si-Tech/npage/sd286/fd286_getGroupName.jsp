<%
  /* *********************
   * 功能:根据流水查询发布节点-提醒短信
   * 版本: 1.0
   * 日期: 2011/04/01
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String createAccept = WtcUtil.repNull(request.getParameter("createAccept"));
		String createLogin = WtcUtil.repNull(request.getParameter("createLogin"));
		String strArray = "var arrMsg; ";
		//取得发布节点名称
		String getGroupIdNameSql = "select distinct a.release_group,b.group_name from sfuncpromptrelease a,dchngroupmsg b where a.release_group=b.group_id and  create_accept = '"+createAccept.trim()+"'";
		/* 获取创建者的groupId */
		String getGroupIdSql = "select group_id from dloginmsg where login_no='" + createLogin + "'";
		//记录是否成功标志   1 = 成功    0 = 失败
		int successFlag = 0;
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2">
		<wtc:sql><%=getGroupIdSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>


	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=getGroupIdNameSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
	<%
		if(!(retCode.equals("0") || retCode.equals("000000"))){
			System.out.println("======在fd286getGroupName.jsp调用sPubSelect失败！======");
			successFlag = 0;
		}else{
			System.out.println("======在fd286getGroupName.jsp调用sPubSelect成功！======");
			strArray = WtcUtil.createArray("arrMsg",result.length);
			successFlag = 1;
		}
%>
	<%=strArray%>
<%
		if(successFlag == 1){
			for(int i = 0 ; i < result.length ; i ++){
	      for(int j = 0 ; j < result[i].length ; j ++){
%>
					arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
<%
	      }
	     }
		}
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("result",arrMsg);
	response.data.add("creatGrpId","<%= result_t[0][0]%>");
	core.ajax.receivePacket(response);