<%
  /*
   * ����: �ƻ����ʼ�Ȩ��У��/�޸��ʼ���Ȩ��У��
�� * �汾: 1.0
�� * ����: 2009/08/10
�� * ����: mixh
�� * ��Ȩ: sitech
   * update: mixh 2009/08/10 �޸�Ȩ��У���߼��������ˮ�Ѿ����мƻ����ʼ죬��Ҳ���ܽ��мƻ����ʼ�
   * update: mixh 2009/08/13 �޸�Ȩ��У���߼�����ѯ������ȥ��ƥ���ʼ칤��
   *
 ��*/
 %>
 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String serialnum  = (String)request.getParameter("serialnum");  //������ˮ��
	String start_date = (String)request.getParameter("start_date"); //��ˮ��������
	String flag       = (String)request.getParameter("flag");       //0:�ƻ����ʼ� 1:�ƻ����ʼ�    
	String staffno    = (String)request.getParameter("staffno");	//���ʼ칤��  
	String group_flag    = (String)request.getParameter("group_flag");	//���� ���忼����ʶ
	String plan_id    = (String)request.getParameter("plan_id");	//���� ���忼����ʶ
	String evterno    = (String)session.getAttribute("workNo");   //�ʼ칤��
	String strSql     = "";
	//�Լƻ����ʼ����Ȩ��У��
			if("1".equals(flag)){
				if("0".equals(group_flag)){
					strSql = "SELECT recordernum FROM dqcinfo WHERE  recordernum=:serialnum AND is_del != 'Y' ";
					myParams = "serialnum="+serialnum ;
				}else{
					strSql = "SELECT recordernum FROM dqcinfo WHERE  recordernum=:serialnum AND is_del != 'Y' and evterno=:evterno and plan_id=:plan_id " ;
					myParams = "serialnum="+serialnum+",evterno="+plan_id ;
				}
%>
				<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value="<%=strSql%>" />
					<wtc:param value="<%=myParams%>"/>
				</wtc:service>
				<wtc:array id="checkList" scope="end" />
				var response = new AJAXPacket();
				response.data.add("serialnum","<%=serialnum%>");
				response.data.add("checkList","<%=checkList.length%>");
				response.data.add("flag","<%=flag%>");
				response.data.add("staffno","<%=staffno%>");
				core.ajax.receivePacket(response);
<%	
			}
%>

<%
  //�ж��Ƿ���Զ��ʼ��������޸�
	if("3".equals(flag)){
		if(start_date!=null){
	     strSql = "select t2.recordernum from dcallcall" + start_date.substring(0,6)
	     				+ " t1,dqcinfo t2 where t2.recordernum =:serialnum and t2.recordernum = t1.contact_id and t2.flag <> '3' and t2.is_del != 'Y'";	
	     myParams = "serialnum="+serialnum ;    
	  }
  %>
      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
        <wtc:param value="<%=strSql%>" />
        <wtc:param value="<%=myParams%>"/>
      </wtc:service>
      <wtc:array id="checkList" scope="end" />
      var response = new AJAXPacket();
      response.data.add("serialnum","<%=serialnum%>");
      response.data.add("checkList","<%=checkList.length%>");
      response.data.add("flag","<%=flag%>");
      response.data.add("staffno","<%=staffno%>");
      core.ajax.receivePacket(response);
<%
	}
%>