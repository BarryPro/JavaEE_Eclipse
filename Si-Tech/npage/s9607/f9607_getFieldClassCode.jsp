<%
   /*
   * 功能: 注意事项库修改-查询代码
　 * 版本: v3.0
　 * 日期: 2008-10-10
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
 		String opCode = "9607";
 		String opName = "注意事项库修改";

		String regionCode = (String)session.getAttribute("regCode");
		
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
		
		String iClassCode = WtcUtil.repNull(request.getParameter("iClassCode"));
		String iClassName = WtcUtil.repNull(request.getParameter("iClassName"));
		
		String getRegionSql = "select class_code,class_name from sClass where class_code in (10431, 10442,10702) ";
		if(!"".equals(iClassCode)){
			getRegionSql += " and class_code like '%"+iClassCode.trim()+"%'";
		}
		if(!"".equals(iClassName)){
			getRegionSql += " and class_name like '%"+iClassName.trim()+"%'";	
		}
		
		System.out.println("getRegionSql->"+getRegionSql);
		
		String sqlStr0  = "SELECT count(*) from (" + getRegionSql + ")"; 
		String sqlStr1 = "select * from (select row_.*,rownum id from (" + getRegionSql + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; 
%>

		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=sqlStr0%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="allNumArr"  scope="end"/> 
			
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="3"> 
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
			function doChange(){
				var regionRadios = document.getElementsByName("regionRadio");	
				for(var i=0;i<regionRadios.length;i++){
					if(regionRadios[i].checked){
						var impValue = regionRadios[i].value;
						parent.document.all.iClassCode.value=impValue.substring(0,impValue.indexOf("|"));
						parent.document.all.iClassName.value=impValue.substring(impValue.indexOf("|")+1,impValue.length);
					}
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th width="15%" nowrap>选择</th>
				<th width="35%" nowrap>代码</th>
				<th nowrap>字段域名称</th> 
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("没有任何记录！");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="radio" name="regionRadio" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
		<tr align="right">
			<td colspan="3" height="30px">
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

