<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
System.out.println("----------------------------getMajorProd.jsp------------------------------------");  
   String offerId = WtcUtil.repNull(request.getParameter("offerId"));
   System.out.println("--------------------offerId--------------------------"+offerId);
%>
<wtc:utype name="sMainProd" id="retVal" scope="end">
	<wtc:uparam value="<%=offerId%>" type="long"/>   
</wtc:utype>

<script>

var majorProductArr = [];	//取基本销售品信息
<%
String errCode = String.valueOf(retVal.getValue(0));

if(errCode.equals("0"))
{ 
		if(retVal.getUtype("2").getSize() > 0 && retVal.getUtype("2.0").getSize() > 0)
		{
			for(int i=0;i<retVal.getUtype("2.0").getSize();i++){
			System.out.println("offerId===="+retVal.getUtype("2.0").getValue(i));
%>
			majorProductArr[<%=i%>] = "<%=retVal.getUtype("2.0").getValue(i)%>";	 
<%	
			}
		}	
}	
%> 
</script>