<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String fromKF=request.getParameter("fromKF")==null?"":request.getParameter("fromKF"); 
		String[] mon = new String[]{""};
		String bMon="";
	
    Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
		for(int i=0;i<=0;i++){
        if(i!=0){
          mon[i] = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(cal.getTime());
          cal.add(Calendar.MONTH,-1);
        }else{
          mon[i] = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(cal.getTime());
        }
    }      
    cal.add(Calendar.MONTH,-5);  
    bMon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime())+"01";
	System.out.println("bMon~~~~"+bMon);
	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�û����ֲ�ѯ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phoneNo  = request.getParameter("phoneNo");
	String cust_name  = request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	
		
%>

	<wtc:service name="sMarkMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum=
"16">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        </wtc:service>
        <wtc:array id="mainQryArr" scope="end"/>
        	

		
<%
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa retCode1 is "+retCode1);
		/***********
			*ԭ������ҳ���и���result.length<1,����ת��ǰһ��ҳ��
			*������ʵ��,��ҳ���е�result.length��Զ���Ǵ���0��.(���û�в�ѯ������,����lengthҲ��1)
			*����,Ϊ�˱��ָ���ҳ���һ��,����д��������
		************/
		//retCode1="201504";
		if(retCode1=="201504" ||retCode1.equals("201504"))
		{
			System.out.println("aaaaaaaaaaaaaaaaaaaaaccccccccccccccccccc��ʾ����");
			%>
				<script language="javascript">
					rdShowMessageDialog("4��1����3�ս��л���ϵͳ�������ڴ˼䲻��ʹ�û��֣��������ͻ���ʹ�û��ְ����4��4�պ��ٽ��а���");
					history.go(-1);
				</script>
			<%
		}
		else
		{
			System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbb ��Ӧ�ã���������ʾ����");

			if (mainQryArr.length<1) {
			mainQryArr = new String[1][17];
			for(int i=0;i<mainQryArr.length;i++){
				for(int j=0;j<mainQryArr[i].length;j++){
					mainQryArr[i][j]="";
				}
			}
		}
		
		String currentGrade = "";
		if(mainQryArr[0][4]!=""||mainQryArr[0][4]!=null){
			currentGrade = mainQryArr[0][4];
		}
%>

<script>
function doCheck()
{	

		document.f1500_dMarkMsg.action="f1500_dMarkMsg2.jsp";
		f1500_dMarkMsg.submit();

}

function doCheck2()
{	
	if( document.f1500_dMarkMsg.endMonth.value<document.f1500_dMarkMsg.beginMonth.value) 
	{	
		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		return false;
	} 
 var bmon=document.f1500_dMarkMsg.beginMonth.value.trim();
 var emon=document.f1500_dMarkMsg.endMonth.value.trim();
 var panduan="<%=mon[0]%>";

 if((bmon.length!=8) ||(emon.length!=8)) {
 		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		return false;
 }
 
 if(emon.substring(4,6)>12 || bmon.substring(4,6)>12) {
 		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		return false;
 }
   if(bmon.substring(6,8)>31) {
   rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
  return false;
 }
    if(emon.substring(6,8)>31) {
   rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
  return false;
 }
 
 
 if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)==panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4)) {
 if(panduan.substring(4,6)-bmon.substring(4,6)>5) {
 
  rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("�����·ݲ��ܴ��ڵ�ǰ�·ݣ�");
  return false;
 }
  if(bmon.substring(4,6)>emon.substring(4,6)) {
   rdShowMessageDialog("�����·ݱ�����ڿ�ʼ�·ݣ�");
  return false;
 }
  if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("�����������ܴ��ڵ�ǰ������");
  return false;
 }
 }
  else if(bmon.substring(0,4)!=emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4) && Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("�����·ݲ��ܴ��ڵ�ǰ�·ݣ�");
  return false;
 }
   if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("�����������ܴ��ڵ�ǰ������");
  return false;
 }

 }
  else if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)!=panduan.substring(0,4)&& Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 }

 }
   else if(bmon=="" || emon=="") {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("��ʼ���»�������²���Ϊ�գ�");
  return false;
 }

 }
 else {
 	 rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 	}
 

	
	var myPacket = new AJAXPacket("f1500_dMarkMsg3.jsp","���ڲ�ѯ�Ѷһ�������Ϣ�����Ժ�......");
	myPacket.data.add("id_no","<%=id_no%>");
	myPacket.data.add("phoneNo","<%=phoneNo%>");
	myPacket.data.add("cust_name","<%=cust_name%>");
	myPacket.data.add("work_no","<%=work_no%>");
	myPacket.data.add("work_name","<%=work_name%>");
	myPacket.data.add("btime",bmon);
	myPacket.data.add("etime",emon);
	core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
	getdataPacket = null;
}
  function checkSMZValue(data) {
				//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
}

