<%
	/*
	 * ����: ��Ϣ
	 * �汾: 1.0
	 * ����: 2008/10/21
	 * ����: kouwb 
	 * ��Ȩ: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*
		String retType = request.getParameter("retType").trim();
    String op_code = request.getParameter("op_code").trim();
    System.out.println("op_code"+op_code);
    String phone_no = request.getParameter("phone_no").trim();
     System.out.println("phone_no"+phone_no);
    String status_name = request.getParameter("status_name").trim();
     System.out.println("status_name"+status_name);
    String op_note="״̬����Ϊ"+status_name;
     System.out.println("op_note"+op_note);
    String staff_status = request.getParameter("status_code").trim();
	   System.out.println("staff_status"+staff_status);
	  String login_no = (String)session.getAttribute("workNo");  
	  System.out.println("login_no"+login_no);
	  String login_name = (String)session.getAttribute("workName");
	   System.out.println("login_name"+login_name);
	  String org_code = (String)session.getAttribute("orgCode"); 
	   System.out.println("org_code"+org_code);
	  String ip_addr = (String)session.getAttribute("ipAddr");
		 System.out.println("ip_addr"+ip_addr);
		String long_Time = WtcUtil.repNull(request.getParameter("long_Time"));
 System.out.println("long_Time"+long_Time);
*/


String op_code="K025";
String phone_no="13803404010";
String status_name="����̨";
 String op_note="״̬����Ϊ";
 String login_name="���»�";
 String login_no="aakfEM";
 String staff_status="5";
 String kf_longin_n="108";
 String org_code="1";
 String long_Time="22";
  String ip_addr="22";
  
  

	com.sitech.crmpd.core.wtc.kfsp.ChgStatusManager chgstatusmanager = com.sitech.crmpd.core.wtc.kfsp.ChgStatusManager.getInstance();
	chgstatusmanager.invoke(login_no,login_name,org_code,phone_no,op_code,ip_addr,op_note,staff_status,long_Time);

%>
	var response = new AJAXPacket();
	response.data.add("retType","<%="retType"%>");
	response.data.add("retCode","<%="000000"%>");
	response.data.add("retMsg","<%="retMsg"%>");
	core.ajax.receivePacket(response);	


