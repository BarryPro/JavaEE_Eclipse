<%
  /*
   * 功能: 判断是否是地市对应的营业厅并且是否是营业厅级别
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
  String iregionCode =  request.getParameter("regionCode"); //地市group_id
  String groupId =  request.getParameter("groupId");
	String isSaleHall="0";//0：有不是营业厅级，1：是营业厅级
	String isdisHall="0"; //1：是营业厅并且是当前礼品所在的地市
	String errCode="";
	String errMsg="";
	String sqlStr ="select  count(*) from dchngroupmsg where root_distance='4' and group_id ='"+groupId+"' ";

%>	

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="isSaleHallStr" scope="end" />		
<%
  errCode=retCode;
  errMsg=retMsg;	
	if(errCode.equals("000000"))
  {	
		if(isSaleHallStr.length>0)
		{
			isSaleHall=isSaleHallStr[0][0];	
		}
  }
  
  if(isSaleHall.equals("1"))
  {
  	String sqlStr2=" select count(*) from dchngroupinfo where group_id='"+groupId+"' and parent_group_id='"+iregionCode+"'" ;
%>	

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
<wtc:sql><%=sqlStr2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="isDisHalStr" scope="end" />
<%
  errCode=retCode2;
  errMsg=retMsg2;
	if(errCode.equals("000000"))
  {	
		if(isDisHalStr.length>0)
		{
			isdisHall=isDisHalStr[0][0];	
		}
  }
 } 
%>	
	
	

var response = new AJAXPacket();
response.data.add("isSaleHall","<%=isSaleHall%>");
response.data.add("isdisHall","<%=isdisHall%>");
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");
core.ajax.receivePacket(response);






