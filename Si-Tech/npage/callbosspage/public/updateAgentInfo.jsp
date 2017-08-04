<%
	/*
	 * 功能: 保存各种状态下时间
	 * 版本: 1.0
	 * 日期: 2008/12/21
	 * 作者: lijin 
	 * 版权: sitech
	 * 修改：xingzhan 日期：20090601 目的：把sql以数组的形式传送到后台；
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
   String sql="";
   String WorkNo=request.getParameter("WorkNo"); 
   String oprType =request.getParameter("oprType");
   System.out.println("=======================oprType:"+oprType);
   String typeArr[] = oprType.split(",");
   String sqlArr[] = new String[typeArr.length];
   
   String orgCode = (String)session.getAttribute("orgCode");
   String regionCode = orgCode.substring(0,2); 
   for(int i =0;i<typeArr.length;i++){
   		
   		/**sqlArr[i]="update dagentoprinfo a set a.operate_end=sysdate where (a.staffno='"+WorkNo+"'or a.operate_object='"+WorkNo+"') and a.operate_type ='"+typeArr[i]+"' and a.operate_end is null";
   		*/
   		sqlArr[i]="update dagentoprinfo a set a.operate_end=sysdate where (a.staffno= :v1or a.operate_object= :v2) and a.operate_type = :v3 and a.operate_end is null";
   		sqlArr[i]+="&&"+WorkNo+"^"+WorkNo+"^"+typeArr[i]:
      //System.out.println("======================"+sqlArr[i]); 
   }
   //sql="update dagentoprinfo a set a.operate_end=sysdate where (a.staffno='"+WorkNo+"'or a.operate_object='"+WorkNo+"') and a.operate_type ='"+oprType+"' and a.operate_end is null";
    		
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="rows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("WorkNo","<%=WorkNo%>");
core.ajax.receivePacket(response);

	
