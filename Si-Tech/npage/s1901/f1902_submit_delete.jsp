<%
   /*
   * ����: ���ź�ͬЭ��¼��-�ύɾ��
�� * �汾: v1.0
�� * ����: 2006/11/05
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>

<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
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
	
	Logger logger = Logger.getLogger("f1902_submit_delete.jsp");
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();	
		
	String agreeId=request.getParameter("agreeId");


 	ArrayList acceptList = new ArrayList();

    String paramsIn[] = new String[6];
    paramsIn[0] = workNo;
	paramsIn[1] = nopass;
	paramsIn[2] = "1902";
	paramsIn[3] = "";
    paramsIn[4] = agreeId;
    paramsIn[5] = ip_Addr;

    int errCode=-1;
    String errMsg="";
	try
	{   
	  	acceptList = impl.callFXService("s1902AgrDel",paramsIn,"2");
		errCode=impl.getErrCode();   
		errMsg=impl.getErrMsg(); 		 
	}
	catch(Exception e)
	{
		e.printStackTrace();
		logger.error("Call s1902AgrMod is Failed!");
	}
	       
	
	if(errCode == 0)
  {
%>
        <script language='javascript'>
        	rdShowMessageDialog("�����ɹ���");
           	history.go(-1);
           	window.location.reload(); 
        </script>
<%}
  else
  {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
	          history.go(-1);
	   	</script>         
<%            
    }
%>
