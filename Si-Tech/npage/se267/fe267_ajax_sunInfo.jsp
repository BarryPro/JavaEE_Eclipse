<%
    /*************************************
    * ��  ��: 4A������¼�� e267 
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-9-16
    **************************************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	String opCode="e267";
	String opName="4A������¼��";
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String workNos = request.getParameter("val"); //ѡ��Ĺ���
    System.out.println("====e267=========workNos==========   "+workNos);
    String ip = (String)session.getAttribute("ipAddr");
	String selectGroupId = (String)request.getParameter("groupId")==null?"":(String)request.getParameter("groupId");
	System.out.println("=======e267======selectGroupId==========   "+selectGroupId);


		String[] workNosArr = new String[]{""};
		String workNosString = "";
		if(selectGroupId != null && selectGroupId.length() > 0){  //��ѡ
			/* ʹ��ѡ�񹤺� */
			    workNosArr = workNos.split(",");
    			System.out.println("==========workNosArr.length============   "+workNosArr.length);
    			if(workNosArr.length == 0){
    				workNosArr = new String[]{""};
    			}
		}else{  //��ѡ
		    workNosString = workNos;
			    System.out.println("=========================e267 ���뵥ѡworkNosString==========   "+workNosString);
		}

%>   
<wtc:service name="se267Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="2" >
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=ip%>"/>
    <%
        if(selectGroupId != null && selectGroupId.length() > 0){  //��ѡ
            if(workNosArr!=null){
                if(workNosArr.length!=0){
    %>
                    <wtc:params value="<%=workNosArr%>"/>
    <%
                }
            }else{
    %>
                 <wtc:param value=""/>
    <%
            }
        }else{    //����¼��
    %>   
        <wtc:param value="<%=workNosString%>"/>
    <%  
        }
    %>
        <wtc:param value="0"/>
</wtc:service>
<wtc:array id="result"  scope="end"/>

<%
String retcode = Code;
String retmsg = Msg;
   if(retcode.equals("000000")){
   %>
        <script language='javascript'>
            rdShowMessageDialog("�����ɹ���",2);
            window.location = "fe267_main.jsp?opCode=e267&opName=4A������¼��";
        </script>
      <%
   }else{
%>
        <script language='javascript'>
            rdShowMessageDialog("������Ϣ��<%=retmsg%><br>������룺<%=retcode%>", 0);
            window.location = "fe267_main.jsp?opCode=e267&opName=4A������¼��";
        </script>
<%
 }
%>



                                                         



   	

