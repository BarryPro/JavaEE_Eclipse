<%
  /*
   * ����: ȡ�ú��������
�� * �汾: 1.0.0
�� * ����: 2009/03/24
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
    /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 	  
	String callPhone = WtcUtil.repNull(request.getParameter("callPhone"));
	String sql = "select b.prov_name,b.city_name from dcalltelbelong a,scallcitycode b where a.city_code=b.long_code and a.tel_no=substr(:callPhone,1,7) ";
	myParams="callPhone="+callPhone;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />				
<%
String tempTown="";
String provice="";
if(result.length>0){
	if(result[0][0].equalsIgnoreCase(result[0][1])){
		tempTown = result[0][0];
	}else{
		tempTown = result[0][0]+result[0][1];
	}
	
}

provice=result.length>0?result[0][0]:"";
%>	
<%
out.println(tempTown+"|"+provice);


%>

