<% 
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String work_no = (String)session.getAttribute("workNo");
	
	String opCode = "5186";
    String opName = "�Ż���Ϣ��ѯ";
	String year_month = request.getParameter("yearmonth");
	String open_time  ="";
	String cust_name  ="";
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	//String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String  dateStr= year_month;

	String totalFav = "��";
	String usedFav = "��";
	String totalCmwap = "��";
	String usedCmwap = "��";
	String totalMessFav = "��";
	String usedMessFav = "��";
	String totalGprsFav = "��";
	String usedGprsFav = "��";
	String otherGprsFav ="��";
    String partGprsFav ="��";
	String partUsedGprsFav ="��";
	String sqlStr = "";
	String[] inParas = new String[2];
	inParas[0]="select substr(a.open_time,1,8),b.cust_name from dcustmsg a,dcustdoc b where a.cust_id=b.cust_id and a.phone_no =:phoneNo";
	inParas[1]="phoneNo="+phoneNo;
	 
	
	String  inputParsm [] = new String[2];
	inputParsm[0] = phoneNo;
	inputParsm[1] = dateStr;
	//xl add ������ ����"�ײ����� Ӧ�Ż� ���Ż�"����Ϣ
	int rownum0=0;
	
	//String [] cussidArr=co.callService("sGetUserFavMsg",inputParsm,"6","phone",phoneNo);
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" id="seq"/>
<%
	String sysAccept = seq;
 
	//NPS
	String url_crm="/npage/s1300/s_contact_crm.jsp?opCode=5186"+"&s_login_accept="+sysAccept+"&s_phone_no="+phoneNo;
%>
	<jsp:include page="<%=url_crm%>" flush="true" />
	
 
	<wtc:service name="sGetUserFavMsgN" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=dateStr%>"/>
	</wtc:service>   
	<wtc:array id="cussidArr" scope="end"/>
<%
		if(cussidArr!=null&&cussidArr.length>0)
	{
		totalFav = cussidArr[0][0];
		usedFav = cussidArr[0][1];
		totalMessFav = cussidArr[0][2];
		usedMessFav = cussidArr[0][3];
		totalCmwap =  cussidArr[0][6];
		usedCmwap  =  cussidArr[0][7];
	}
	
	/*ȡGRPS�Ż���Ϣ*/
	String  inputParsm1 [] = new String[5];
	inputParsm1[0] = work_no;
	inputParsm1[1] = nopass;
	inputParsm1[2] = opCode;
	inputParsm1[3] = phoneNo;
	inputParsm1[4] = dateStr;
	
//	String [] cussidArr1=co1.callService("s5186FavMsg",inputParsm1,"3","phone",phoneNo);
%>
<wtc:service name="s5186FavMsg" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="17" >
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
		</wtc:service>
		<wtc:array id="cussidArr1" scope="end" start="0"  length="6"/> 
		<wtc:array id="cussidArr2" scope="end" start="6"  length="6"/>
		<wtc:array id="cussidArr3" scope="end" start="12"  length="3"/>
		<wtc:array id="cussidArr4" scope="end" start="15"  length="1"/>
		<wtc:array id="cussidArr5" scope="end" start="16"  length="1"/>

