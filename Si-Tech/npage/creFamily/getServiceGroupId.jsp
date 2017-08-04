<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
System.out.println("-----------------------------getServiceGroupId.jsp---------------------------------------");  
	ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
	System.out.println("-------------------------------arr1.size()------------------"+arr1.size());
	String[][] otherInfo = (String[][])arr1.get(6);  
	
	String group_name = otherInfo[0][4]; 
	String group_id = (String)session.getAttribute("groupId");	
 System.out.println("--!!------------group_id-----------"+group_id);		
			
	//String sql =  "SELECT a.parent_group_id,b.group_name FROM dChnGroupInfo a, dChnGroupMsg b WHERE a.group_id='"+group_id+"' AND parent_level=2 AND a.parent_group_id= b.group_Id";
	String sql =  "SELECT a.parent_group_id,b.group_name FROM dChnGroupInfo a, dChnGroupMsg b WHERE a.group_id='"+group_id+"' AND a.parent_group_id= b.group_Id";
	//hejwa增加测试用
	System.out.println("sql|"+sql);		
%>
<wtc:pubselect name="sPubSelect"  outnum="4">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>	
<%			
	StringBuffer sqlStr = new  StringBuffer();
		sqlStr.append("SELECT parent_group_id||'_'||d.group_id  AS  group_tree,e.group_name,e.group_id FROM  dChnGroupInfo d,  (SELECT a.group_Id FROM dChnGroupInfo a, dChnGroupMsg b  ");
	  sqlStr.append(" WHERE a.group_id = b.group_id AND  a.parent_group_id  <> b.group_id AND a.denorm_level >= 0 AND ((b.root_distance IN(1,2,3) AND b.first_class_code = '100' ) OR ( b.root_distance IN(4,5,6) AND b.first_class_code = '500' )) ");    
	  sqlStr.append("   AND a.parent_group_id =(SELECT parent_group_id FROM dChnGroupInfo WHERE group_id='"+group_id+"' AND parent_level=2) ) id ,dChnGroupMsg e  WHERE  d.group_id =id.group_Id  ");   
	  sqlStr.append("   AND  d.group_Id= e.group_Id AND d.DENORM_LEVEL =1 ");
	  
	  
%>

<wtc:pubselect name="sPubSelect"  outnum="4">
	<wtc:sql><%=sqlStr.toString()%></wtc:sql>
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
					
					N["0_<%=result[0][0]%>"]="T:<%=result[0][1]%>;C:L('<%=result[0][0]%>&&<%=result[0][1]%>')";
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
