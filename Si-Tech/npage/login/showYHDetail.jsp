<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*update:tangsong@2010-12-30 ҳ����ʽ����,�����û���Ϣҳ
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

	String open_time  ="";
	String cust_name  ="";
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	String dateStr =  request.getParameter("dateStr");


	String totalFav = "��";
	String usedFav = "��";
	String totalMessFav = "��";
	String usedMessFav = "��";
	String totalGprsFav = "��";
	String usedGprsFav = "��";
	String otherGprsFav ="��";
    String partGprsFav ="��";
	String partUsedGprsFav ="��";
	String sqlStr = "";
	String tiaojian = "201010";

	sqlStr = "select substr(a.open_time,1,8),b.cust_name from dcustmsg a,dcustdoc b where a.cust_id=b.cust_id and a.phone_no ='?'";
	
	//xl add ������ ����"�ײ����� Ӧ�Ż� ���Ż�"����Ϣ
	int rownum0=0;

	String  inputParsm [] = new String[2];
	inputParsm[0] = phoneNo;
	//����� ��ѡ �����¸�inputParsm[1]��ֵ

	inputParsm[1] = dateStr;

	//String [] cussidArr=co.callService("sGetUserFavMsg",inputParsm,"6","phone",phoneNo);
%>
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
		<wtc:service name="s5186FavMsg" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="15" >
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
		</wtc:service>
		<wtc:array id="cussidArr1" scope="end" start="0"  length="6"/> 
		<wtc:array id="cussidArr2" scope="end" start="6"  length="6"/>
		<wtc:array id="cussidArr3" scope="end" start="12"  length="3"/>

<!--xl add WLAN ��ѯ-->
<wtc:service name="sWlanFavOpr1" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="14" >
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
</wtc:service>
<wtc:array id="wlanArr1" scope="end" start="0"  length="5"/> 
<wtc:array id="wlanArr2" scope="end" start="5"  length="3"/>
<wtc:array id="wlanArr3" scope="end" start="8"  length="3"/>
<wtc:array id="wlanArr4" scope="end" start="11"  length="3"/>

<%
	if(cussidArr1!=null&&cussidArr1.length>0){
		totalGprsFav = cussidArr1[0][0];
		usedGprsFav = cussidArr1[0][1];
		otherGprsFav = cussidArr1[0][2];
		//partGprsFav = cussidArr1[0][3];//�ֶ�Ӧ�Ż�
		//partUsedGprsFav = cussidArr1[0][4];//�ֶ����Ż�
		rownum0 = cussidArr3.length;
	}
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="retMsg2" retcode="retCode2" routerKey="phone" routerValue="<%=phoneNo%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
<wtc:param value="<%=phoneNo%>"/>
</wtc:pubselect>
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
<wtc:service name="sGetUserFavMsgN"  routerKey="phone" routerValue="<%=phoneNo%>"  outnum="26" retmsg="retMsgyy" retcode="retCodeyy" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=dateStr%>"/>
</wtc:service>
<wtc:array id="yyArr" scope="end" start="19"  length="3"/>
<wtc:array id="dxArr" scope="end" start="22"  length="3"/>
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
 	</HEAD>
<BODY>
<FORM method=post name="frm5186">
	<DIV id="Operation_Table" style="width:765px;">
		<!--
		<div class="title">
			<div id="title_zi">Gprs��ѯ���</div>
		</div>
		-->
		
		 
			

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
						���Żݷ�����:<%=yyArr[m][2]%>����.</td>
					</tr>
				<%
			}
		%>
	   </table>
	  <!--xl add for �����Ż���Ϣ��ѯ-->	

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
						���Żݶ���:<%=dxArr[n][2]%>��.</td>
					</tr>
				<%
			}
		%>
	  </table>
	  <!--end of ����new-->
	  
	  <TABLe cellSpacing="0">
			<div class="title">
				<div id="title_zi">GPRS�Ż���Ϣ</div>
			</div>
			<tr>
				<td class="blue" colspan=4>�ײ���Ӧ�Ż�GPRS������<%=totalGprsFav%>;&nbsp;&nbsp;&nbsp;&nbsp;
				�ײ������Ż�GPRS������<%=usedGprsFav%>;&nbsp;&nbsp;&nbsp;&nbsp;
				�ײ�����ʹ��GPRS������<%=otherGprsFav%>;
				</TD>
			</tr>

			<!--xl add ������-->	
			
			<%
				for(int i =0;i<rownum0;i++)
				{
						%>
						<tr>
							<td class="blue" colspan=4>
							���ײ�����<%=i+1%>��: <%=cussidArr3[i][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
							Ӧ�Ż�����Ϊ:<%=cussidArr3[i][1]%>M,&nbsp;&nbsp;&nbsp;&nbsp;
							��ʹ��:<%=cussidArr3[i][2]%>M;</td>
						</tr>
						<%
				}
			%>
			

			<!--xl end ������-->
	   </table>
	  
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
						��ʹ��ʱ��Ϊ:<%=wlanArr2[j][2]%>����;</td>
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
						���Ż�����Ϊ:<%=wlanArr4[k][2]%>M;</td>
					</tr>
					<%
			}
		%>
		</TABLe>

	  <TABLE cellSpacing="0">
	    <TR>
	      <TD id="footer">


	      </TD>
	    </TR>
	  </TABLE>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html>


