
<%
	/* ningtn �����Ż����ſͻ�SA������ϵͳ�ĺ� ����SQL��� */
	String pubSAGroupId = (String)session.getAttribute("groupId");
	String pubSASqlStr = "select trim(a.parter_id),a.parter_name "+
		" FROM dpartermsg a,dparterauthemsg b,dchngroupinfo c "+
		" WHERE a.parter_id=b.parter_id AND a.dis_group_id = c.parent_group_id "+
		" AND a.parter_type='19' AND a.status='07' AND b.authe_status='03' "+
		" AND c.group_id = '" + pubSAGroupId + "' ORDER BY A.PARTER_ID";
%>