<%
   /*
   * ����: �ύ�ʵ��Ż���������
�� * �汾: v1.0
�� * ����: 2007/01/24
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
	String typeButtonNum = request.getParameter("typeButtonNum");
	String login_accept = request.getParameter("login_accept");
	String region_code  = request.getParameter("region_code");
	String total_code   = request.getParameter("detail_code");   
	String order_code   = request.getParameter("order_code");
	String favour_object= request.getParameter("favour_object");
	String favour_type  = request.getParameter("favour_type");
	String type_mode    = request.getParameter("type_mode");
	String favour_cycle = request.getParameter("favour_cycle");
	String cycle_unit   = request.getParameter("cycle_unit");
	String step_val1    = request.getParameter("step_val1");
	String favour1      = request.getParameter("favour1");
	String step_val2    = request.getParameter("step_val2");
	String favour2      = request.getParameter("favour2");
	String step_val3    = request.getParameter("step_val3");
	String favour3      = request.getParameter("favour3");
	String code_name    = request.getParameter("note");
	String time_flag    = "1";
	String begin_time   = "20050101";
	String end_time     = "20500101";                                          
	String first_favour_object = request.getParameter("first_favour_object")==null?"":request.getParameter("first_favour_object");
	String second_favour_object = request.getParameter("second_favour_object")==null?"":request.getParameter("second_favour_object");
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[] acceptList = null;
		
	ArrayList paramsIn = new ArrayList(24);
	paramsIn.add(workNo);
	paramsIn.add(nopass);
	paramsIn.add("5238");
	paramsIn.add(login_accept);            //��ˮ                         
	paramsIn.add(region_code);             //��������                         
	paramsIn.add(total_code);             //�Żݴ���                     
	paramsIn.add(order_code);             //�Ż�˳��    
	paramsIn.add(favour_object);          //�Żݵ���Ŀ��
	paramsIn.add(favour_type);            //�Żݷ�ʽ    
	paramsIn.add(type_mode);              //�ͷѷ�ʽ    
	paramsIn.add(favour_cycle);           //�Ż�����    
	paramsIn.add(cycle_unit);             //���ڵ�λ    
	paramsIn.add(step_val1);                           
	paramsIn.add(favour1);                             
	paramsIn.add(step_val2);                           
	paramsIn.add(favour2);                             
	paramsIn.add(step_val3);                           
	paramsIn.add(favour3);                             
	paramsIn.add(code_name);               //�Ż�����    
	paramsIn.add(time_flag);                           
	paramsIn.add(begin_time);              //��ʼʱ��    
	paramsIn.add(end_time);                //����ʱ��    
	paramsIn.add(first_favour_object);     //һ����Ŀ��  
	paramsIn.add(second_favour_object);    //������Ŀ��  
	     	
	acceptList = impl.callService("s5238_TotCfm",paramsIn,"2");
	errCode=impl.getErrCode();   
	errMsg=impl.getErrMsg();
	
	if(errCode != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;
        	window.opener.form1.typeButton<%=typeButtonNum%>.value="������";
			window.close();
        </script>
<%
	}
%>