<!--xl add WLAN ��ѯ-->
<wtc:service name="sWlanFavOpr1" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="17" >
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
</wtc:service>
<wtc:array id="wlanArr1" scope="end" start="0"  length="5"/> 
<wtc:array id="wlanArr2" scope="end" start="5"  length="3"/>
<wtc:array id="wlanArr3" scope="end" start="8"  length="3"/>
<wtc:array id="wlanArr4" scope="end" start="11"  length="3"/>
<wtc:array id="wlanArr5" scope="end" start="14"  length="1"/>
<wtc:array id="wlanArr6" scope="end" start="15"  length="1"/>
<wtc:array id="wlanArr7" scope="end" start="16"  length="1"/>
<%
	if(cussidArr1!=null&&cussidArr1.length>0){
		totalGprsFav = cussidArr1[0][0];
		usedGprsFav = cussidArr1[0][1];
		otherGprsFav = cussidArr1[0][2];
		//partGprsFav = cussidArr1[0][3];//�ֶ�Ӧ�Ż�
		//partUsedGprsFav = cussidArr1[0][4];//�ֶ����Ż�
		rownum0 = cussidArr3.length;
	}
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA cussidArr1.length is "+cussidArr1.length+" and cussidArr3.length is "+cussidArr3.length);
%>
<wtc:service name="TlsPubSelBoss" outnum="2" retmsg="retMsg2" retcode="retCode2" routerKey="phone" routerValue="<%=phoneNo%>">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
</wtc:service>
<wtc:array id="retArray" scope="end"/>
<%
  if(retArray!=null&& retArray.length > 0){
  	open_time = retArray[0][0];
  	cust_name = retArray[0][1];
  	System.out.println("open_time="+open_time);
  	System.out.println("cust_name="+cust_name);
  }
%>
<!--xl add for �����Żݲ�ѯ-->
<wtc:service name="sGetUserFavMsgN" routerKey="phone" routerValue="<%=phoneNo%>" outnum="31" retmsg="retMsgyy" retcode="retCodeyy" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=dateStr%>"/>
</wtc:service>
<wtc:array id="yyArr" scope="end" start="19"  length="3"/>
<wtc:array id="dxArr" scope="end" start="22"  length="3"/>
<wtc:array id="Arr1" scope="end" start="25"  length="5"/>
<wtc:array id="Arr_flag" scope="end" start="30"  length="1"/>
<%
	String yy_yh_name="";//�����Ż�����
	String yy_should_yh="";//Ӧ�Ż�
	String yy_yhed="";//���Ż�
	int i_yy_yh_count=0;//�����Żݼ�¼����
	
	String dx_yh_name="";//�����Ż�����
	String dx_should_yh="";//����Ӧ�Ż�
	String dx_yhed="";//�������Ż�
	int i_dx_yh_count=0;//���ż�¼����
	if(yyArr!=null&&yyArr.length>0)
	{
		i_yy_yh_count = yyArr.length;
	}
	if(dxArr!=null&&dxArr.length>0)
	{
		i_dx_yh_count = dxArr.length;
	}
%>
<!--xl end of �����Ż�-->
<HTML>
	<HEAD>
	<title>�Ż���Ϣ��ѯ</title>
	</HEAD>
