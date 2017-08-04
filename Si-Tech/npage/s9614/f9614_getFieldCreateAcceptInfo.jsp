<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 注意事项库审批-查询审批流水信息
　 * 版本: v3.0
　 * 日期: 2008-10-14
　 * 作者: zhanghonga
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="com.sitech.boss.util.page.*"%>		
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
 		String opCode = "9614";
 		String opName = "注意事项库审批";

		String regionCode  = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
		
		String getRegionSql = "";
		getRegionSql = "SELECT DISTINCT (a.create_accept), decode(b.op_name,null,'所有功能', b.op_name),a.prompt_content,c.bill_name,"
       +" d.prompt_name, a.class_seq, e.class_name, a.class_value,"
       +"  a.create_login, to_char(a.create_time,'yyyy-MM-dd'), to_char(a.valid_time,'yyyy-MM-dd'),"
       +" to_char(a.invalid_time,'yyyy-MM-dd'), a.prompt_seq,"
  		 +" a.release_action, a.modify_accept,a.modify_login,to_char(a.modify_time,'yyyy-MM-dd'),f.Channels_Name" 
  		 +" FROM sdomainpromptaudit a,sfunccode b,sprintbilltype c,sfuncprompttype d,sclass e,sChannelsCode f"
  		 +" WHERE a.op_code = b.function_code(+)"
  		 +" AND a.bill_type = c.bill_type"
  		 +" AND a.prompt_type = d.prompt_type"
  		 +" and a.class_code = e.class_code"
  		 +" and a.Channels_Code = f.Channels_Code"
  		 +" AND (create_accept in (select audit_accept from dPromptAudit f where audit_login='"+workNo+"' and is_audit='N')"
  		 +" OR modify_accept in (select audit_accept from dPromptAudit f where audit_login='"+workNo+"' and is_audit='N')"
  		 +" )";

		getRegionSql += " order by a.create_accept desc";
		
		
		System.out.println(getRegionSql);
		String sqlStr0  = "SELECT count(*) from (" + getRegionSql + ")"; 
		String sqlStr1 = "select * from (select row_.*,rownum id from (" + getRegionSql + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; 
%>

		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=sqlStr0%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="allNumArr"  scope="end"/> 
			
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="19"> 
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%		
		int totalNum = allNumArr.length>0?Integer.parseInt(allNumArr[0][0]):0;
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function doChange(oprAccRadio){
				
				
				var oprAccRadios = document.getElementsByName("oprAccRadio");	
				var impValue="";
				
				if(oprAccRadio.checked==true){
						impValue = oprAccRadio.value.replace( /^\s*/, "" ).replace( /\s*$/, "" );
						parent.document.all.sAuditAccept2.value=impValue;
						parent.document.getElementById("oprAuditTable2").style.display = "block";
						parent.document.getElementById("showMainOprInfoFrame2").style.display = "block";	
						parent.document.showMainOprInfoFrame2.location.href = "f9614_showFieldInfo.jsp?sAuditAccept2="+impValue+"&release_action="+oprAccRadio.release_action+"&IsNotCreateLoginModify="+oprAccRadio.IsNotCreateLoginModify;					
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>选择</th>
				<th nowrap>操作批次流水</th>
				<th nowrap>模块名称</th> 
				<th nowrap>发布内容</th>
				<th nowrap>字段域名称</th>
				<th nowrap>字段域值</th> 	
				<th nowrap>输出顺序</th> 	
				<th nowrap>渠道类型</th> 	
				<th nowrap>提交工号</th>
				<th nowrap>提交时间</th>
				<th nowrap>生效时间</th>
				<th nowrap>失效时间</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="radio" name="oprAccRadio" value="
								<%
								if(sVerifyTypeArr[i][13].equals("1"))
								{
									out.println(sVerifyTypeArr[i][0]);
									}
							else
								{
									out.println(sVerifyTypeArr[i][14]);
								}
								%>" 
								<%
								System.out.println("sVerifyTypeArr[i][13]="+sVerifyTypeArr[i][13]);
								System.out.println("sVerifyTypeArr[i][15]="+sVerifyTypeArr[i][15]);
								System.out.println("sVerifyTypeArr[i][18]="+sVerifyTypeArr[i][18]);
									System.out.println("sVerifyTypeArr[i][17]="+sVerifyTypeArr[i][17]);
									//修改
									if(sVerifyTypeArr[i][13].equals("3")
									&&!(sVerifyTypeArr[i][15].equals(sVerifyTypeArr[i][8]))
									)
									{
										out.println("IsNotCreateLoginModify='Y'");
									}else
									{
										out.println("IsNotCreateLoginModify='N'");
									}
								%>
								release_action="<%=sVerifyTypeArr[i][13]%>" onclick="doChange(this)">	
							</td>
							<td class="<%=tbclass%>"><%
								if(sVerifyTypeArr[i][13].equals("1"))
								{
									out.println(sVerifyTypeArr[i][0]);
									}
							else
								{
									out.println(sVerifyTypeArr[i][14]);
								}
								%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td style="word-break:break-all;" class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][17]%>&nbsp;</td>
<%
							if("1".equals(sVerifyTypeArr[i][13])){
%>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td class="<%=tbclass%>" nowrap><%=sVerifyTypeArr[i][9]%>&nbsp;</td>				
<%			
							}else{
%>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][15]%>&nbsp;</td>
							<td class="<%=tbclass%>" nowrap><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
<%							
							}
%>
							<td class="<%=tbclass%>" nowrap><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
							<td class="<%=tbclass%>" nowrap><%=sVerifyTypeArr[i][11]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
		<tr align="right">
			<td colspan="20" style="background:#E6E6E6">
			  <div style="position:relative;font-size:12px;">
						<%	
						   int iQuantity = totalNum;
						   Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						   PageView view = new PageView(request,out,pg); 
						   view.setVisible(true,true,0,0);       
						%>
						&nbsp;&nbsp;&nbsp;&nbsp;	
				</div>	
			</td>	
		</tr>
  </table>
 	</div>
</body>
</html>    


