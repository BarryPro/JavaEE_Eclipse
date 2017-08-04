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
		/* ningtn 添加 批评掉短信提醒的审批 */
		getRegionSql = "SELECT  distinct(create_accept),b.function_name, c.bill_name, d.prompt_name, a.prompt_seq,"
       +"  a.release_action, a.prompt_content, a.valid_flag,"
       +" a.create_login, to_char(a.create_time,'yyyy-mm-dd'), to_char(a.valid_time,'yyyy-mm-dd'), to_char(a.invalid_time,'yyyy-mm-dd'),"
       +" a.modify_login, to_char(a.modify_time,'yyyy-MM-dd'), a.modify_accept"
  		 +" FROM sfuncpromptaudit a,sfunccode b,sPrintBillType c,sFuncPromptType d" 
  		 +" where a.function_code = b.function_code and a.bill_type = c.bill_type and a.prompt_type = d.prompt_type "
  		 +" AND a.prompt_type != '20' AND a.bill_type != '20' "
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
			
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="18"> 
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%		

System.out.println("sqlStr1="+sqlStr1);
System.out.println("sVerifyTypeArr.length"+sVerifyTypeArr.length);
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
						parent.document.all.sAuditAccept.value=impValue;
						parent.document.showMainOprInfoFrame.location.href = "f9614_showOprInfo.jsp?sAuditAccept="+impValue+"&release_action="+oprAccRadio.release_action+"&IsNotCreateLoginModify="+oprAccRadio.IsNotCreateLoginModify;	
						parent.document.getElementById("showMainOprInfoFrame").style.display = "block";			
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr height=25 align="center">
				<th nowrap>选择</th>
				<th nowrap>操作批次流水</th>
				<th nowrap>模块名称</th> 
				<th nowrap>发布内容</th>
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
								if(sVerifyTypeArr[i][5].equals("1"))
								{
									out.println(sVerifyTypeArr[i][0]);
								}
								else
								{
									out.println(sVerifyTypeArr[i][14]);
								}
								%>" 
								<%
								System.out.println("sVerifyTypeArr[i][5]="+sVerifyTypeArr[i][5]);
								System.out.println("sVerifyTypeArr[i][8]="+sVerifyTypeArr[i][8]);
								System.out.println("sVerifyTypeArr[i][14]="+sVerifyTypeArr[i][12]);
								
								System.out.println("sVerifyTypeArr[i][5].equals(3)="+sVerifyTypeArr[i][5].equals("3"));
								System.out.println("!(sVerifyTypeArr[i][12].equals(sVerifyTypeArr[i][8]))="+!(sVerifyTypeArr[i][12].equals(sVerifyTypeArr[i][8])));
								
									//修改
									if(sVerifyTypeArr[i][5].equals("3")
										&&
										!(sVerifyTypeArr[i][12].equals(sVerifyTypeArr[i][8]))
										)
									{
										out.println("IsNotCreateLoginModify='Y'");
										System.out.println("YYY");
									}else
									{
										out.println("IsNotCreateLoginModify='N'");
										System.out.println("NNN");
									}
								%>
								
								release_action="<%=sVerifyTypeArr[i][5]%>" onclick="doChange(this)">	
								
							</td>
							<td class="<%=tbclass%>"><%
								if(sVerifyTypeArr[i][5].equals("1"))
								{
									out.println(sVerifyTypeArr[i][0]);
									}
							else
								{
									out.println(sVerifyTypeArr[i][14]);
								}
								
								%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td style="word-break:break-all;" class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
<%
					if("1".equals(sVerifyTypeArr[i][5])){
%>	
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
<%				
					}else{
%>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][12]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][13]%>&nbsp;</td>					
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


