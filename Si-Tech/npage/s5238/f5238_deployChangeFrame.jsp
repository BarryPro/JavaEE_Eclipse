<% 
  /*
   * ����: ��ʾ��Ʒ�������������Ϣ
�� * �汾: v1.00
�� * ����: 2007/01/17
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
 ��*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//��ȡ�û�session��Ϣ
	System.out.println("--------------------page-------------f5238_deployChangeFrame.jsp----------------------");
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               	//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//��½����
	String regionCode=org_code.substring(0,2);
	
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");	
	String mode_name = request.getParameter("mode_name");
	String mode_code = request.getParameter("mode_code");
	String aold_mode_array = request.getParameter("old_mode_array");
	String anew_mode_array = request.getParameter("new_mode_array");
	String amode_flag_array = request.getParameter("mode_flag_array");
	String region_code = request.getParameter("region_code");
	String trans_type = request.getParameter("trans_type");
	System.out.println("QQQQQQQQ"+anew_mode_array);
	
	int errCode=0;
    String errMsg="";
	
%>
<html>
<head>
<title>�ޱ����ĵ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script>
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle" action="" method="post" name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      		<table width="100%"  border="0" id="mainThree" align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
      		  	<%
			
				SPubCallSvrImpl callView = new SPubCallSvrImpl();
				ArrayList retArray = new ArrayList();
				String[] paramsIn=new String[7];
				paramsIn[0]=workNo;
				paramsIn[1]=nopass;
				paramsIn[2]="5238";
				paramsIn[3]=login_accept;
				paramsIn[4]=mode_code;
				paramsIn[5]=mode_name;
				paramsIn[6]=region_code;
				
				retArray=callView.callFXService("s5238_BBChgQry",paramsIn,"7");	
				callView.printRetValue();
				errCode = callView.getErrCode();
				errMsg = callView.getErrMsg();
				if(errCode==0)
				{
					String[][]old_code=(String[][])retArray.get(0);
					String[][]old_name=(String[][])retArray.get(1);
					String[][]relation_type=(String[][])retArray.get(2);
					String[][]new_code=(String[][])retArray.get(3);
					String[][]new_name=(String[][])retArray.get(4);
					String[][]send_flag=(String[][])retArray.get(5);
					String[][]power_right=(String[][])retArray.get(6);
	
					for(int i=0;i<old_code.length;i++)
					{
				%> 
					<tr bgcolor="F5F5F5" height="20" >
                		<td align="center" width="70" height="20"><%=old_code[i][0]%></td>
                		<td align="center" width="200" height="20"><%=old_name[i][0]%></td>
                		<td align="center" width="74" height="20">->></td>
                		<td align="center" width="73" height="20"><%=new_code[i][0]%></td>
                		<td align="center" width="201" height="20"><%=new_name[i][0]%></td>
                		<td align="center" width="56" height="20"><%=send_flag[i][0]%></td>
						<td align="center" width="56" height="20"><%=power_right[i][0]%></td>
			    	</tr>
			    	<%
					}	
				}
				else
				{	
				%>        
					<script language="javascript">
						rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>");
					</script>       
				<%            
				}
			
				%>               	
      		</table>
		</td>
  	</tr>
</table>
</form>	
</body>
</html>  
