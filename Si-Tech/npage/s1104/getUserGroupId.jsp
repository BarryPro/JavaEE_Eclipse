<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
System.out.println("------------------------------getUserGroupId.jsp---------------------------------------");  
	//ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
	//System.out.println("--------------arr1.size()------------"+arr1.size());
	//String[][] otherInfo = (String[][])arr1.get(5);  
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	//String group_name = otherInfo[0][4]; 
	String group_id = (String)session.getAttribute("groupId");	
	System.out.println("@@@@@@@@@@@@@@@"+group_id);
 System.out.println("--!!------------group_id-----------"+group_id);	
  System.out.println("--!!------------regionCode-----------"+regionCode);	
			
	//String sql =  "SELECT a.parent_group_id,b.group_name FROM dChnGroupInfo a, dChnGroupMsg b WHERE a.group_id='"+group_id+"' AND parent_level=2 AND a.parent_group_id= b.group_Id";
	String sql =  "SELECT a.parent_group_id,b.group_name FROM dChnGroupInfo a, dChnGroupMsg b WHERE a.group_id='"+group_id+"'  AND a.parent_group_id= b.group_Id";
%>
<wtc:pubselect name="sPubSelect"  outnum="4">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>	
<%			

for(int ii=0;ii<result.length;ii++){
    System.out.println(result[ii][0]);
    System.out.println(result[ii][1]);
    System.out.println(result[ii][2]);
    System.out.println(result[ii][3]);    
}
	StringBuffer sqlStr = new  StringBuffer();
		sqlStr.append("SELECT parent_group_id||'_'||d.group_id  AS  group_tree,e.group_name,e.group_id ");
	  sqlStr.append(" FROM  dChnGroupInfo d, (SELECT group_id FROM DCHNGROUPMSG  WHERE ROOT_DISTANCE IN(2,3,4) AND SUBSTR(BOSS_ORG_CODE,0,2)= '"+regionCode+"' AND HAS_CHILD='Y' ) id ,dChnGroupMsg e  ");    
	  sqlStr.append(" WHERE  d.group_id =id.group_Id  ");   
	  sqlStr.append(" AND d.group_Id= e.group_Id AND d.DENORM_LEVEL =1 ");
	  
	  System.out.println("--ttt===sqlStr===="+sqlStr);
	  
	  //sqlStr.append(" FROM  dChnGroupInfo d, (SELECT group_id FROM DCHNGROUPMSG  WHERE ROOT_DISTANCE IN(2,3,4) AND SUBSTR(BOSS_ORG_CODE,0,2)= '"+regionCode+"' AND HAS_CHILD='Y') id ,dChnGroupMsg e  ");    

%>

<wtc:pubselect name="sPubSelect"  outnum="4">
	<wtc:sql><%=sqlStr.toString()%></wtc:sql>
</wtc:pubselect>
<wtc:array id="adds" scope="end"/>

<%
for(int ii=0;ii<adds.length;ii++){
    System.out.println(adds[ii][0]);
    System.out.println(adds[ii][1]);
    System.out.println(adds[ii][2]);
    System.out.println(adds[ii][3]);    
}
%>

<HTML>
	<HEAD>
		<TITLE>组织树选择</TITLE>
		<script language="javascript" src="/njs/extend/mztree/MzTreeView12.js"></script>
	</HEAD>
	<body>
			<form name="frm" action="" method="post">
				<div id="operation_table">
						<div class="title" >
							<div  id="title_zi">组织树</div>
						</div>
						<table cellspacing=0><tr><td>
						<div class="mztree" id="tbc_01">
						</div>
					    </td></tr></table>
						<script language="JavaScript">
				tree = new MzTreeView("tree");
				tree.setIconPath("/nresources/default/images/mztree/");
				
				
				with(tree)
				{
					
					//N["0_<%=result[0][0]%>"]="T:<%=result[0][1]%>;C:L(tree,'<%=result[0][0]%>&&<%=result[0][1]%>')";
					N["0_<%=result[1][0]%>"]="T:<%=result[1][1]%>;C:L(tree,'<%=result[1][0]%>&&<%=result[1][1]%>')";
					<%
					
					for (int i = 0; i < adds.length; i++) 
					{
					    System.out.println("----------ttt-----tree_name=="+ adds[i][2] );
						%>
						N["<%=adds[i][0]%>"]="T:<%=adds[i][1]%>;C:L(tree,'<%=adds[i][2]%>&&<%=adds[i][1]%>')";
						<%
					}
					%>	
				}
				
				$('#tbc_01').html(tree.toString());
				tree.expandAll("2");
  			</script>

			</form>
		</div>
		<script>
			function   L(tree,str){
				if(tree.node[tree.currentNode.id].hasChild){
					return  false;
				}
				window.returnValue  = str;
				window.close();
			}
		</script>
	</body>
</html>
