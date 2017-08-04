<%
  /*
   * 功能: 098权限角色管理->查询功能点对应的角色,并为数据回显提供标识
　 * 版本: 1.0.0
　 * 日期: 2008/1/16
　 * 作者: fangyuan
　 * 版权: sitech
   * update: yinzx 2009/07/16  客服功能调试
   *													 1.修改获取角色sql 使用 select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE, decode((select count(*) from sPowerCode where power_code like trim(a.power_code)||'%' and use_flag ='Y'),1,'Y','N')  from sPowerCode a, sRoleTypeCode b where power_code like '0110%' and length(trim(power_code)) = length('0110')+2 and   a.roletype_code = b.ROLETYPE_CODE and a.use_flag='Y' order by a.power_code 
　 *                             这个语句需要确认
   *													 2.修改 查询服务 表DCALLQUERYROLEMENU 属于客服库，去掉第二个查询服务的第二个参数
   */

%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
String selectedItemId = WtcUtil.repNull(request.getParameter("selectedItemId"));
String workNo=(String)session.getAttribute("workNo");

String sql_getExistRoles="select t.role_id from DCALLQUERYROLEMENU t where t.menu_id=:selectedItemId ";
myParams="selectedItemId="+selectedItemId;
String sql_getRoles="select a.power_name, a.power_code "+
	                "  from sPowerCode a, sRoleTypeCode b "+
                     "  where   a.roletype_code='9' and a.roletype_code = b.ROLETYPE_CODE and a.use_flag = 'Y' union select '省客服中心','0110' from dual";
 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:param value="<%=sql_getExistRoles%>" />
	<wtc:param value="<%=myParams%>" />
</wtc:service>
<wtc:array id="existRoleList" scope="end"/>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:param value="<%=sql_getRoles%>" />
</wtc:service>
<wtc:array id="resultList" scope="end"/>

var nodes=new Array();
var hasRoleidFlag=new Array();
<%
	for(int i=0;i<resultList.length;i++){
	//System.out.println(">>>>>所有的 role_id = "+resultList[i][1]);
			//默认角色是不存在的
		%>
			hasRoleidFlag[<%=i%>]=false;
		<%
		if(existRoleList.length>0){
			//System.out.println("existRoleList.length = "+existRoleList.length);
			for(int k=0;k<existRoleList.length;k++){
				//判断已经拥有的roleid
				//System.out.println("存在的 role_id = "+existRoleList[k][0]);
				if(resultList[i][1].equalsIgnoreCase(existRoleList[k][0])){
				%>
					hasRoleidFlag[<%=i%>]=true;
				<%			
					break;	
				}				
			}		
		}
%>
          var tempArr=new Array();
	<%	
		for(int j=0;j<resultList[i].length;j++){
	%>
			tempArr[<%=j%>]='<%=resultList[i][j]%>';
	<%
		}
	%>
		nodes[<%=i%>]=tempArr;
<%
	}
%>

var response = new AJAXPacket();
response.data.add("nodes",nodes);
response.data.add("flag",hasRoleidFlag);
core.ajax.receivePacket(response);