<BODY>
<FORM method=post name="frm5186">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�Ż���Ϣ��ѯ</div>
		</div>
		<TABLe cellSpacing="0">
	    <TR> 
	    	<td class="blue">�������</TD>
          <td>
          	<input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value=<%=phoneNo%>
          </td>
          <td class="blue">��ѯ����</td>
   
		  <td class="blue"><%=dateStr%></td>
           <input type="hidden" readonly class="InputGrey" name="nopass" size="20" maxlength="11" value=<%=nopass%>
          </td>
          </TR>
		    <TR>
		      	<td class="blue">�ͻ�����</TD>
		       	<TD><input class="InputGrey" name="cust_name" value="<%=cust_name%>" maxlength="25" size=20 readonly></TD>
		      	<td class="blue">����ʱ��</TD>
		      	<TD><input class="InputGrey" name="open_time" value="<%=open_time%>" maxlength="25" size=20 readonly></TD>
		    </TR>
			<tr>
				<td class="blue" colspan=4> </td>
			</tr>
			<tr>
				<td class="blue">���ӵ绰Ӧ�Żݷ�����</TD>
		    	<TD><input class="InputGrey" name="totalCmwap" value="<%=totalCmwap%>" maxlength="25" size=20 readonly></TD>
		   		<td class="blue">���ӵ绰���Żݷ�����</TD>
				<TD><input class="InputGrey" value="<%=usedCmwap%>" maxlength="25" size=20 readonly></TD>
			</tr>
			<tr>
				<td class="blue" colspan=4> </td>
			</tr>
			<tr>
				<td class="blue" colspan=4>�ײ���Ӧ�Ż�GPRS����:<input class="InputGrey" value="<%=totalGprsFav%>" maxlength="25" size=20 readonly>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �ײ���ʣ��GPRS����:<input class="InputGrey" value="<%=usedGprsFav%>" maxlength="25" size=20 readonly> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ײ�����ʹ��GPRS����:<input class="InputGrey" value="<%=otherGprsFav%>" maxlength="25" size=30 readonly></TD>
		    	 		    	
			</tr>
			
		<!--xl add ������-->	
		<tr>
				<td class="blue" colspan=4> </td>
		</tr>
		<%
			for(int i =0;i<rownum0;i++)
			{
					%>
					<tr>
						<td class="blue" colspan=4>
						���ײ�����<%=i+1%>��: <%=cussidArr3[i][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
						Ӧ�Ż�����Ϊ:<%=cussidArr3[i][1]%>,&nbsp;&nbsp;&nbsp;&nbsp;
						ʣ������Ϊ:<%=cussidArr3[i][2]%>;&nbsp;&nbsp;&nbsp;&nbsp;�ʷ����ȼ�:<%=cussidArr5[i][0]%></td>
					</tr>
					<%
			}
		%>
		

		<!--xl end ������-->
	   </table> 
	   <!--xl add �����Ż�-->
	   <div class="title">
			<div id="title_zi">�����Ż���Ϣ��ѯ</div>
	   </div>
	   <TABLe cellSpacing="0">
		<tr>
				<td class="blue"> ��ͨ����Ӧ�Żݷ����� </TD>
		    	<TD><input class="InputGrey" name="totalFav" value="<%=totalFav%>" maxlength="25" size=20 readonly></TD>
		   		<td class="blue"> ��ͨ�������Żݷ����� </TD>
				<TD><input class="InputGrey" value="<%=usedFav%>" maxlength="25" size=20 readonly></TD>
		</tr>
		<%
			for(int m=0;m<i_yy_yh_count;m++)
			{
				%>
					<tr>
						<td class="blue" colspan=4>
						���Ż�����<%=m+1%>��: <%=yyArr[m][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
						Ӧ�Żݷ�����:<%=yyArr[m][1]%>����,&nbsp;&nbsp;&nbsp;&nbsp;
						���Żݷ�����:<%=yyArr[m][2]%>����;�ʷ����ȼ�:<%=Arr_flag[m][0]%></td>
					</tr>
				<%
			}
		%>
	   </table>
	  <!--xl add for �����Ż���Ϣ��ѯ-->
	  <div class="title">
			<div id="title_zi">�����Ż���Ϣ��ѯ</div>
	  </div>
	  <TABLe cellSpacing="0">
		<tr>
				<td class="blue">Ӧ�Żݶ�����</TD>
		    	<TD><input class="InputGrey" value="<%=totalMessFav%>" maxlength="25" size=20 readonly></TD>
		    	<td class="blue">���Żݶ�����</TD>
		    	<TD><input class="InputGrey" value="<%=usedMessFav%>" maxlength="25" size=20 readonly></TD>
		</tr>
		<%
			for(int n=0;n<i_dx_yh_count;n++)
			{
				%>
					<tr>
						<td class="blue" colspan=4>
						���Ż�����<%=n+1%>��: <%=dxArr[n][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
						Ӧ�Żݶ���:<%=dxArr[n][1]%>��,&nbsp;&nbsp;&nbsp;&nbsp;
						���Żݶ���:<%=dxArr[n][2]%>��;�ʷ����ȼ�:<%=Arr_flag[n][0]%></td>
					</tr>
				<%
			}
		%>
	  </table> 
	  <!--xl add wlan��ѯ-->
	  <%
		String wlan_total_minutes="";
		String wlan_fav_minutes="";
		String wlan_out_minutes="";
		int rownum1 =0;

		String wlan_total_kb="";
		String wlan_fav_kb="";
		String wlan_out_kb="";
		int rownum2 =0;

		if(wlanArr1!=null&&wlanArr1.length>0){
			wlan_total_minutes = wlanArr1[0][2];
			wlan_fav_minutes = wlanArr1[0][3];
			wlan_out_minutes = wlanArr1[0][4];
			rownum1= wlanArr2.length;
		}
		if(wlanArr3!=null&&wlanArr3.length>0){
			wlan_total_kb = wlanArr3[0][0];
			wlan_fav_kb = wlanArr3[0][1];
			wlan_out_kb = wlanArr3[0][2];
			rownum2= wlanArr4.length;
		}
	  %>
	  <div class="title">
			<div id="title_zi">WLAN�Ż���Ϣ��ѯ</div>
		</div>
		<TABLe cellSpacing="0">
	 
		<tr>
			<td class="blue">�ײ���Ӧ�Ż�WLANʱ��(����) </TD>
			<TD><input class="InputGrey" name="totalFav" value="<%=wlan_total_minutes%>" maxlength="25" size=20 readonly></TD>
			<td class="blue">�ײ������Ż�WLANʱ��(����) </TD>
			<TD><input class="InputGrey" value="<%=wlan_fav_minutes%>" maxlength="25" size=20 readonly></TD>
			<td class="blue">�ײ�����ʹ��WLANʱ��(����) </TD>
			<TD><input class="InputGrey" value="<%=wlan_out_minutes%>" maxlength="25" size=20 readonly></TD>
		</tr>
		<%
			for(int j =0;j<rownum1;j++)
			{
					%>
					<tr>
						<td class="blue" colspan=6>
						���ײ�����<%=j+1%>��: <%=wlanArr2[j][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
						Ӧ�Ż�ʱ��Ϊ:<%=wlanArr2[j][1]%>����,&nbsp;&nbsp;&nbsp;&nbsp;
						��ʹ��ʱ��Ϊ:<%=wlanArr2[j][2]%>����;&nbsp;&nbsp;&nbsp;&nbsp;
						�ʷ����ȼ�:<%=wlanArr6[j][0]%>
						</td> 
					</tr>
					<%
			}
		%>
		<tr>
			<td class="blue">�ײ���Ӧ�Ż�WLAN����(M) </TD>
			<TD><input class="InputGrey" name="totalFav" value="<%=wlan_total_kb%>" maxlength="25" size=20 readonly></TD>
			<td class="blue">�ײ������Ż�WLAN����(M) </TD>
			<TD><input class="InputGrey" value="<%=wlan_fav_kb%>" maxlength="25" size=20 readonly></TD>
			<td class="blue">�ײ�����ʹ��WLAN����(M) </TD>
			<TD><input class="InputGrey" value="<%=wlan_out_kb%>" maxlength="25" size=20 readonly></TD>
		</tr>
		<%
			for(int k =0;k<rownum2;k++)
			{
					%>
					<tr>
						<td class="blue" colspan=6>
						���ײ�����<%=k+1%>��: <%=wlanArr4[k][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
						Ӧ�Ż�����Ϊ:<%=wlanArr4[k][1]%>M,&nbsp;&nbsp;&nbsp;&nbsp;
						���Ż�����Ϊ:<%=wlanArr4[k][2]%>M;&nbsp;&nbsp;&nbsp;&nbsp;
						�ʷ����ȼ�:<%=wlanArr7[k][0]%>
						</td>
					</tr>
					<%
			}
		%>
		</TABLe>

        
	  <TABLE cellSpacing="0">
	    <TR> 
	      <TD id="footer"> 
	          <input type="button"  name="back"  class="b_foot" value="����" onClick="location='f5186_1.jsp?activePhone=<%=phoneNo%>'">
	          <input type="button"  name="back"  class="b_foot" value="�ر�" onClick="removeCurrentTab()">
	      </TD>
	    </TR>
		 
	  </TABLE>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html>


