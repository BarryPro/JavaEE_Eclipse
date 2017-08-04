<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
 <%
  String opCode = "5019";
  String opName = "公告栏参数话管理";
 %>
<HTML>
<HEAD>
<TITLE>黑龙江BOSS-列表</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>
<%
String regionCode = (String)session.getAttribute("regCode");

		String strSql = "select a.REGION_CODE,region_name,decode(VALID_FLAG,'Y','有效','N','无效'),BULLET_CODE,BULLET_CONTENT,BOOT_NAME,BOOT_DATE from DSYSBULLET a,sregioncode b where a.region_code =b.region_code order by BULLET_CODE";
%>
	<wtc:pubselect name="sPubSelect" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=strSql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
  <div class="title"><div id="title_zi">公告栏信息管理列表</div></div>
  <TABLE cellSpacing=0>
	           <tr >
				<th width=7%><div align="center">区域代码</div></th>      
				<th width=7%><div align="center">区域名称</div></th>
				<th width=7%><div align="center">有效性</div></th>      
				<th width=7%><div align="center">序列号</div></th>		 	
				<th width=60%><div align="center">公告内容</div></th>      
				<th width=6%><div align="center">公告单位</div></th>		 	
		  	<th width=6%><div align="center">公告时间</div></th>		 	
			   </tr>													
							
			  <%
						  for(int y=0;y<result_t.length;y++){
							  %>
					  <tr  align="center">     
					<%    
						  for(int j=0;j<result_t[y].length;j++){
								  String tbstr="";

								 tbstr = "<TD>" + result_t[y][j].trim() + "<input type='hidden' " +
								" id='R" + j  + "' name='R" + j + "' class='button' value='" + 
								(result_t[y][j]).trim() + "'readonly></TD>";
							
								out.println(tbstr);
						}
					%>
					</tr>
					<%
						  }
              %>

</TABLE>
       <TABLE cellSpacing=0>
          <TBODY>
            <TR> 
              <TD id="footer">
			  <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
			  <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>
              </TD>
            </TR>
          </TBODY>
       </TABLE>
       <%@ include file="/npage/include/footer.jsp" %>
	   </FORM>
     </BODY>
   </HTML>
<script>
 
</script>
