<%
   /*
   * ����: ���˲�Ʒ�ۺ���Ϣ��ѯ
�� * �汾: v1.0
�� * ����: 2007/03/29
�� * ����: hexy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
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
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               	//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  	= pass[0][0];                     //��½����
	String regionCode=org_code.substring(0,2);
	
	int errCode=0;
  String errMsg="";
  
  //��ѯ��ʾ��Ϣ
  String[][] result_value = new String[][]{};
	String[][] result_value0 = new String[][]{};
	String[][] result_value1 = new String[][]{};
	String[][] result_value2 = new String[][]{};
	String[][] result_value3 = new String[][]{};
	String[][] result_value4 = new String[][]{};
	String[][] result_value5 = new String[][]{};
	String[][] result_value6 = new String[][]{};
	String[][] result_value7 = new String[][]{};
	String[][] result_value8 = new String[][]{};
	String[][] result_value9 = new String[][]{};
	String[][] result_value10 = new String[][]{};
	String[][] result_value11 = new String[][]{};
	String[][] result_value12 = new String[][]{};
	String[][] result_value13 = new String[][]{};
	String[][] result_value14 = new String[][]{};
	String[][] result_value15 = new String[][]{};
	String[][] result_value16 = new String[][]{};
	String[][] result_value17 = new String[][]{};
	String[][] result_value18 = new String[][]{};
	String[][] result_value19 = new String[][]{};
	String[][] result_value20 = new String[][]{};
	String[][] result_value21 = new String[][]{};
	String[][] result_value22 = new String[][]{};
	String[][] result_value23 = new String[][]{};
	String[][] result_value24 = new String[][]{};
	String[][] result_value25 = new String[][]{};
	String[][] result_value26 = new String[][]{};
	String[][] result_value27 = new String[][]{};
	String[][] result_value28 = new String[][]{};
	String[][] result_value29 = new String[][]{};
	String[][] result_value30 = new String[][]{};
	
  //��ȡ����ҳ�õ�����Ϣ
  String region_code =  request.getParameter("region_code");
	String product_code = request.getParameter("product_code");
	String option_type  = request.getParameter("option_type");
		
  String server_code  = "619";
	String return_num		=	"5";
	int circle_number=Integer.parseInt(return_num);

  
	//��ȡ���е���ʾ��Ϣ
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
  
	ArrayList acceptList = new ArrayList();
	 	String paramsIn[] = new String[3];
	  paramsIn[0] = server_code;			//������
	  paramsIn[1] = region_code;			//��Ʒ����
	  paramsIn[2] = product_code;				//�������
	  
	  acceptList = impl.callFXService("sDynSqlCfm",paramsIn,return_num);
		errCode=impl.getErrCode();
		errMsg=impl.getErrMsg();
	
	if(errCode != 0)
  {
%>
    <script language='javascript'>
    	rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>");
    </script>
<%}
	else
	{
		result_value	=(String[][])acceptList.get(0);
		
	}
%>
<html>
<head>
<title>�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script>
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle3" action="" method="post" name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      	<table width="100%"  border="0" id="mainFive" align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
	      		<%for(int j=0;j<circle_number;j++){
							result_value0	=(String[][])acceptList.get(j);
						%>
	      			<td align="left" bgcolor="#649ECC" width="90" height="20"><%=result_value0[0][0]%></td>
	      		<%}%>
	      		
						<%for(int i=1;i<result_value.length;i++){%>
						<tr bgcolor="F5F5F5" height="20" >
							<%for(int j=0;j<circle_number;j++){
								result_value0	=(String[][])acceptList.get(j);
							%>
	        			<td align="left" width="90" height="20"><%=result_value0[i][0]%></td>
	        		<%}%>
			    	</tr>
			    	<%}%>
	    </table>
		</td>
  	</tr>
</table>
</form>
</body>
</html>
