<%
   /*
   * ����: �ύ�ط��Ż�����
�� * �汾: v1.0
�� * ����: 2007/01/25
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@page contentType="text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               	//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //��½����
	String regionCode=org_code.substring(0,2);
			
	//������Ϣ���������
	int errCode = 0;
	String errMsg = "";

	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String detail_code = request.getParameter("detail_code");
	String sm_code = request.getParameter("sm_code");
	String afunction_code_array = request.getParameter("function_code_array");
	String afavour_rate_array = request.getParameter("favour_rate_array");
	String aday_flag_array = request.getParameter("day_flag_array");
	String typeButtonNum = request.getParameter("typeButtonNum");
	String[] function_code_array = afunction_code_array.split(",");
    String[] favour_rate_array = afavour_rate_array.split(",");
    String[] day_flag_array  = aday_flag_array.split(",");
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[] acceptList = null;
		
	ArrayList paramsIn = new ArrayList(10);
	paramsIn.add(workNo);
	paramsIn.add(nopass);
	paramsIn.add("5238");
	paramsIn.add(login_accept);
	paramsIn.add(region_code);
	paramsIn.add(detail_code);
	paramsIn.add(sm_code);
	paramsIn.add(function_code_array);
	paramsIn.add(favour_rate_array);
	paramsIn.add(day_flag_array);

	
	acceptList = impl.callService("s5238_FuncCfm",paramsIn,"2");
	errCode=impl.getErrCode();   
	errMsg=impl.getErrMsg();
	
	if(errCode != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
        	parent.document.form1.nextButton.disabled=false;
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			parent.window.closewindow();
        </script>
<%
	}
%>

