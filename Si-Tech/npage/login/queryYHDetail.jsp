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
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());


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
	//xl add for ʱ���ѯ ��6����
	String time_sql="select to_char(sysdate,'YYYYMM'), to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'),  -1),  'YYYYMM'),  to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'),   -2),   'YYYYMM'),  to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'), -3), 'YYYYMM'), to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'), -4),  'YYYYMM'), to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'),  -5), 'YYYYMM')  from dual";
	%>
	<script type="text/javascript" src="/js/selectDateNew.js" charset="utf-8"></script>
	<script type="text/javascript">
    function showCx(){
			if(document.getElementById("dates").checked ){
				document.getElementById('show1').style.display="block";
				document.getElementById('show2').style.display="none";
				document.all.showCustWTab.style.display="none";
				document.all.showCustWTab2.style.display="none";
			}
			if(document.getElementById("months").checked ){
				document.getElementById('show1').style.display="none";
				document.getElementById('show2').style.display="block";
				var year = document.getElementById('year1').value;
				var month = document.getElementById('month1').value;
				document.all.showCustWTab.style.display="none";
				document.all.showCustWTab2.style.display="none";
			}
			chParStyle();
    }
		function queryByYearMonth(year){
			//�����²�ѯ iframe1
			var path = "showYHDetail1.jsp?phoneNo=<%=phoneNo%>&dateStr="+year;
		   // alert("path is "+path);
		  document.frames["iFrame1"].document.body.innerText = "";
			document.getElementById("iFrame1").src = path;
			document.all.showCustWTab.style.display="block";
			chParStyle();
		}
		// ���ڲ�ѯ iframe2
		function queryByDate(){
			var dates = document.getElementById("caledar").value;
			if(dates ==""){
				alert("��ѡ���ѯ����!");
				return false;
			}
			else 
			{
				var path = "showYHDetail1.jsp?phoneNo=<%=phoneNo%>&dateStr="+dates;
			 // alert("path is "+path);
			    document.frames["iFrame2"].document.body.innerText = "";
			    document.getElementById("iFrame2").src = path;
			    document.all.showCustWTab2.style.display="block";
			}
			chParStyle();
		}
		window.onload = function() {
			chParStyle();
		}
		function chParStyle() {
			var newHeight = document.body.scrollHeight + 20 + "px";
			var newWidth = document.body.scrollWidth + 20 + "px";
			window.parent.document.getElementById("showCustWTab").style.height = newHeight;
			window.parent.document.getElementById("showCustWTab").style.width = newWidth;
			window.parent.document.getElementById("iFrame1").style.height = newHeight;
			window.parent.document.getElementById("iFrame1").style.width = newWidth;
		}
</script>
	<%
	String  inputParsm [] = new String[2];
	inputParsm[0] = phoneNo;
	//����� ��ѡ �����¸�inputParsm[1]��ֵ
	inputParsm[1] = dateStr;
	//String [] cussidArr=co.callService("sGetUserFavMsg",inputParsm,"6","phone",phoneNo);
	%>
	<wtc:service name="sGetUserFavMsgN" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
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
		<wtc:service name="s5186FavMsg" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="6" >
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
		</wtc:service>
		<wtc:array id="cussidArr1" scope="end"/>
<%
	if(cussidArr1!=null&&cussidArr1.length>0){
		totalGprsFav = cussidArr1[0][0];
		usedGprsFav = cussidArr1[0][1];
		otherGprsFav = cussidArr1[0][2];
		//partGprsFav = cussidArr1[0][3];//�ֶ�Ӧ�Ż�
		//partUsedGprsFav = cussidArr1[0][4];//�ֶ����Ż�
	}
%>

<!--xl add for ʱ���ѯ-->
<wtc:pubselect name="TlsPubSelBoss" outnum="6" retmsg="retMsg6" retcode="retCode6" routerKey="phone" routerValue="<%=phoneNo%>">
	<wtc:sql><%=time_sql%></wtc:sql>
 
