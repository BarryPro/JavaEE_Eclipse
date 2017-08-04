<%
	/*
	 * 功能: 技能队列
	 * 版本: 1.0
	 * 日期: 2009/05/18
	 * 作者: lijin 
	 * 版权: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String ccno=request.getParameter("ccno");
	String sqlStr ="";
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String group_id =request.getParameter("group_id");
  System.out.println(group_id+"!!!!!!!!!!!!!!!!!!1");
  if(!"".equals(group_id)&& group_id!=null && !"null".equals(group_id))
  {
  	sqlStr=" select a.skill_queue_id, a.skill_queud_name  from dagskillqueue a  where 1=1 and  a.IS_SHOW = '1' and a.SUB_CC_NO='"+ccno+"' and a.skill_group_id='"+group_id+"' order by a.skill_queue_id ";
  }
	else
    sqlStr=" select a.skill_queue_id, a.skill_queud_name  from dagskillqueue a  where 1=1 and  a.IS_SHOW = '1' and a.SUB_CC_NO='"+ccno+"' order by a.skill_queue_id ";
	 System.out.println(sqlStr+"!!!!!!!!!!!!!!!!!!1");
%>
<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
   <wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end" />
   var contact = new Array();
  <%
  if(queryList.length>0){
  for(int i = 0; i < queryList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < queryList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=queryList[i][j]%>';
	<%}%>
	contact[<%=i%>] = tmpArr;
<%}
 }%>
	var response = new AJAXPacket();
	response.data.add("contact",contact);
	core.ajax.receivePacket(response);	