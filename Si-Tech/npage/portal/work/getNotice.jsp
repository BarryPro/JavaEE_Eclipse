<%
   /*
   * ����: ��ѯϵͳ����
�� * �汾: v1.0
�� * ����: 2008��4��18��
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);

    String org_code = (String)session.getAttribute("orgCode");
    String regionCode=org_code.substring(0,2);
    String cssPath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
%>

<wtc:service name="sIndexNotice" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%

Date d1=new Date();//��ǰʱ��
Date d2=null;
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy��MM��dd��");
String isFlag  = "";
String reqCont = request.getContextPath();
String imgStr1 = "";//�Ƿ���Ҫͼ��
String imgStr2 = "";//�Ƿ�����ͼ��
%>
<div class="notice">
	<dl>
<%

try{
if(retCode.equals("000000"))
{
	 for(int i=0;i<result.length;i++){
	 
		 String classes="";
		 if(i%2==1){
		 	classes="grey";
   		 }
   		 
   		 isFlag = result[i][1].trim();
   		 d2=sdf.parse(result[i][2]);
   		 imgStr1 = "";
   		 imgStr2 = "";
   		 if(isFlag.equals("1")){//��Ҫ����
   		 	imgStr1 = "<img src='"+reqCont+"/nresources/"+cssPath+"/images/impor.gif' alt='dot' width='14' height='14'>";
   		 }
		 if((d1.getTime()-d2.getTime())/1000/(60*60*24)<=3){//���¹��治����3��
		 	imgStr2 = "<img src='"+reqCont+"/nresources/"+cssPath+"/images/new.gif' alt='dot' width='28' height='11'>";
		 }

%>       
    <dt>
        <img src="<%=reqCont%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif" alt="dot" width="3" height="5"> <a href="#this"><%=result[i][0]%>(<%=sdf1.format(d2)%>)<%=imgStr1%><%=imgStr2%></a>
    </dt>
<%
	}
}
else
{
	out.println("<dt>��ȡ����ʧ��</dt>");
}

} catch (Exception e) {
	e.printStackTrace();
}
%>
    	
    </dl>
</div>