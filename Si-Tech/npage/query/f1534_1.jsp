<%
/********************
 version v2.0
�����̣� si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

 <%
	String opName = "�ۺ���Ϣ��ѯ֮�û������ʷ��Żݲ�ѯ";
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String phoneNo = request.getParameter("phoneNo");
	String opCode  =request.getParameter("opCode");
	String yearMonth = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());

	String inParas[] = new String[1];
	inParas[0] = phoneNo;

	//int[] lens={10,6};
	//CallRemoteResultValue value=  viewBean.callService("0",null,"sFavTypeQry","16",lens, inParas,map); 
%>
	<wtc:service name="sFavTypeQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="17" >
	<wtc:param value="<%=phoneNo%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="10" scope="end"/>
<% 
    //System.out.println("�û������ʷ��Żݲ�ѯ��Ϣ"+result.length);
	if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("��ѯ���Ϊ��,�û������ʷ��Żݲ�ѯ��Ϣ������!");
	</script>
<%
	   return;
	}else{
	
	String return_code = result[0][0];
	System.out.println("return_code==="+retCode1);
	if (retCode1.equals("0"))
	{
		String idNo  = result[0][1];   
		String region_code   = result[0][2];  
		String modeCode=result[0][3];  
		String rateCode   =result[0][4];  
		String favType   =result[0][5]; 
		System.out.println("favType="+favType);
		double favCall = 0.00 ;
		if(favType.equals("")){	
		}else{
			favCall = (Double.parseDouble(result[0][6].trim()))/100;
		}
	  /*double favCall = (Double.parseDouble(result[0][6].trim()))/100;*/
		String fav_char  =result[0][7];  
		String tmpSwap  =result[0][8];
		String chSpecFund  =result[0][9];

		if(favType.equals("2"))
		{

			String [] inParas2 = new String[5];
	
			inParas2[0] = phoneNo;
			inParas2[1] = idNo;
			inParas2[2] = result[0][6];
			inParas2[3] = "";
			inParas2[4] = yearMonth;

			//String[] ret = impl.callService("sDxFavQry",inParas2,"10");
%>
			<wtc:service name="sDxFavQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="11" >
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
			<wtc:param value="<%=inParas2[4]%>"/>
			</wtc:service>
			<wtc:array id="ret" scope="end"/>
<%
			String retCode="999999";
			if(ret!=null&&ret.length>0){
				retCode = ret[0][0];
			}

			if (ret != null && retCode.equals("000000"))
			{ 
				double  actualFee = (Double.parseDouble(ret[0][1].trim()))/100;
				double  unBill = (Double.parseDouble(ret[0][2].trim()))/100;
				double dxLeft = (Double.parseDouble(ret[0][3].trim()))/100;
				double dx_sum = unBill+dxLeft;
				String total_fav_time = ret[0][4];
				String favoured_time = ret[0][5];
				String favour_left_time = ret[0][6];
				String total_fav_msg = ret[0][7];
				String favoured_msg = ret[0][8];
				String favour_left_msg = ret[0][9];		
%>

<HTML>
<HEAD>
<title>������BOSS-�û������ʷ��Żݲ�ѯ</title>
</head>
<BODY>
<FORM action="" method="post" name="frm" >
					<%@ include file="/npage/include/header.jsp" %>     	
					<div class="title">
						<div id="title_zi">�û������ʷ��Żݲ�ѯ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����:<%=org_code%></div>
					</div>

          <table cellspacing="0">
            <tr> 
              <td class="blue">�ֻ�����</td>
              <td class="blue">  
                <input type="text" name="phoneNo"  readonly class="InputGrey" value="<%=phoneNo%>" >
              </td>
		  				<td class="blue">δ���ʻ���</td>
              <td colspan="3"> 
                <input type="text" class="InputGrey" readonly name="actualFee" value="<%=actualFee%> Ԫ">
              </td>
            </tr>
						<tr> 
              <td class="blue">�����ܶ�</td>
              <td>  
                <input type="text" name="dx_sum"  readonly class="InputGrey" value="<%=dx_sum%> Ԫ" >
              </td>
		  				<td class="blue">����������</td>
              <td> 
                <input type="text" class="InputGrey" readonly name="unBill" value="<%=unBill%> Ԫ">
              </td>
							<td class="blue">����ʣ��</td>
             	<td>
								<input type="text" class="InputGrey" readonly name="dxLeft" value="<%=dxLeft%> Ԫ">
             </td> 
            </tr>
           	<tr> 
              <td class="blue">ʱ��Ӧ�Ż�</td>
              <td>  
                <input type="text" name="total_fav_time"  readonly class="InputGrey" value="<%=total_fav_time%> ����" >
              </td>
		  				<td class="blue">ʱ�����Ż�</td>
              <td> 
                <input type="text" class="InputGrey" readonly name="favoured_time" value="<%=favoured_time%> ����">
              </td>
							<td class="blue">ʱ���Ż�ʣ��</td>
             <td>
								<input type="text" class="InputGrey" readonly name="favour_left_time" value="<%=favour_left_msg%> ����">
             </td> 
            </tr>
            <tr> 
              <td class="blue">����Ӧ�Ż�</td>
              <td>  
                <input type="text" name="total_fav_msg"  readonly class="InputGrey" value="<%=total_fav_msg%> ��" >
              </td>
		  				<td class="blue">�������Ż�</td>
              <td> 
                <input type="text" class="InputGrey" readonly name="favoured_msg" value="<%=favoured_msg%> ��">
              </td>
							<td class="blue">�����Ż�ʣ��</td>
             <td>
								<input type="text" class="InputGrey" readonly name="favour_left_msg" value="<%=favour_left_msg%> ��">
             </td> 
            </tr>
            
						<tr> 
		          <td colspan='6' id="footer">
		              <input type="b_foot" name="return1" class="InputGrey" value="����" onClick="window.history.go(-1)">&nbsp; 
		              <input type="b_foot" name="close1" class="InputGrey" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
		          </td>
		        </tr>
				</table>
			</FORM>
		</body>
	</html>
		<%} else { %>
			<script language="JavaScript">
				rdShowMessageDialog("��ѯ�û������ʷ��Ż���Ϣ����",0);
				window.history.go(-1);
			</script>
		<% } 
	}else{%>
		<script language="JavaScript">
			rdShowMessageDialog("�û��ǵ����ʷѻ�δ����!");
			window.history.go(-1);
		</script>
	<%}
}else{%>
	<script language="JavaScript">
		rdShowMessageDialog("��ѯ�û��������ʹ���",0);
		window.history.go(-1);
	</script>
<%}

}%>

