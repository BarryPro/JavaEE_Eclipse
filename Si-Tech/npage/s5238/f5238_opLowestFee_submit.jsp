<%
   /*
   * ����: �ύ���߰���������
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
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
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
	String total_code = request.getParameter("total_code");
	String tot_order = request.getParameter("tot_order");
	String new_feeCode = request.getParameter("new_feeCode");
	String new_detCode = request.getParameter("new_detCode");


    PrdMgrSql ProductExcludeSql=new PrdMgrSql();
	String sqlStr = "",sqlStr2="";
	List sqlList=new ArrayList();

	sqlStr2="delete from tMidLowestFeeCode where login_accept="+login_accept+" and region_code='"+region_code+"' and total_code='"+total_code+"' and tot_order="+tot_order;

	sqlStr = "insert into tMidLowestFeeCode (LOGIN_ACCEPT, REGION_CODE, total_code, tot_order, favour_object,new_feeCode,new_detCode) values("+login_accept+
	       ",'"+region_code+"'"+ 
		   ",'"+total_code+"'"+
		   ",'"+tot_order+"'"+
		   ",'"+"*"+"'"+
		   ",'"+new_feeCode+"'"+
		   ",'"+new_detCode+"'"+
		   ")";
    sqlList.add(sqlStr2);
    sqlList.add(sqlStr);
    
	errCode = ProductExcludeSql.updateTrsaction(sqlList);
	
	if(errCode == 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "����ʧ��" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
	        rdShowMessageDialog("�ύ�ɹ�!");
			window.close();
        </script>
<%
	}
%>

