<%
   /*
   * ����: ������Ϣά��-�޸�
�� * �汾: v1.0
�� * ����: 2006/08/21
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-21    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%	
	//��ȡ�û�session��Ϣ
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));            	//��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                 //��½����
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	Logger logger = Logger.getLogger("f5079_detail.jsp");
	String idNo = request.getParameter("idNo");
	String contractNo = request.getParameter("contractNo");
	
  	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
  	
  	String[][] result = new String[][]{};
 	
 	//��ȡѧУ����
 	ArrayList retList1 = new ArrayList();  
    String[][] retListString1 = new String[][]{};
	String sqlStr1="";
 	sqlStr1 ="select * from sGrpBigSchoolCode";
 	//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
 	%>
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="2">
        	<wtc:sql><%=sqlStr1%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr1" scope="end"/>
    <%
    if("000000".equals(retCode1) && retArr1.length>0){
        retListString1 = retArr1;
    }
 	//String[][] retListString1 = (String[][])retList1.get(0);
 	
 	//��ȡ��ѧרҵ����
 	ArrayList retList2 = new ArrayList();  
 	String[][] retListString2 = new String[][]{};
	String sqlStr2="";
 	sqlStr2 ="select * from sGrpBigMajorCode";
 	//retList2 = impl.sPubSelect("2",sqlStr2,"region",regionCode);
 	%>
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="2">
        	<wtc:sql><%=sqlStr2%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr2" scope="end"/>
    <%
    if("000000".equals(retCode2) && retArr2.length>0){
        retListString2 = retArr2;
    }
 	//String[][] retListString2 = (String[][])retList2.get(0);
 	
 	//��ȡ���ѧλ����
 	ArrayList retList3 = new ArrayList();  
 	String[][] retListString3 = new String[][]{};
	String sqlStr3="";
 	sqlStr3 ="select * from sGrpBigEduCode";
 	//retList3 = impl.sPubSelect("2",sqlStr3,"region",regionCode);
 	%>
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3"  outnum="2">
        	<wtc:sql><%=sqlStr3%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr3" scope="end"/>
    <%
    if("000000".equals(retCode3) && retArr3.length>0){
        retListString3 = retArr3;
    }
 	//String[][] retListString3 = (String[][])retList3.get(0);
 	
  	
	ArrayList acceptList = new ArrayList();	
	/*String sqlStr= "SELECT a.contract_no,a.bill_order,a.pay_order,b.fee_name,c.detail_name,a.fee_rate "
									+"FROM dConuserRate a,sFeeCode b,sFeeCodeDetail c "
									+"WHERE a.fee_code = b.fee_code AND c.detail_code = a.detail_code AND a.id_no = '"+idNo+"' "
									+"and a.contract_no='"+contractNo+"'";	*/
	/*wuxy alter 20090209 */
	String sqlStr= "SELECT a.contract_no,a.bill_order,a.pay_order,b.fee_name,c.detail_name,a.fee_rate "
									+"FROM dConuserRate a,dconusermsg d,sFeeCode b,sFeeCodeDetail c "
									+"WHERE a.fee_code = b.fee_code AND c.detail_code = a.detail_code and d.id_no=a.id_no and a.contract_no=d.contract_no "
									+" and a.bill_order=d.bill_order and d.end_YMD||d.end_tm>=to_char(sysdate,'yyyymmddhh24miss') AND a.id_no = :idNo "
									+"and a.contract_no=:contractNo ";
	
	String [] paraIn1 = new String[2];
	paraIn1[0]=sqlStr;
	paraIn1[1]="idNo="+idNo+",contractNo="+contractNo;
										
	System.out.println("sqlStr:"+sqlStr);
			
	//acceptList = impl.sPubSelect("6",sqlStr,"region",regionCode);
	//int errCode=impl.getErrCode();   
	//String errMsg=impl.getErrMsg(); 
	String errCode = "";
	String errMsg = "";
	try{
	    %>           
             <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4"  outnum="6">
			<wtc:param value="<%=paraIn1[0]%>"/>
 			<wtc:param value="<%=paraIn1[1]%>"/>
 			</wtc:service>
			<wtc:array id="retArr4" scope="end"/>
        <%
        errCode = retCode4;
        errMsg = retMsg4;
        if("000000".equals(retCode4) && retArr4.length>0){
            result = retArr4;
        }
	}catch(Exception e){
	    e.printStackTrace();
	}
	
	if(!"000000".equals(errCode))
	{
%>
		<script language="javascript" >
			rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>",0);
			window.close();
		</script>
<%
	}
	else
	{

		                                                              
%>                                                                    
                                                                      
<html xmlns="http://www.w3.org/1999/xhtml">                                                              
<head>                                                                
<base target="_self">                                                 
<title>���ѹ�ϵ��ϸ</title>                                           
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">  
</head>                                                            
<body>
<div id="Operation_Table">
				<form name="form1"  method="post">
                                        
		<table cellspacing="0">
			<tr>
				<th>�ʻ���</th> 
				<th>�ʵ�˳��</th>
				<th>����˳��</th> 
				<th>һ����������</th> 
				<th>������������</th>
				<th>�ʷѷ���</th>
			</tr>
<%
			//String[][] tmpresult0=(String[][])acceptList.get(0);


		for(int i = 0; i < result.length; i++)
		{	
			
			String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }
%>
            <tr>
                <td class="<%=tdClass%>"><%=result[i][0]%></td>
                <td class="<%=tdClass%>"><%=result[i][1]%></td>
                <td class="<%=tdClass%>"><%=result[i][2]%></td>
                <td class="<%=tdClass%>"><%=result[i][3]%></td>
                <td class="<%=tdClass%>"><%=result[i][4]%></td>
                <td class="<%=tdClass%>"><%=result[i][5]%></td>
            </tr>
<%
		}
%>
		</table>
    	<TABLE cellSpacing=0>
			<TR id="footer">
		      	<TD> 
		         	<!--input name="queryButton" type="button" class="button" value="�ύ" onClick="if (check(form1)) modSubmit()"-->
		         	<input name="addButton" type="button" class="b_foot" value="�ر�" onClick="window.close()" >
				</TD>
		    </TR>
   	 	</TABLE>
</div>
</form>
</body>
</html>

<%

}

%>	