<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-11 页面改造,修改样式
     *
     ********************/
%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML><HEAD>
<TITLE>客户ID查询</TITLE>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content=expired http-equiv=0>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
		 String opCode = "";
	 	 String opName = "客户ID查询";	
	 	 String regionCode=(String)session.getAttribute("regCode"); 
		 String id_no = request.getParameter("id_no");
		 String id_type=request.getParameter("id_type");
		 String  qrySql = "select cust_id, cust_name from dCustDoc where owner_type = '01' and id_iccid = '" + id_no + "'" ;
		 System.out.println(qrySql);
		 String work_no = (String)session.getAttribute("workNo");
		 String loginPwd    = (String)session.getAttribute("password");
		 String notestr="根据iccid=["+id_no+"]进行查询";
%>


<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="1238"/>
  <wtc:param value="<%=work_no%>"/>	
  <wtc:param value="<%=loginPwd%>"/>		
  <wtc:param value=""/>	
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=id_no%>"/>
  <wtc:param value="01"/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="allcus_idStr" start="1" length="17" scope="end"/>			

<script language="javascript">
 function ret(p)
 {
   window.returnValue=p;
   window.close();
 }
</script>
<BODY>
		<FORM action="" method=post name="form1" >
			<%@ include file="/npage/include/header_pop.jsp" %>
        <TABLE cellSpacing="0">
            <tr align="center">
              <th>客户ID</th>
              <th>客户名称</th>
             </tr>
          
<%
			String tbclass="";
			for(int i = 0 ; i < allcus_idStr.length; i ++){
				tbclass=(i%2==0)?"Grey":"";
				if("02".equals(returnFlag[0][0])){
					String ZSCustName11="";
				
			if(!("").equals(allcus_idStr[i][4].trim())) {
	
			if(allcus_idStr[i][4].trim().length() == 2 ){
				ZSCustName11 = allcus_idStr[i][4].trim().substring(0,1)+"*";
			}
			if(allcus_idStr[i][4].trim().length() == 3 ){
				ZSCustName11 = allcus_idStr[i][4].trim().substring(0,1)+"**";
			}
			if(allcus_idStr[i][4].trim().length() == 4){
				ZSCustName11 = allcus_idStr[i][4].trim().substring(0,2)+"**";
			}
			if(allcus_idStr[i][4].trim().length() > 4){
				ZSCustName11 = allcus_idStr[i][4].trim().substring(0,2)+"******";
			}
		}
		
 %>
            <tr>
              <td width="20%" class="<%=tbclass%>">
			    			<div align="center">
			    				<a href="#"  onclick="ret('<%=allcus_idStr[i][0].trim()%>')"><%=(String)allcus_idStr[i][0].trim()%></a>
			    			</div>
              </td>
              <td width="80%" class="<%=tbclass%>">
              	<div align="center">
              		<%=ZSCustName11%> 
              	</div>
			  			</td>		             
            </tr>
<%
			}
			}
%>
       </table>   
			<table cellspacing="0">
		   	<tr>
			  	<td id="footer"> 
		        <div align="center">
		          <input class="b_foot" type=button name=qryPage value="关闭" onClick="window.close()">
		        </div>
		      </td>
				</tr>
	    </table>
    <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
 </BODY>
 </HTML>
