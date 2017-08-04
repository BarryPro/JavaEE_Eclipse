<%@ include file="/npage/workflow/admin/pub/wb_include.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String opCode = "6052";
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 20;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

%>
<script type="text/javaScript">
	function role_Query()
	{
		
	}
</script>
<form name="form13" method="post">
  <div class="title">
		<div id="title_zi">工号管理</div>
	</div>	
	    <table cellspacing="0">
			<TR> 
				<TD class="blue">角色 </td>
				<td>			
					<select name="role_code_2">
						<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select role_code, role_code||'->'||role_desc from swsrole order by role_code</wtc:sql>
						</wtc:qoption>
					</select>
					<input name="roleQuery" id="roleQuery" type="button" class="b_text" onMouseUp="role_Query();" onKeyUp="if(event.keyCode==13)role_Query();" value="查询">
				</TD>	
				<TD class="blue">工号 </td>
				<td>
					<input type='text' maxlength="6" name="login_no" value="">
				</TD>	
			</TR>
	      	<TR>
		        <TD align="center" colspan="4">
			          <input name="transmit" onClick="transmit1()" type="hidden" class="b_foot" value="">
			          &nbsp;&nbsp;
			          <input name="" onClick="add2()" type="button" class="b_foot" value="增 加">
			          &nbsp;&nbsp;
			          <input name="cancel2" onClick="removeCurrentTab()" type="button" class="b_foot" value="关 闭">
		        </TD>
		      </TR>
	    </table>


<%
		String sqlStr = "	select a.role_code, b.role_desc ,login_no from dWsRoleMemb a,swsrole b where a.role_code = b. role_code order by role_code";
		String sqlStr0  =  "SELECT count(*) from (" + sqlStr + ")"; 	       
		String sqlStr1 = "select * from (select row_.*,rownum id from (" + sqlStr + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; 
%>

		<wtc:pubselect  name="sPubSelect" outnum="1"> 
		<wtc:sql><%=sqlStr0%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="allNumArr"  scope="end"/> 
<%
		int totalNum = allNumArr.length>0?Integer.parseInt(allNumArr[0][0]):0;
%>
			
		<wtc:pubselect  name="sPubSelect" outnum="4"> 
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect> 
			<wtc:array id="infoArr" scope="end"/>     
	    
	<table align="center" cellspacing="0">
		<tr align="center" >
			<th>角色 </td>
			<th>角色名称 </td>
			<th>工号 </td>
			<th>操作 </td>
		</tr>	
	<%
	
				String tdClass="";
				if(retCode.equals("000000")){
					if(infoArr.length>0){
						for(int j=0;j<infoArr.length;j++){
					if((j%2)==0)
						tdClass = "Grey";
					else
						tdClass="";
	%>
							<TR align="center"> 
									<TD height="20"  class='<%=tdClass%>'>
										<%=infoArr[j][0]%>
									</TD>
									<TD height="20"  class='<%=tdClass%>'>
										<%=infoArr[j][1]%>
									</TD>
									<TD height="20"  class='<%=tdClass%>'>
										<%=infoArr[j][2]%>
									</TD>									
									<TD  class='<%=tdClass%>'>
										<input name="delete21" onClick="delete2('<%=infoArr[j][0]%>','<%=infoArr[j][2]%>')" type="button" class="b_text" value="删除">
									</TD>
							</TR>		
					
							
									
	<%				
						}
						
					}
				}else{
					throw new Exception("获取合作伙伴编号错误!");
				}
	%>	
						<tr align="right">
						<td colspan="4" height="25px">
							<div style="position:relative;font-size:12px;color:red">
							<%	
							   int iQuantity = totalNum;
							   Page pg = new Page(iPageNumber,iPageSize,iQuantity);
							   PageView view = new PageView(request,out,pg); 
							   view.setVisible(true,true,0,0);       
							%>	
							</div>
						</td>
					</tr>		
	    </table>    
                