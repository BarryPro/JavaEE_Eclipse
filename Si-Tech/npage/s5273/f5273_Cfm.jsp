<%
  /*
�� * ����: wangwei
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
��*/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.25
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%

    String myretFlag="",myretMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
   
	String loginNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	
	String region_code = request.getParameter("sales_region");
	String reward_rate = request.getParameter("reward_rate");
	String awake_fee = request.getParameter("awake_fee");
	String min_prepay = request.getParameter("min_prepay");
	String reason= request.getParameter("reason");
	String retMsg = null;
	
	/****************����  sDemoGetMsg  ***********************/
   
	String[] paraStrIn = new String[7];
	paraStrIn[0] = loginNo;                 //����
	paraStrIn[1] = nopass;                  //��������
	paraStrIn[2] = region_code;             //���д���
	paraStrIn[3] = reward_rate;             //������
	paraStrIn[4] = awake_fee;               //�����̴߽ɷ�ֵ
	paraStrIn[5] = min_prepay;              //�����̳�ֵ��ֵ
	paraStrIn[6] = reason;              	//�޸�ԭ��

	String srvName = "s5273Cfm"; //������1
	String outParaNums = "0"; //�����������

	//impl.callFXService(srvName, paraStrIn,outParaNums,"region",regionCode);
%>
	<wtc:service name="s5273Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:params value="<%=paraStrIn%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<% 
	String returnCode = retCode1; //�������
	String returnMsg = retMsg1; //������Ϣ

	if(returnCode.equals("000000")){
		retMsg = "Ӷ������������óɹ�";
%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
		    removeCurrentTab();
		</script>
<%
	}else{
		retMsg = returnMsg;
%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
<%
	}
%>
