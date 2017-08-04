<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.GregorianCalendar"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%	
	//��ȡ�û�session��Ϣ
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));               //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                   //��½����
	
	String opCode = "5082";
	String opName = "������Ϣ��ѯ";
	
	Logger logger = Logger.getLogger("f5082_4.jsp");
	
	String id_no = request.getParameter("id_no");
	String id_iccid = request.getParameter("id_iccid");
	String unit_id = request.getParameter("unit_id");
	String unit_name = request.getParameter("unit_name");

	String strDate = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	System.out.println(sdf);
	GregorianCalendar cal = new GregorianCalendar();
	cal.setTime(new Date());
	
	strDate = sdf.format(cal.getTime());
	
	cal.add(GregorianCalendar.MONTH, 1);
	strDate = sdf.format(cal.getTime());
	System.out.println(strDate);
	strDate = strDate.substring(0,6)+"01";
	System.out.println(strDate);
	
	String[][] result = new String[][]{};
		
	String sql = "select to_char(cust_id) from dcustdocorgadd where unit_id =to_number('"+unit_id+"')"; 
	System.out.println("sql="+sql);
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=unit_id%>" outnum="1">
    <wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	String paraArr[] = new String[3];
	paraArr[0] = id_no;
	paraArr[1] = workNo;
	paraArr[2] = result1[0][0];
	
	
	
	
	//acceptList = impl.callFXService("s3518QryID",paraArr,"13");
	//int errCode=impl.getErrCode();   
	//String errMsg=impl.getErrMsg(); 
	String errCode = "";
	String errMsg = "";
	try{
	%>
    	<wtc:service name="s3518QryIDEXC"  outnum="16" retcode="retCode1" retmsg="retMsg1" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=paraArr[0]%>" />
        	<wtc:param value="<%=paraArr[1]%>" />
        	<wtc:param value="<%=paraArr[2]%>" />
    	</wtc:service>
    	<wtc:array id="retArr1" scope="end"/>
    <%
	    errCode = retCode1;
	    errMsg = retMsg1;
	
	    if("000000".equals(errCode) && retArr1.length>0){
	        result = retArr1;
	    }else{
    %>
		<script language="javascript" >
			rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
    <%
        }
	}catch(Exception e){
	    e.printStackTrace();
	    %>
		<script language="javascript" >
			rdShowMessageDialog("���÷���s3518QryIDʧ�ܣ�",0);
			history.go(-1);
		</script>
    <%
	}
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
			String[][] tmpresult11=(String[][])acceptList.get(11);
			String[][] tmpresult12=(String[][])acceptList.get(12);
			*/
	
%>


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
</script>
</head> 
<BODY>
<FORM method="post" name="form1" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ϣ��ѯ-��Ʒ���</div>
</div>

<table cellspacing=0>
  <tr> 
    <td class='blue' nowrap> 
		���ű��
    </td>
    <td> 
		<input type="text" name="unit_id" value="<%=unit_id.trim()%>" readonly class='InputGrey' />
    </td>
    <td class='blue' nowrap>
		��������
    </td>
    <td> 
		<input type="text" name="unit_name" value="<%=unit_name.trim()%>" readonly class='InputGrey' />
    </td>
  </tr>  
</table>
        
<table cellspacing="0" id=contentList>
    <tr>
    	<th>�����û�ID</th>
    	<th>��Ʒ����</th>
    	<th>��Ʒ����</th>
    	<th>�����Ϣ����</th>
    	<th>��ۺ�ļ۸�</th>
    	<th>��ʼʱ��</th>				
    	<th>����ʱ��</th>
    </tr>
<%
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
				<td class="<%=tdClass%>"><%=result[i][12]%></td>
				<td class="<%=tdClass%>"><%=result[i][13]%><%if("1".equals(result[i][14])){out.print("����ߴ�"+result[i][15]+"��");}%></td>			
				<td class="<%=tdClass%>"><%=result[i][8]%></td>
				<td class="<%=tdClass%>"><%=result[i][9]%></td>
				<input type="hidden" name="priceCode" value="">
				<input type="hidden" name="loginAccept" value="">
				<input type="hidden" id="hiddenBeginTime" name="hiddenBeginTime" value="">
				<input type="hidden" id="hiddenEndTime" name="hiddenEndTime" value="">
		</tr>
<%
		}
	}	
%>	
		 </table>
	
		<table cellspacing=0>
          <tr id="footer"> 
            <td colspan="4"> 
                <input name="back" type="button" class="button" value="����" onClick="history.go(-1)">
                <input name="close" onClick="removeCurrentTab()" type="button" class="button" value="�ر�">
            </td>
          </tr> 
        </table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

