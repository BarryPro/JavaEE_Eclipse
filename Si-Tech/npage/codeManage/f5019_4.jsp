<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
 <%
  String opCode = "5019";
  String opName = "����������������";
 %>
<HTML>
<HEAD>
<TITLE>������BOSS-�б�</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>
<%
String regionCode = (String)session.getAttribute("regCode");

		String strSql = "select a.REGION_CODE,region_name,decode(VALID_FLAG,'Y','��Ч','N','��Ч'),BULLET_CODE,BULLET_CONTENT,BOOT_NAME,BOOT_DATE from DSYSBULLET a,sregioncode b where a.region_code =b.region_code order by BULLET_CODE";
%>
	<wtc:pubselect name="sPubSelect" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=strSql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
  <div class="title"><div id="title_zi">��������Ϣ�����б�</div></div>
  <TABLE cellSpacing=0>
	           <tr >
				<th width=7%><div align="center">�������</div></th>      
				<th width=7%><div align="center">��������</div></th>
				<th width=7%><div align="center">��Ч��</div></th>      
				<th width=7%><div align="center">���к�</div></th>		 	
				<th width=60%><div align="center">��������</div></th>      
				<th width=6%><div align="center">���浥λ</div></th>		 	
		  	<th width=6%><div align="center">����ʱ��</div></th>		 	
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
			  <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
			  <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>
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
