
<%
	/**
	 * Title: 组织树
	 * Description: 渠道组织树
	 * Copyright: Copyright (c) 2009/02/26
	 * Company: SI-TECH
	 * author： zhaoxy
	 * version 1.0 
	 */
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	//String group_id  = request.getParameter("group_id");
	//String group_name = request.getParameter("group_name");
	ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
	String[][] appInfo = (String[][])arr1.get(0);
	String[][] otherInfo = (String[][])arr1.get(6);  
	String group_name = otherInfo[0][4]; 
	String group_id = appInfo[0][21] ;
		

	
	StringBuffer sqlStr = new  StringBuffer();
	sqlStr.append( "SELECT   decode(b.parent_group_id,null,0,b.parent_group_id)||'_'||b.group_id   as  group_tree, ");
	sqlStr.append("  a.group_name,a.group_id,  b.parent_group_id  ");
	sqlStr.append(" from dchngroupmsg a, dchngroupinfo b  ");
  sqlStr.append("  where a.GROUP_ID = b.GROUP_ID  and  b.parent_group_id  <> b.group_id   ");    
  sqlStr.append(" AND b.denorm_level <= 1 ");   
  sqlStr.append(" AND b.parent_group_id  in  (select  group_id  from   dchngroupinfo  where  parent_group_id ='?')");
  sqlStr.append(" ORDER BY a.root_distance");
   
%>

<wtc:pubselect   name="sPubSelect"  outnum="4">
	<wtc:sql><%=sqlStr.toString()%></wtc:sql>
	<wtc:param  value="<%=group_id%>"/>
</wtc:pubselect>

<wtc:array id="adds" scope="end"/>


<HTML>
	<HEAD>
		<TITLE>组织树选择</TITLE>
		<script language="javascript" src="/njs/extend/mztree/MzTreeView12.js"></script>
	</HEAD>
	<body>
		<div id="operation">
			<form name="frm" action="" method="post">
				<div id="operation_table">
						<div class="title" style="width: 100%">
							<div class="text">组织树</div>
						</div>
						<div class="mztree" id="tbc_01">
						</div>
						<script language="JavaScript">
				tree = new MzTreeView("tree");
				tree.setIconPath("/nresources/default/images/mztree/");
				
				
				with(tree)
				{
					
					N["0_<%=group_id%>"]="T:<%=group_name%>;C:L('<%=group_id%>&&<%=group_name%>')";
					<%
					
					for (int i = 0; i < adds.length; i++) 
					{
						%>
						N["<%=adds[i][0]%>"]="T:<%=adds[i][1]%>;C:L('<%=adds[i][2]%>&&<%=adds[i][1]%>')";
						<%
					}
					%>		
				}
				
				$('#tbc_01').html(tree.toString());
				tree.expandAll("2");
  			</script>
					</div>

			</form>
		</div>
		<script>
			function   L(str){
				window.returnValue  = str+"&&aa";
				window.close();
			}
		</script>
	</body>
</html>
