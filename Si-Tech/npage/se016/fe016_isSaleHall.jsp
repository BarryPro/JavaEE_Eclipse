<%
  /*
   * 功能: 判断当前选择的组织节点是否是营业厅级
   * 版本: 1.0
   * 日期: 2011/7/5
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String) session.getAttribute("regCode");
  
  String groupId =  request.getParameter("groupId");
  String row =  request.getParameter("row");//地市营业厅所在行数
  String[] groupIds=groupId.split(",");
  int len=groupIds.length;
	String isSaleHall="0";//0：有不是营业厅级，1：全是营业厅级
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




