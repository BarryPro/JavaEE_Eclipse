<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 投诉冲正初始化-查询sp信息
　 * 版本: v3.0
　 * 日期: 2009-08-10
　 * 作者: zhangshuaia
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=GBK"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "4140";
 		String opName = "投诉原因维护--查询";
		
		/**需要regionCode来做服务的路由**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		
		String FirstClass = request.getParameter("FirstClass");             //退费一级原因
		String SecondClass = request.getParameter("SecondClass");           //退费二级原因
		System.out.println("22222 FirstClass->"+FirstClass);
		System.out.println("22222 SecondClass->"+SecondClass);
		
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("22222 checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr1"  scope="end"/>
<%
		/**根据loginRootDistance来判断工号权限问题**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr1 !=null && sVerifyTypeArr1.length>0){
				loginRootDistance = sVerifyTypeArr1[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr1[0][0]);
				System.out.println("33333 loginRootDistance->"+loginRootDistance);
			}
		}					
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));	
		String region_code = WtcUtil.repNull(request.getParameter("regionCode"));			
		StringBuffer  getInfoSql = new StringBuffer();
		//String getInfoSql = "";	
		System.out.println("op_code====="+opCode);
			if(opCode.equals("4140") )
			{
				if(FirstClass.equals("1003")||FirstClass.equals("1006")||FirstClass.equals("1009")||FirstClass.equals("1012")||FirstClass.equals("1015")||FirstClass.equals("1018")||FirstClass.equals("1021")||FirstClass.equals("1024")||FirstClass.equals("1027")||FirstClass.equals("1030")||FirstClass.equals("1033")||FirstClass.equals("1036")||FirstClass.equals("1039"))
				{
					getInfoSql.append("  select d.first_name,");	
					getInfoSql.append("  		nvl(d.second_name, '-T'),");	
					getInfoSql.append("  		nvl(f.third_name, '-T'),");
					getInfoSql.append("  		d.first_code,");
					getInfoSql.append("  		d.second_code,");
					getInfoSql.append("  		f.third_code");
					getInfoSql.append("  	from (select a.first_name,");
					getInfoSql.append("  				 nvl(e.second_name, '-T') second_name,");
					getInfoSql.append("  				 a.first_code,");
					getInfoSql.append("  				 e.second_code");
					getInfoSql.append("  			from SrefundFirst a,");	
					getInfoSql.append("  				 (select b.first_code, b.second_code, b.second_name");	
					getInfoSql.append("  					 from SrefundSecond b");
					getInfoSql.append("  					where b.valid_flag = '1') e");
					getInfoSql.append("  			where a.first_code = e.first_code(+)");
					getInfoSql.append("  				and a.region_code = '"+regionCode+"'");
					getInfoSql.append("  				and a.valid_flag = '1') d,");
					getInfoSql.append("  		 (select c.first_code, c.second_code, c.third_code, c.third_name");
					getInfoSql.append("  				 from SrefundThird c");
					getInfoSql.append("  				 where c.valid_flag = '2') f");
					getInfoSql.append("  	 where d.second_code = f.second_code(+)");
					getInfoSql.append("  		and d.first_code = f.first_code(+)");
					getInfoSql.append("  		and d.first_code = '"+FirstClass+"'");
				}
				else
				{
					getInfoSql.append("  select d.first_name,");	
					getInfoSql.append("  		nvl(d.second_name, '-T'),");	
					getInfoSql.append("  		nvl(f.third_name, '-T'),");
					getInfoSql.append("  		d.first_code,");
					getInfoSql.append("  		d.second_code,");
					getInfoSql.append("  		f.third_code");
					getInfoSql.append("  	from (select a.first_name,");
					getInfoSql.append("  				 nvl(e.second_name, '-T') second_name,");
					getInfoSql.append("  				 a.first_code,");
					getInfoSql.append("  				 e.second_code");
					getInfoSql.append("  			from SrefundFirst a,");	
					getInfoSql.append("  				 (select b.first_code, b.second_code, b.second_name");	
					getInfoSql.append("  					 from SrefundSecond b");
					getInfoSql.append("  					where b.valid_flag = '1') e");
					getInfoSql.append("  			where a.first_code = e.first_code(+)");
					getInfoSql.append("  				and a.region_code = '"+regionCode+"'");
					getInfoSql.append("  				and a.valid_flag = '1') d,");
					getInfoSql.append("  		 (select c.first_code, c.second_code, c.third_code, c.third_name");
					getInfoSql.append("  				 from SrefundThird c");
					getInfoSql.append("  				 where c.valid_flag = '1') f");
					getInfoSql.append("  	 where d.second_code = f.second_code(+)");
					getInfoSql.append("  		and d.first_code = f.first_code(+)");
					getInfoSql.append("  		and d.first_code = '"+FirstClass+"'");
				}
				
				if(!(SecondClass.equals("")))
				{
					getInfoSql.append("  	and d.second_code = '"+SecondClass+"'");
				}
				System.out.println("getInfoSql====="+getInfoSql);				 		 	
			}
							
		System.out.println("#######getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="TlsPubSelBoss"  routerKey="region"  routerValue="<%=regionCode%>" outnum="9"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%			
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("sVerifyTypeArr.length=" + sVerifyTypeArr.length);
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--				
		//-->
	</script>
	
</head>
<body>	
	<div id="Operation_Table">
     <table cellspacing="0" id='t1'>
			<tr align="center">
				<th nowrap>投诉退费一级原因</th>
				<th nowrap>投诉退费二级原因</th>
				<th nowrap>投诉退费三级原因</th> 			
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>" align="left"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="left"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="left"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table> 
 	</div>
</body>
</html>  