</wtc:pubselect>
<wtc:array id="retTime" scope="end"/>

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
  
  String   currentYear   = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()); //��ǰʱ��
  System.out.println("-------------currentYear--------------"+currentYear);
%>

<HTML>
	<HEAD>
	 
	</HEAD>
<BODY onload="inits()">
<script language="javascript">
	function inits()
	{
		//alert("123");
		document.getElementById("inits_cx").click();
		//alert("345");
	}
</script>
<FORM method=post name="frm5186">
<!--xiaoliang �Ż���Ϣ��ѯ���� begin-->
<DIV id="Operation_Table" style="width:765px;">
		<div class="title">
			<div id="title_zi">��ʷ�Ż���Ϣ(���ṩ)</div>
		</div>
		<TABLe cellSpacing="0">
			<tr>
				<td class="blue">Gprs������ѯ����&nbsp;&nbsp; &nbsp;
				���·ݲ�ѯ
				<input type = "radio" name = "cxtj" id="months" value="yf" checked = "true" onclick = "showCx()">
				</TD>
		    </tr>
			<tr>
			 <td class="blue" id="show2" style="display: block;">������룺<%=phoneNo%> &nbsp;&nbsp;���·ݲ�ѯ��
			            <!--
						 <select name="year" id="year1" size=1 >
						  <option value = "2007" >2007</option>
						  <option value = "2008" >2008</option>
						  <option value = "2009" >2009</option>
						  <option value = "2010" >2010</option>
						  <option value = "2011" <%if(currentYear.equals("2011")) out.print("selected");%> >2011</option>
						  <option value = "2012" <%if(currentYear.equals("2012")) out.print("selected");%>>2012</option>
                         </select>
						 &nbsp;&nbsp;
						 <select name="month" id="month1" size=1 >
						  <script language="javascript">
var sel=document.getElementById('month1');
for(i=1;i<13;i++)
{
if(i<10){
		sel.options.add(new Option("0"+i,"0"+i));
	}
	else{
		sel.options.add(new Option(i,i));
	}
}
var d=new Date();
sel.selectedIndex=d.getMonth();
</script>
                         </select>
						 -->
						 <select name="year" id="year1" size=1 >
						 
							<%
							System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa retTime.length is "+retTime.length);
							for(int i=0; i<retTime.length; i++){%>
							<option value="<%=retTime[i][0]%>" selected>
								<%=retTime[i][0]%></option>
							<option value="<%=retTime[i][1]%>">
								<%=retTime[i][1]%></option>
							<option value="<%=retTime[i][2]%>">
								<%=retTime[i][2]%></option>	
							<option value="<%=retTime[i][3]%>">
								<%=retTime[i][3]%></option>
							<option value="<%=retTime[i][4]%>">
								<%=retTime[i][4]%></option>
							<option value="<%=retTime[i][5]%>">
								<%=retTime[i][5]%></option>
							<%}%>
						 </select>
						 &nbsp;&nbsp;&nbsp;&nbsp;
						 <input type="button" class="b_text" value="��ѯ" id="inits_cx" onclick="queryByYearMonth(document.getElementById('year1').value)">
			</td>

            <!--xiaoliang  �����ڲ�ѯ��ʼ-->
			 <td class="blue" id="show1" style="display: none;">������룺<%=phoneNo%> &nbsp;&nbsp;�����ڲ�ѯ��
			     <!--
				  <input type = "text" name ="bydate" id = "caledar" />
					<img onclick="selectDateNew(bydate)" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
					-->
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="b_text" value="1��ѯ" onclick="queryByDate()">
			</td>
			<!--xiaoliang �����ڲ�ѯ����-->
			</tr>

	   </table>
<!--xiaoliang �Ż���Ϣ��ѯ ����-->
</div>



		<div id="showCustWTab" style="display:none">
			<iframe name="iFrame1" src=""  width="100%" height="350px" frameborder="0"  >
			</iframe>
  	</div>
    <div id="showCustWTab2" style="display:none">
			<iframe name="iFrame2" src=""  width="100%" height="350px" frameborder="0"  >
			</iframe>
    </div>

</FORM>
</body>
</html>


