<%
   /*
   * 功能: 注意事项库增加-查询代码
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
<%
 		String opCode = "9605";
 		String opName = "注意事项库增加";

		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		
		String iClassCode = WtcUtil.repNull(request.getParameter("iClassCode"));
		String iClassName = WtcUtil.repNull(request.getParameter("iClassName"));
		String getRegionSql = "select class_code,class_name from sClass where class_code in (10431, 10442,10702) ";
		if(!"".equals(iClassCode)){
			getRegionSql += " and class_code like '%"+iClassCode.trim()+"%'";
		}
		
		if(!"".equals(iClassName)){
			getRegionSql += " and class_name like '%"+iClassName.trim()+"%'";	
		}
		System.out.println("getRegionSql add =="+getRegionSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="2"> 
		<wtc:sql><%=getRegionSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>

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
						
						if(parent.document.all.iClassCode.value=="10442"||parent.document.all.iClassCode.value=="10702")
						{
							parent.document.all.sFunctionCode2.value="ALL";
							parent.document.all.sFunctionCode2.readOnly = true;
							parent.document.getElementById("clearBtn").disabled=true;
							parent.document.all.sFunctionName2.disabled = true;
						}else
						{
								parent.document.all.sFunctionCode2.value="";
								parent.document.all.sFunctionCode2.readOnly = false;
								parent.document.getElementById("clearBtn").disabled=false;
								parent.document.all.sFunctionName2.disabled = false;
						}
						
						if(parent.document.all.iClassCode.value=="10431")//特服代码
						{
							parent.document.all.iClassSeq.value="1";
						}else if(parent.document.all.iClassCode.value=="10442")//资费代码
						{
							parent.document.all.iClassSeq.value="2";
						}else if(parent.document.all.iClassCode.value=="10702")//小区代码
						{
							parent.document.all.iClassSeq.value="3";
						}
						
						/**
							*增加、修改模块修改
							*1.字段的：选小区代码时，打印选择只有“打印”，提示类型只有“资费说明”
							*2.下拉框中只有一个值的，直接置成灰色，不用选择
						**/
						if(parent.document.all.iClassCode.value=="10702"){
								parent.document.all.sIsPrint2.value = "2";
								parent.document.all.sIsPrint2.disabled = true;
						}else{
								parent.document.all.sIsPrint2.disabled = false;
						}
						
						parent.doChangeIsPrint2Select(parent.document.getElementById("sIsPrint2"));	
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
				<th width="15%" nowrap>选择</td>
				<th width="35%" nowrap>代码</td>
				<th nowrap>字段域名称</td> 
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
  </table>
 	</div>
</body>
</html>    

