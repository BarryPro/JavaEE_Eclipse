<%
  /*
   * ����: �жϵ�ǰѡ�����֯�ڵ��Ƿ���Ӫҵ����
   * �汾: 1.0
   * ����: 2011/7/5
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String) session.getAttribute("regCode");
  
  String groupId =  request.getParameter("groupId");
  String row =  request.getParameter("row");//����Ӫҵ����������
  String[] groupIds=groupId.split(",");
  int len=groupIds.length;
	String isSaleHall="0";//0���в���Ӫҵ������1��ȫ��Ӫҵ����
	String countHall="0";
	String sqlStr ="select  count(*) from dchngroupmsg where root_distance='4' and group_id in ( ";
	for(int i=0;i<len-1;i++)
	{
	  sqlStr += "'"+groupIds[i]+"',";
	}
	sqlStr += "'"+groupIds[len-1]+"' )";

%>	

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="isSaleHallStr" scope="end" />		
<%		
	if(retCode.equals("000000"))
  {	
		if(isSaleHallStr.length>0)
		{
			countHall=isSaleHallStr[0][0];	
		}
  }
  
  String leng=len+"";
  if(countHall.equals(leng))
  {
  	isSaleHall="1";
  }
%>	
var response = new AJAXPacket();
response.data.add("isSaleHall","<%=isSaleHall%>");
response.data.add("row","<%=row%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMessage","<%=retMsg%>");
core.ajax.receivePacket(response);




