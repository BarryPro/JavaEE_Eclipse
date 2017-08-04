<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
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
  String opName = "综合信息查询之用户积分查询";
	
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
			*原来的老页面中根据result.length<1,就跳转到前一个页面
			*但是事实上,老页面中的result.length永远都是大于0的.(如果没有查询到数据,它的length也是1)
			*所以,为了保持跟老页面的一致,这里写成了这样
		************/
		//retCode1="201504";
		if(retCode1=="201504" ||retCode1.equals("201504"))
		{
			System.out.println("aaaaaaaaaaaaaaaaaaaaaccccccccccccccccccc提示报错");
			%>
				<script language="javascript">
					rdShowMessageDialog("4月1日至3日进行积分系统升级，在此间不能使用积分，请引导客户不使用积分办理或4月4日后再进行办理");
					history.go(-1);
				</script>
			<%
		}
		else
		{
			System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbb 不应该？？？？提示报错");

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
		rdShowMessageDialog("请输入正确的查询条件！");
		return false;
	} 
 var bmon=document.f1500_dMarkMsg.beginMonth.value.trim();
 var emon=document.f1500_dMarkMsg.endMonth.value.trim();
 var panduan="<%=mon[0]%>";

 if((bmon.length!=8) ||(emon.length!=8)) {
 		rdShowMessageDialog("请输入正确的查询条件！");
		return false;
 }
 
 if(emon.substring(4,6)>12 || bmon.substring(4,6)>12) {
 		rdShowMessageDialog("请输入正确的查询条件！");
		return false;
 }
   if(bmon.substring(6,8)>31) {
   rdShowMessageDialog("请输入正确的查询条件！");
  return false;
 }
    if(emon.substring(6,8)>31) {
   rdShowMessageDialog("请输入正确的查询条件！");
  return false;
 }
 
 
 if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)==panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4)) {
 if(panduan.substring(4,6)-bmon.substring(4,6)>5) {
 
  rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("结束月份不能大于当前月份！");
  return false;
 }
  if(bmon.substring(4,6)>emon.substring(4,6)) {
   rdShowMessageDialog("结束月份必须大于开始月份！");
  return false;
 }
  if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("结束天数不能大于当前天数！");
  return false;
 }
 }
  else if(bmon.substring(0,4)!=emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4) && Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("结束月份不能大于当前月份！");
  return false;
 }
   if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("结束天数不能大于当前天数！");
  return false;
 }

 }
  else if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)!=panduan.substring(0,4)&& Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 }

 }
   else if(bmon=="" || emon=="") {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("开始年月或结束年月不能为空！");
  return false;
 }

 }
 else {
 	 rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 	}
 

	
	var myPacket = new AJAXPacket("f1500_dMarkMsg3.jsp","正在查询已兑换积分信息，请稍候......");
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
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
}

function doCheck3()
{	
	//alert("test");
	if( document.f1500_dMarkMsg.endMonth.value<document.f1500_dMarkMsg.beginMonth.value) 
	{	
		rdShowMessageDialog("请输入正确的查询条件！");
		return false;
	} 
 var bmon=document.f1500_dMarkMsg.beginMonth.value.trim();
 var emon=document.f1500_dMarkMsg.endMonth.value.trim();
 var panduan="<%=mon[0]%>";

 if((bmon.length!=8) ||(emon.length!=8)) {
 		rdShowMessageDialog("请输入正确的查询条件！");
		return false;
 }
 
 if(emon.substring(4,6)>12 || bmon.substring(4,6)>12) {
 		rdShowMessageDialog("请输入正确的查询条件！");
		return false;
 }
   if(bmon.substring(6,8)>31) {
   rdShowMessageDialog("请输入正确的查询条件！");
  return false;
 }
    if(emon.substring(6,8)>31) {
   rdShowMessageDialog("请输入正确的查询条件！");
  return false;
 }
 
 
 if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)==panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4)) {
 if(panduan.substring(4,6)-bmon.substring(4,6)>5) {
 
  rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("结束月份不能大于当前月份！");
  return false;
 }
  if(bmon.substring(4,6)>emon.substring(4,6)) {
   rdShowMessageDialog("结束月份必须大于开始月份！");
  return false;
 }
  if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("结束天数不能大于当前天数！");
  return false;
 }
 }
  else if(bmon.substring(0,4)!=emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4) && Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("结束月份不能大于当前月份！");
  return false;
 }
   if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("结束天数不能大于当前天数！");
  return false;
 }

 }
  else if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)!=panduan.substring(0,4)&& Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 }

 }
   else if(bmon=="" || emon=="") {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("开始年月或结束年月不能为空！");
  return false;
 }

 }
 else {
 	 rdShowMessageDialog("只能查询最近6个月的记录！");
  return false;
 	}
 

	
	var myPacket = new AJAXPacket("f1500_dMarkMsg4.jsp","正在查询已兑换积分信息，请稍候......");
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
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
}

function init()
{
	 var bmon=document.f1500_dMarkMsg.beginMonth.value.trim();
	 var emon=document.f1500_dMarkMsg.endMonth.value.trim();
	var myPacket = new AJAXPacket("f1500_dMarkMsg3.jsp","正在查询已兑换积分信息，请稍候......");
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

<HTML><HEAD><TITLE>用户积分查询</TITLE>
</HEAD>
<body onload="init()">
<FORM method=post name="f1500_dMarkMsg">
	
  <input type="hidden" value="<%=phoneNo%>" name="phoneNo">
  <input type="hidden" value="<%=fromKF%>" name="fromKF">
  
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户信息</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue" width="13%">手机号码</td>
          <td width="20%"><%=phoneNo%></TD>                  
      	  <td class="blue" width="13%">客户标识</td>
          <td width="20%"><%=id_no%>&nbsp;</td>
          <td class="blue" width="13%">入网时间</td>
          <td width="20%"><%=mainQryArr[0][7]%>&nbsp;</td>
        </tr>
        <tr>
          <td class="blue">当前积分</td>
          <td><%=mainQryArr[0][0]%>&nbsp;</td>
 		  <td class="blue">&nbsp;</td>
 		  <td>&nbsp;</td>
          <td class="blue">&nbsp;</td>
          <td>&nbsp;</td>           
        </tr>
        <tr>
          <td class="blue">上月新增积分</td>
          <td><%=mainQryArr[0][5]%>&nbsp;</td>
          <td class="blue">操作时间</td>
          <td><%=mainQryArr[0][13]%></td>
          <td class="blue">建档时间</td>
          <td><%=mainQryArr[0][8]%>&nbsp;</td>
        </tr> 
     
        
        <TR>
          <TD class="blue">起始年月</td>
          <td> 
          		<input name="beginMonth" value="<%=bMon%>" maxlength="8" size=21 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
          		
          </TD>
          <TD class="blue">结束年月</td>
          <td colspan="3"> 
          		<input name="endMonth" value="<%=mon[0]%>" maxlength="8" size=21 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">&nbsp;&nbsp;&nbsp;&nbsp;
          		<input type="button" class="b_text" name="Button1" value="已兑换积分查询" onclick="doCheck2()">
          		<input type="button" class="b_text" name="Button2" value="可兑换积分查询" onclick="doCheck()">
          		<input type="button" class="b_text" name="Button2" value="生成积分查询" onclick="doCheck3()">

          </TD>
          <tr>
          <td colspan='6'>
          	<font class="orange">时间格式：yyyyMMdd</font>
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
				&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
				&nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=关闭>
				<%
				}
				else
				{%>
					&nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
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