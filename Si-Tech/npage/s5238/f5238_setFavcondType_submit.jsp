<%
   /*
   * ����: �ύ�Ż���������
�� * �汾: v1.0
�� * ����: 2007/01/23
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
	System.out.println("@@@@@@@@@@@");
	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String total_code = request.getParameter("total_code");
	String favcond_type = request.getParameter("favcond_type");
	String favcond_coder_code = request.getParameter("favcond_coder_code");
	String condetion_coder = request.getParameter("condetion_coder");
	String local_expr = request.getParameter("local_expr");
	String favour_condition = request.getParameter("favour_condition")==null?"":request.getParameter("favour_condition");
	String cond_attr = request.getParameter("cond_attr");
	String relation_expr = request.getParameter("relation_expr");
	String condition_step = request.getParameter("condition_step");
	String first_favour_object = request.getParameter("first_favour_object")==null?"":request.getParameter("first_favour_object");
	String second_favour_object = request.getParameter("second_favour_object")==null?"":request.getParameter("second_favour_object");
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[] acceptList = null;
		
	ArrayList paramsIn = new ArrayList(16);
	paramsIn.add(workNo);
	paramsIn.add(nopass);
	paramsIn.add("5238");
	paramsIn.add(login_accept);            //��ˮ                         
	paramsIn.add(region_code);             //��������                         
	paramsIn.add(total_code);             //�Żݴ���                     
	paramsIn.add(favcond_coder_code);      //�Ż�˳��                     
	paramsIn.add(condetion_coder);         //�Ż�����˳��                 
	paramsIn.add(favcond_type);            //�Ż���������                 
	paramsIn.add(favour_condition);        //�Ż�����                     
	paramsIn.add(cond_attr);               //��������                     
	paramsIn.add(relation_expr);           //��ϵ���ʽ                   
	paramsIn.add(condition_step);          //������ֵ                     
	paramsIn.add(local_expr);              //���������Ż�����(������ϵ)
	paramsIn.add(first_favour_object);      //һ����Ŀ��                     
	paramsIn.add(second_favour_object);     //������Ŀ��
	
	acceptList = impl.callService("s5238_TotConCfm",paramsIn,"2");
	errCode=impl.getErrCode();   
	errMsg=impl.getErrMsg();
	
	if(errCode != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
        	window.opener.form1.favcond_coder_code.focus();
	        window.close();
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
        	window.opener.middle.location="f5238_opTotCodeFrame.jsp?login_accept=<%=login_accept%>&region_code=<%=region_code%>&total_code=<%=total_code%>";
			window.close();
        </script>
<%
	}
%>

