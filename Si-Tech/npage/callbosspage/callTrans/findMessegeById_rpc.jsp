<%@ page contentType="text/html;charset=GBK"%><%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %><%

	String id = (request.getParameter("id") != null ? request.getParameter("id") : "");
	/**��������.��ҵ����ѯ��ҵ�����ֿ�.*/
	String type = (request.getParameter("type") != null ? request.getParameter("type") : "");
	String msgContent = "";
	String itemFullName = "";
	String digitCode = "";
	
{/**��ѯ�������ݺ�Id�ķ���.*/
	if("1".equals(type)){/**תҵ������ѯ.*/
		String strSql =" SELECT T.MESSEGECONTENT FROM DZXSCETRANSFERTAB T WHERE  T.ID = :ID  ";
		String params = "ID=" + id;
		System.out.println("################"+strSql);
		System.out.println("################"+id);
		String orgCode = (String)session.getAttribute("orgCode");
		%><wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=orgCode%>"  outnum="3">
			<wtc:param value="<%=strSql%>"/>
			<wtc:param value="<%=params%>"/>
			</wtc:service>
		<wtc:array id="rows" scope="end" /><%
		/**System.out.println(rows.length);*/
		if(rows.length == 1){
			msgContent = rows[0][0];
			msgContent = msgContent.replaceAll("\'","");
		}
	}
}
{
	/**��ѯitemFullName��ȫ·������.*/
	String tempId = id;
	String tempSuperId = id;
	String tempSuperId2 = id;
	boolean loop = true;
	int index = 0;
	String strSql = "";
	if("0".equals(type)){/**תҵ������ѯ.*/
		strSql =" SELECT T.SERVICENAME , T.ID , T.SUPERID , T.DIGITCODE FROM DSCETRANSFERTAB T WHERE  T.ID = :ID OR T.ID = :SUPERID OR T.ID = :SUPERID2 ";
	}else if("1".equals(type)){/**ת��ѯ������ѯ.*/
		strSql =" SELECT T.SERVICENAME , T.ID , T.SUPERID , T.DIGITCODE FROM DZXSCETRANSFERTAB T WHERE  T.ID = :ID  OR T.ID = :SUPERID OR T.ID = :SUPERID2 ";
	}
	while(loop){
		String params = "ID=" + tempId+",SUPERID="+tempSuperId+",SUPERID2="+tempSuperId2;
		/**System.out.println("################"+strSql);
		System.out.println("################"+params);*/
		String orgCode = (String)session.getAttribute("orgCode");
		%><wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=orgCode%>"  outnum="4">
			<wtc:param value="<%=strSql%>"/>
			<wtc:param value="<%=params%>"/>
			</wtc:service>
		<wtc:array id="rows" scope="end" /><%
		System.out.println(rows.length);
		if(rows.length == 1){
			tempId = rows[0][2];
			tempSuperId = rows[0][2];
			tempSuperId2 = rows[0][2];
			
			if(index == 0){
				itemFullName = rows[0][0];
				digitCode = rows[0][3];
			}else{
				itemFullName = rows[0][0] + "��" + itemFullName;
			}
			if(tempId.length() > 0){
				/**��superId���������ж��ж� ��*��,��ǰid��һλ���һ��*.�����.*/
				tempSuperId = tempSuperId.substring(0, tempSuperId.length() - 1)+ "*";
				tempSuperId2 = tempSuperId2 + "*";
				/**System.out.println("tempId:["+tempId+"\ttempSuperId:["+tempSuperId);*/
			}
			index ++;
			if(index == 9){
				break;
			}
			/**��������һ��id����'*'��ʱ������һ�μ�¼�ڵ�.Ȼ���˳�.*/
			String tempId2 = rows[0][1];
			if(tempId2.indexOf("*") > 0){
				break;
			}
		}else{
			loop = false;
		}
	}
	itemFullName = itemFullName.replaceAll("\'","");
}
%>
{digit_code:'<%=digitCode%>',msg_content:'<%=msgContent%>',node_name:'<%=itemFullName%>'}