function doCheck3()
{	
	//alert("test");
	if( document.f1500_dMarkMsg.endMonth.value<document.f1500_dMarkMsg.beginMonth.value) 
	{	
		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		return false;
	} 
 var bmon=document.f1500_dMarkMsg.beginMonth.value.trim();
 var emon=document.f1500_dMarkMsg.endMonth.value.trim();
 var panduan="<%=mon[0]%>";

 if((bmon.length!=8) ||(emon.length!=8)) {
 		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		return false;
 }
 
 if(emon.substring(4,6)>12 || bmon.substring(4,6)>12) {
 		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		return false;
 }
   if(bmon.substring(6,8)>31) {
   rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
  return false;
 }
    if(emon.substring(6,8)>31) {
   rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
  return false;
 }
 
 
 if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)==panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4)) {
 if(panduan.substring(4,6)-bmon.substring(4,6)>5) {
 
  rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("�����·ݲ��ܴ��ڵ�ǰ�·ݣ�");
  return false;
 }
  if(bmon.substring(4,6)>emon.substring(4,6)) {
   rdShowMessageDialog("�����·ݱ�����ڿ�ʼ�·ݣ�");
  return false;
 }
  if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("�����������ܴ��ڵ�ǰ������");
  return false;
 }
 }
  else if(bmon.substring(0,4)!=emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4) && Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("�����·ݲ��ܴ��ڵ�ǰ�·ݣ�");
  return false;
 }
   if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("�����������ܴ��ڵ�ǰ������");
  return false;
 }

 }
  else if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)!=panduan.substring(0,4)&& Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 }

 }
   else if(bmon=="" || emon=="") {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("��ʼ���»�������²���Ϊ�գ�");
  return false;
 }

 }
 else {
 	 rdShowMessageDialog("ֻ�ܲ�ѯ���6���µļ�¼��");
  return false;
 	}
 

	
	var myPacket = new AJAXPacket("f1500_dMarkMsg4.jsp","���ڲ�ѯ�Ѷһ�������Ϣ�����Ժ�......");
	myPacket.data.add("id_no","<%=id_no%>");
	myPacket.data.add("phoneNo","<%=phoneNo%>");
	myPacket.data.add("cust_name","<%=cust_name%>");
	myPacket.data.add("work_no","<%=work_no%>");
	myPacket.data.add("work_name","<%=work_name%>");
	myPacket.data.add("btime",bmon);
	myPacket.data.add("etime",emon);
	core.ajax.sendPacketHtml(myPacket,checkSMZValue2,true);
	getdataPacket = null;
}

  function checkSMZValue2(data) {
				//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
}

function init()
{
	 var bmon=document.f1500_dMarkMsg.beginMonth.value.trim();
	 var emon=document.f1500_dMarkMsg.endMonth.value.trim();
	var myPacket = new AJAXPacket("f1500_dMarkMsg3.jsp","���ڲ�ѯ�Ѷһ�������Ϣ�����Ժ�......");
	myPacket.data.add("id_no","<%=id_no%>");
	myPacket.data.add("phoneNo","<%=phoneNo%>");
	myPacket.data.add("cust_name","<%=cust_name%>");
	myPacket.data.add("work_no","<%=work_no%>");
	myPacket.data.add("work_name","<%=work_name%>");
	myPacket.data.add("btime",bmon);
	myPacket.data.add("etime",emon);
	core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
	getdataPacket = null;	
}

</script>

<HTML><HEAD><TITLE>�û����ֲ�ѯ</TITLE>
</HEAD>
<body onload="init()">
<FORM method=post name="f1500_dMarkMsg">
	
  <input type="hidden" value="<%=phoneNo%>" name="phoneNo">
  <input type="hidden" value="<%=fromKF%>" name="fromKF">
  
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue" width="13%">�ֻ�����</td>
          <td width="20%"><%=phoneNo%></TD>                  
      	  <td class="blue" width="13%">�ͻ���ʶ</td>
          <td width="20%"><%=id_no%>&nbsp;</td>
          <td class="blue" width="13%">����ʱ��</td>
          <td width="20%"><%=mainQryArr[0][7]%>&nbsp;</td>
        </tr>
        <tr>
          <td class="blue">��ǰ����</td>
          <td><%=mainQryArr[0][0]%>&nbsp;</td>
 		  <td class="blue">&nbsp;</td>
 		  <td>&nbsp;</td>
          <td class="blue">&nbsp;</td>
          <td>&nbsp;</td>           
        </tr>
        <tr>
          <td class="blue">������������</td>
          <td><%=mainQryArr[0][5]%>&nbsp;</td>
          <td class="blue">����ʱ��</td>
          <td><%=mainQryArr[0][13]%></td>
          <td class="blue">����ʱ��</td>
          <td><%=mainQryArr[0][8]%>&nbsp;</td>
        </tr> 
     
        
        <TR>
          <TD class="blue">��ʼ����</td>
          <td> 
          		<input name="beginMonth" value="<%=bMon%>" maxlength="8" size=21 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
          		
          </TD>
          <TD class="blue">��������</td>
          <td colspan="3"> 
          		<input name="endMonth" value="<%=mon[0]%>" maxlength="8" size=21 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">&nbsp;&nbsp;&nbsp;&nbsp;
          		<input type="button" class="b_text" name="Button1" value="�Ѷһ����ֲ�ѯ" onclick="doCheck2()">
          		<input type="button" class="b_text" name="Button2" value="�ɶһ����ֲ�ѯ" onclick="doCheck()">
          		<input type="button" class="b_text" name="Button2" value="���ɻ��ֲ�ѯ" onclick="doCheck3()">

          </TD>
          <tr>
          <td colspan='6'>
          	<font class="orange">ʱ���ʽ��yyyyMMdd</font>
          </td>
          </tr>
        </TR>
      </TBODY>
	  </TABLE>
   
      
      	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<%
				if ( !fromKF.equals("Y") )
				{
				%>
				&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
				&nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=�ر�>
				<%
				}
				else
				{%>
					&nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=�ر�>
				<%}
				%>
			</div>
			</td>
		</tr>
	</table>
			<div id="gongdans">
		</div>	
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>


			<%
		}
%>