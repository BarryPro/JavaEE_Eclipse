<%
   /*
   * ����: ���Ų�Ʒ��ѯ - �б�(ȫ������)
�� * �汾: v1.0
�� * ����: 2006/10/30
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-21    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.DecimalFormat"%>


<%	
  //���Ƹ�ʽ
	DecimalFormat df = new DecimalFormat("#.00");
	//��ȡ�û�session��Ϣ
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));              //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));        //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String[][] result = new String[][]{};
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                    //��½����
	String strHuaboym = "";
	Logger logger = Logger.getLogger("f5079_list4.jsp");
	//�Ǵ�f5079_queryҳ���ѯ����contract_pay
	String QryValues = (String)request.getParameter("turnValue")==null?"":(String)request.getParameter("turnValue");
	String QryFlag = (String)request.getParameter("QryFlag")==null?"":(String)request.getParameter("QryFlag");             /*wuxy add 20090208*/
	String QryValues1 = (String)request.getParameter("QryValues")==null?"":(String)request.getParameter("QryValues");        /*wuxy add 20090208*/
	
	String huaboym = (String)request.getParameter("huaboym")==null?"":(String)request.getParameter("huaboym");
	String tongfulb = (String)request.getParameter("tongfulb")==null?"":(String)request.getParameter("tongfulb");
	System.out.println("------------f5079_list4.jsp-----------huaboym="+huaboym);
	System.out.println("------------f5079_list4.jsp-----------tongfulb="+tongfulb);
	//������ʾ������
    if("0".equals(tongfulb)){
        strHuaboym = "��ͳ���ʻ�";
    }else{
        strHuaboym = "��ԱID";
    }
	
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	
	String paraArr[] = new String[8];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "5079";
	paraArr[3] = QryValues;
	paraArr[4] = huaboym;
	paraArr[5] = tongfulb;
	paraArr[6] = QryFlag;
	paraArr[7] = QryValues1;
	
	String errCode = "";
	String errMsg = "";
	try{
    	%>
            <wtc:service name="s5079Query" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="6" >
            	<wtc:param value="<%=paraArr[0]%>"/>
            	<wtc:param value="<%=paraArr[1]%>"/> 
                <wtc:param value="<%=paraArr[2]%>"/> 
                <wtc:param value="<%=paraArr[3]%>"/> 
                <wtc:param value="<%=paraArr[4]%>"/> 
                <wtc:param value="<%=paraArr[5]%>"/> 
                <wtc:param value="<%=paraArr[6]%>"/> 
                <wtc:param value="<%=paraArr[7]%>"/> 
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
        <%
            errCode = retCode1;
            errMsg = retMsg1;
            if("000000".equals(errCode)){
                if(retArr1.length>0){
    	            result = retArr1;
    	        }else{
    	            %>
        	            <script type=text/javascript>
        	                rdShowMessageDialog("û���������!",0);
        	            </script>
        	        <%
    	        }
            }else{
	            %>
    	            <script type=text/javascript>
    	                rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>",0);
    	            </script>
    	        <%
            	System.out.println("# return from f5079_list4.jsp by s5079Query -> retCode = " + errCode);
            	System.out.println("# return from f5079_list4.jsp by s5079Query -> retMsg  = " + errMsg);
	        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("���÷���s5079Queryʧ�ܣ�",0);
            </script>
        <%
        e.printStackTrace();
    }
    
	//acceptList = impl.callFXService("s5079Query",paraArr,"6");
	//int errCode=impl.getErrCode();   
	//String errMsg=impl.getErrMsg(); 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	var oldrow = -1;
	var nowrow = -1;

	//�����ĳ�д�����
	function rowClick(objname,flag){
		var o = eval(objname);
		if(flag == 1)
			o.className = "opened";
		else
			o.className = "unopen";
	}
	
	//����Ƶ�ĳ��
	function rowMouseOver(node){
		if(node.className != "opened")
			node.className = "mouseover";
	}
	
	//����Ƴ�ĳ��
	function rowMouseOut(node){
		if(node.className != "opened")
			node.className = "unopen";
	}
	
	//�����ĳ��
	function trfunc1(node){
		nowrow = parseInt(node.id.substring(3,node.id.length));  
		if(oldrow != nowrow){
			if(oldrow != -1) 
				rowClick("row" + oldrow,0);
			rowClick("row" + nowrow,1);
			oldrow = nowrow;
		}
	}
		function printxlslist(){
			window.open("f5079_print4xls.jsp?turnValue=<%=QryValues%>&QryFlag=<%=QryFlag%>&QryValues=<%=QryValues1%>&huaboym=<%=huaboym%>&tongfulb=<%=tongfulb%>");
	}
	
</script>
</head>

<body>
<div id="Operation_Table">
<table cellspacing="0">
    <tr>
		  <!-- diling add ���ӵ�������� @2012/5/25 -->
			<td colspan="6"><input type="button" name="printxls" class="b_text" value="����ΪXLS���" onclick="printxlslist()"/></td>
		</tr>
    <tr>
        <th>ͳ����ϵ</th>
        <th>ͳ���ʻ�</th>
        <th><%=strHuaboym%></th>
        <th> ��Ա����</th>
        <th>����ʱ��</th>
        <th>���</th>
    </tr>
<%
		if("000000".equals(errCode)){
		/*
			String[][] tmpresult0=(String[][])acceptList.get(0);
			String[][] tmpresult1=(String[][])acceptList.get(1);
			String[][] tmpresult2=(String[][])acceptList.get(2);
			String[][] tmpresult3=(String[][])acceptList.get(3);
			String[][] tmpresult4=(String[][])acceptList.get(4);
			String[][] tmpresult5=(String[][])acceptList.get(5);
		*/
		



		for(int i = 0; i < result.length; i++)
		{	
			String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }

			String stra="";
			if("0".equals(result[i][0])){
				stra="����ͳ��";
			}else{
				stra="ȫ��ͳ��";
			}
%>
		<tr>
			<td class="<%=tdClass%>"><%=result[i][0]%></td>
			<td class="<%=tdClass%>"><%=result[i][1]%></td>
			<td class="<%=tdClass%>"><%=result[i][2]%></td>
			<td class="<%=tdClass%>"><%=result[i][3]%></td>
			<td class="<%=tdClass%>"><%=result[i][4]%></td>		
			<td class="<%=tdClass%>"><%=df.format(Float.parseFloat(result[i][5]))%></td>		
		</tr>
<%
		}
	}	
	else{

}
%>	


</table>
<div>
</body>
</html>


