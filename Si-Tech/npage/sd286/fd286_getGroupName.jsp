<%
  /* *********************
   * ����:������ˮ��ѯ�����ڵ�-���Ѷ���
   * �汾: 1.0
   * ����: 2011/04/01
   * ����: ningtn
   * ��Ȩ: si-tech
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
		//ȡ�÷����ڵ�����
		String getGroupIdNameSql = "select distinct a.release_group,b.group_name from sfuncpromptrelease a,dchngroupmsg b where a.release_group=b.group_id and  create_accept = '"+createAccept.trim()+"'";
		/* ��ȡ�����ߵ�groupId */
		String getGroupIdSql = "select group_id from dloginmsg where login_no='" + createLogin + "'";
		//��¼�Ƿ�ɹ���־   1 = �ɹ�    0 = ʧ��
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
			System.out.println("======��fd286getGroupName.jsp����sPubSelectʧ�ܣ�======");
			successFlag = 0;
		}else{
			System.out.println("======��fd286getGroupName.jsp����sPubSelect�ɹ���======");
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