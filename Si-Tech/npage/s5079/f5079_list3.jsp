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
	//��ȡ�û�session��Ϣ
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                    //��½����
	
	Logger logger = Logger.getLogger("f5079_list3.jsp");
	String sqlStr2="";                                             //wuxy add 20090209
	ArrayList retList2 = new ArrayList();                          //wuxy add 20090209
	String[][] result2 = new String[][]{};                         //wuxy add 20090209
	DecimalFormat df = new DecimalFormat("#0.00");                 //wuxy add 20090209

    String[][] result = new String[][]{};

	String QryValues = request.getParameter("turnValue");
	String QryFlag = request.getParameter("QryFlag");             /*wuxy add 20090208*/
	String QryValues1 = request.getParameter("QryValues");        /*wuxy add 20090208*/
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	
	sqlStr2=" select nvl(sum(prepay_fee),0) from dconmsgpre where contract_no=:QryValues and begin_dt<=to_char(sysdate,'yyyymmdd') "+
	           " and end_dt>=to_char(sysdate,'yyyymmdd') ";
	String [] paraIn1 = new String[2];
	paraIn1[0]=sqlStr2;
	paraIn1[1]="QryValues="+QryValues;
	           
	try
    {
	  	//retList2=impl.sPubSelect("1",sqlStr2, "region", regionCode);
	  	%>
             <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="1">
			<wtc:param value="<%=paraIn1[0]%>"/>
 			<wtc:param value="<%=paraIn1[1]%>"/>
 			</wtc:service>
			<wtc:array id="retArr2" scope="end"/>
        <%
        if("000000".equals(retCode2) && retArr2.length>0){
            result2 = retArr2;
        }
    }catch(Exception e)	
    {
        System.out.println("\n==================\n error1");
        e.printStackTrace();
    }
	

	//wuxy alter 20090208 �������Ա�����ѯ����Ҫ�ഫ��һ����Ա����ֵ
	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "5079";
	if(QryFlag.equals("4"))
	{
		paraArr[3] =QryValues1;
    }
    else
    {  	
		paraArr[3] = "";
	}
	paraArr[4] = QryValues;
	
	//acceptList = impl.callFXService("s5079GrpR",paraArr,"11"); /*�����ࡡ�޸Ķ�ȡһ��ֵ����ǰΪ������20090208*/
	//int errCode=impl.getErrCode();   
	//String errMsg=impl.getErrMsg(); 
	
	String errCode = "";
	String errMsg = "";
	try{
    	%>
            <wtc:service name="s5079GrpR" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
            	<wtc:param value="<%=paraArr[0]%>"/>
            	<wtc:param value="<%=paraArr[1]%>"/> 
                <wtc:param value="<%=paraArr[2]%>"/> 
                <wtc:param value="<%=paraArr[3]%>"/> 
                <wtc:param value="<%=paraArr[4]%>"/> 
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
            	System.out.println("# return from f5079_list3.jsp by s5079GrpR -> retCode = " + errCode);
            	System.out.println("# return from f5079_list3.jsp by s5079GrpR -> retMsg  = " + errMsg);
	        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("���÷���s5079GrpRʧ�ܣ�",0);
            </script>
        <%
        e.printStackTrace();
    }
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
	
//-------��ʾ��ϸҳ��--------
function showModify(idNo,feeType,contractNo)
{ 
	if(feeType=="N")
	{
		rdShowMessageDialog("���ʺ�û���ʷ���ϸ��");
		return;
	}
	var url = "f5079_detail.jsp?idNo=" + idNo + "&contractNo="+contractNo;
	window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
}	
	function printxlslist(){
			window.open("f5079_print3xls.jsp?turnValue=<%=QryValues%>&QryFlag=<%=QryFlag%>&QryValues=<%=QryValues1%>");
	}
</script>
</head>

<body>
<div id="Operation_Table">
		<table cellspacing="0">
			<tr>
			<!-- wuxy add 20090209 չʾͳ���˻���� -->
				<td class='blue' nowrap>�����˻����</td>
				<td><%=df.format(Float.parseFloat(result2.length < 1?"0":result2[0][0]))%> Ԫ  </td>
				<td colspan="5"><input type="button" name="printxls" class="b_text" value="����ΪXLS���" onclick="printxlslist()"/></td>
			</tr>
			<tr>
				<th>�绰����</th> 
				<th>�û�ID</th> 
				<th>�����ʻ�</th> 
				<th>�ʵ�˳��</th>
				<th>��ʼ������</th>
				<th>����������</th>
				<th>�ʵ��޶�</th>
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
			String[][] tmpresult6=(String[][])acceptList.get(6);
			String[][] tmpresult7=(String[][])acceptList.get(7);
			String[][] tmpresult8=(String[][])acceptList.get(8);
			String[][] tmpresult9=(String[][])acceptList.get(9);
			String[][] tmpresult10=(String[][])acceptList.get(10);
			*/


//			out.println(tmpresult0.length);

		for(int i = 0; i < result.length; i++)
		{	
			
			String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }
%>
        <tr>
				<td class="<%=tdClass%>"><a href="javascript:showModify('<%=result[i][0].trim()%>','<%=result[i][10]%>','<%=result[i][1]%>')"><%=result[i][2]%></a></td>
				<td class="<%=tdClass%>"><%=result[i][0]%></td>
				<td class="<%=tdClass%>"><%=result[i][1]%></td>
			    <td class="<%=tdClass%>"><%=result[i][3]%></td>
				<td class="<%=tdClass%>"><%=result[i][4]%></td>
			    <td class="<%=tdClass%>"><%=result[i][6]%></td>
			    <td class="<%=tdClass%>"><%=result[i][8]%></td>
		</tr>
<%
		}
	}	
	else{

}
%>	
		</table>
</div>
</body>
</html>

