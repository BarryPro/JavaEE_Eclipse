<%
  /*
   * ����: ��dqcresultaffirm������ʼ�ȷ������
�� * �汾: 1.0
�� * ����: 2010/4/11
�� * ����: tangsong
�� * ��Ȩ: sitech
   *
 ��*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String belongno   = WtcUtil.repNull(request.getParameter("belongno"));   //������ˮ��                            
	String submitno   = WtcUtil.repNull(request.getParameter("submitno"));   //�ύ�˹���
	String type       = WtcUtil.repNull(request.getParameter("type"));       //���0:�ʼ���֪ͨ��1���ߡ�2�𸴡�3ȷ��                               
	String serialnum  = WtcUtil.repNull(request.getParameter("serialnum"));  //�ʼ쵥��ˮ                                 
	String staffno    = WtcUtil.repNull(request.getParameter("staffno"));    //���칤��                                   
	String evterno    = WtcUtil.repNull(request.getParameter("evterno"));    //�ʼ칤��                       
	String title      = WtcUtil.repNull(request.getParameter("apptitle"));   //����                                       
	String content    = WtcUtil.repNull(request.getParameter("content"));    //���� 
%>
	<wtc:service name="sK203Insert" outnum="3">
	<wtc:param value="<%=belongno%>"/>
	<wtc:param value="<%=submitno%>"/>
	<wtc:param value="<%=type%>"/>
	<wtc:param value="<%=serialnum%>"/>
	<wtc:param value="<%=staffno%>"/>
	<wtc:param value="<%=evterno%>"/>
	<wtc:param value="<%=title%>"/>
	<wtc:param value="<%=content%>"/>
	</wtc:service> 
                          
	var response = new AJAXPacket();
	core.ajax.receivePacket(response);
                      