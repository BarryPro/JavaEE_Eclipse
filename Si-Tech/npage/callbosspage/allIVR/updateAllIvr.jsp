<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%>
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>
<%
String flag=WtcUtil.repNull(request.getParameter("flag"));
String contactId=WtcUtil.repNull(request.getParameter("contactId"));
String checkPwdType=WtcUtil.repNull(request.getParameter("checkPwdType"));
String switcher=WtcUtil.repNull(request.getParameter("loginNo"));
String tableNameEnd = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
Dcallcallyyyymm upatedcallcallpage=DCallCacheManager.getInstance().getValue(contactId);
String retCodea="000000";
String sql="";
if(flag.length()<2){
/**sql="update dmantoivr"+tableNameEnd+" t set t.successflag ='"+flag+"' where t.serialno = "+
           " (select max(a.serialno) from dmantoivr"+tableNameEnd+" a where a.switcher = '"+switcher+"')"; 
*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
sql="update dmantoivr"+tableNameEnd+" t set t.successflag = :v1  where t.serialno = "+
" (select max(a.serialno) from dmantoivr"+tableNameEnd+" a where a.switcher =  :v2 )"; 
     %>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=flag%>"/>
	<wtc:param value="<%=switcher%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
 
 <% 
 	  if(retRows[0][0].equals("000001")){
 	  retCodea="000001";			
	  }
	  }
else{	  
		 try
		 {
				if("YY".equalsIgnoreCase(flag))
				{ 
					if("1".equalsIgnoreCase(checkPwdType))
					{ 
						upatedcallcallpage.setOther_passwd_flag("YY");
					}
					else
					{
						upatedcallcallpage.setVertify_passwd_flag("YY");
					}
					String checkPwd=upatedcallcallpage.getCheckpsnum();
					if(checkPwd==null||checkPwd.equals("")){
					checkPwd="1";
					}
					else
					{
					checkPwd=String.valueOf(Integer.parseInt(checkPwd)+1);
					}
					upatedcallcallpage.setCheckpsnum(checkPwd);	
				}
				else if("YN".equalsIgnoreCase(flag))
				{ 
					if("1".equalsIgnoreCase(checkPwdType))
					{
						upatedcallcallpage.setOther_passwd_flag("YN");
					}
					else{
						upatedcallcallpage.setVertify_passwd_flag("YN");
					}
					String checkPwd=upatedcallcallpage.getCheckpsnum();
					if(checkPwd==null||checkPwd.equals("")){
					checkPwd="1";
					}
					else
					{
					checkPwd=String.valueOf(Integer.parseInt(checkPwd)+1);
					}
					upatedcallcallpage.setCheckpsnum(checkPwd);
				}
				    
		}
		catch(Exception e)
		{
				retCodea="000001";	
		}
}
out.print(retCodea);
%>


