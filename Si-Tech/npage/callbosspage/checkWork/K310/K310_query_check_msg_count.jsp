<%
  /**
   * ����: �ʼ�Ȩ�޹���->�ʼ�ƻ�����->�д��ʼ���������
�� * �汾: 1.0.0
�� * ����: 2009/3/15
�� * ����: jiangbing
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K310";
	String opName = "δ�ʼ���ʾ��Ϣ";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
      /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

    String workNo = WtcUtil.repNull(request.getParameter("workNo"));
	  String sqlStr = "select to_char(SUM (DECODE(SIGN(nvl(lp.plan_time,0)-nvl(lp.current_times,0)),"
	              + " -1,0,0,0,1,nvl(lp.plan_time,0)-nvl(lp.current_times,0),null,0 ))),1  "
	              + " from DQCLOGINPLAN lp,DQCPLAN p  " 
							  + " where lp.plan_id=p.plan_id  "
							  + " and p.begin_date < SYSDATE "
							  + " AND p.end_date > SYSDATE "
							  + " and lp.plan_id in "
                + " (select distinct plan_id from DQCCHECKLOGINPLAN clp where "
                + " clp.CHECK_LOGIN_NO = :workNo')";
 	  myParams = "workNo="+workNo ;   
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>

<wtc:array id="queryList" scope="end"/>	
<%
String count_K310 = "0";
if(queryList!=null&&queryList.length>0){
    count_K310 = queryList[0][0];
    if(count_K310==null||count_K310.equals("")){
        count_K310 = "0";
    }
}

%>



var response = new AJAXPacket();
response.data.add("count_K310","<%=count_K310%>");
core.ajax.receivePacket(response);