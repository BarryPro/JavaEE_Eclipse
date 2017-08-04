<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v1.0
 开发商: si-tech
	at:songjia
 模块:1219特服变更
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=gbk"%>

<%     
	response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String opName = "特服办理";
	String opCode = "1219";
	
	String work_no = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String phone_no =request.getParameter("phone_no");
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String belong_code= (String)request.getParameter("belong_code");
	String region_code =belong_code.substring(0,2);
	String iLoginPwd = (String)request.getParameter("iLoginPwd");
	String iUserPwd = "";
	String iLoginAccept = "0";//流水
	String iChnSource = "06";//渠道标识
	//System.out.println(work_no+"@"+workName+"@"+org_code+"@"+phone_no+"@"+iLoginNo+"@"+iLoginPwd);
	String sm_code=(String)request.getParameter("sm_code"); 
	Map mp = new HashMap();//ID与名称映射
	String[][] dataRows = new String[][]{};//返回结果集
	String[][] comeshowRows = new String[][]{};//来号显示返回结果集
		try{
%>
<%!
	public String getButtonInfo(String id,String flag,String name){
		if("1".equals(flag)){
		  if("全国漫游".equals(name)||"国际漫游".equals(name)||"无漫游".equals(name)){
			  return "<td><font style='color:red'>已开通</font></td><td><input type='button' class='b_text' disabled='disabled'  value='取消' onclick=\"goAccept('"+id+"',this.value,'"+name+"')\"/></td>";
		 	}else{
			 	return "<td><font style='color:red'>已开通</font></td><td><input type='button' class='b_text' value='取消' onclick=\"goAccept('"+id+"',this.value,'"+name+"')\"/></td>";
		 	}
		}else{
			return "<td>未开通</td><td><input type='button' class='b_text' value='开通' onclick=\"goAccept('"+id+"',this.value,'"+name+"')\"/>";
		}
	}
	
%>
	<wtc:service name="s1219Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="37">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		</wtc:service>
		<wtc:array id="ms_code_arr" start="1" length="1" scope="end"/>
		<wtc:array id="initStr_1" start="26" length="1" scope="end"/>
		<wtc:array id="initStr_2" start="32" length="1" scope="end"/>
		<wtc:array id="initStr_3" start="28" length="1" scope="end"/>
		<wtc:array id="initStr_4" start="29" length="1" scope="end"/>
			<wtc:array id="initStr_5" start="30" length="1" scope="end"/>
<%
	//System.out.println("=== lipf  === retCode == "+retCode);                 
	if("000000".equals(retCode)){
			sm_code = ms_code_arr[0][0];
			for(int i=0;i<initStr_1.length;i++){
				mp.put(initStr_1[i][0],initStr_2[i][0]);
				//System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				//System.out.println("==lipf=== "+initStr_1[i][0]+"songjia:"+initStr_2[i][0]);
      }
  }
}catch(Exception ex){
%>
	<script type="text/javascript">
		rdShowMessageDialog("调用服务s1219Init出错",0);
		return;
	</script>
<%}%>
<%
	//System.out.println("=== lipf  = === speinfo.jsp == == sm_code == "+sm_code);
	String sql = "select product_id,function_name from sfunclist where show_flag='Y' and region_code=:region_code and sm_code=:sm_code and function_name in('来电提醒','来号显示','三方通话','呼叫等待','国际长途','国际漫游','语音信箱','数据通讯','可视电话','GPRS','全国漫游','GPRS业务','无漫游','WLAN自动认证')";
	String myParams="region_code="+region_code+",sm_code="+sm_code;
	//add by lipf 20120629 对来号显示单独处理，不管5元、十元等等办理过，都显示来号显示开通
	String comeshowSql="SELECT A.PRODUCT_ID, '来号显示' FROM SFUNCLIST A  WHERE A.REGION_CODE =:region_code  AND A.SM_CODE =:sm_code AND A.COMMAND_CODE ='19'";
	String comeshowParams="region_code="+region_code+",sm_code="+sm_code;
	//System.out.println("=== lipf  === sql == "+sql+"  ==comeshowSql== "+comeshowSql);
	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>	
	</wtc:service>
	<wtc:array id="queryList"  scope="end"/>	
	<!--add by lipf 20120629来号显示处理-->
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=comeshowSql%>"/>
		<wtc:param value="<%=comeshowParams%>"/>	
	</wtc:service>
	<wtc:array id="comeshowList"  scope="end"/>
	<%
	dataRows = queryList;
	comeshowRows=comeshowList;
	//System.out.println("=== lipf  === dataRows.length == "+dataRows.length);
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>特服办理</TITLE>
</HEAD>

<script language="JavaScript">
<!--
window.onload=function() {
	window.top.openTFFlag = 0; //密码验证后是否打开特服页面标识还原
	var newHeight = document.body.scrollHeight + 20 + "px";
	var newWidth = document.body.scrollWidth + 20 + "px";
	window.parent.document.getElementById("showCustWTab").style.height = newHeight;
	window.parent.document.getElementById("showCustWTab").style.width = newWidth;
	window.parent.document.getElementById("iFrame1").style.height = newHeight;
	window.parent.document.getElementById("iFrame1").style.width = newWidth;
}
function goAccept(id,status_text,name)
{
		var open_flag="";
		if(status_text == "开通"){
			open_flag="1";
		}else if(status_text == "取消"){
			open_flag="0";
		}else return;
		if(rdShowConfirmDialog("确认要提交么?")==1)
		{
					var packet = new AJAXPacket("speinfo_do.jsp","请稍后...");//组合产品子产品展示
					packet.data.add("open_flag" ,open_flag);
					packet.data.add("id" ,id);
					packet.data.add("phone_no","<%=phone_no%>");//手机号码
					packet.data.add("iLoginNo","<%=iLoginNo%>");//工号
					packet.data.add("iLoginPwd","<%=iLoginPwd%>");//密
					packet.data.add("sm_code","<%=sm_code%>");//密
					packet.data.add("name",name);//密
					packet.data.add("belong_code","<%=belong_code%>");//归属
					
					core.ajax.sendPacket(packet,doback);
					packet =null;
		}
	
}
function doback(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		rdShowMessageDialog("操作结果："+retMsg,2);
		parent.toTF();
		
}
function doStart(flag){
	if(rdShowConfirmDialog("确认要提交么?")==1)
		{
					var packet = new AJAXPacket("speshormsg.jsp","请稍后...");//组合产品子产品展示
					packet.data.add("flag" ,flag);
					packet.data.add("phone_no","<%=phone_no%>");//手机号码
					packet.data.add("iLoginNo","<%=iLoginNo%>");//工号
					core.ajax.sendPacket(packet,dobackmsg);
					packet =null;
		}
}
function dobackmsg(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
                if( retCode == "000000" )
		{
	   	        rdShowMessageDialog("操作结果："+retMsg,2);
		}
                else
		{
			rdShowMessageDialog("操作结果："+retMsg,0);
		}
}
</script>
<body>

<FORM method=post name="form1" onKeyUp="chgFocus(form1)">
	<DIV id="Operation_Table" style="width:765px">  
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

			 <table cellspacing="0">		  
        	<TBODY id="speData"> 
							<%
							for(int i=0;i<dataRows.length;i++){
								//System.out.println("== lipf=  sm_code  == "+sm_code+" ==region_code=="+region_code+" ====dataRows[i][0]  ==== "+dataRows[i][0]+"  === dataRows[i][1] ==== "+dataRows[i][1]);
									
									 
									//add by lipf 20120629 办理过来电显示五元、十元等，都显示为来号显示
									if("来号显示".equals(dataRows[i][1])){
										if(comeshowRows!=null){
											for(int j=0;j<comeshowRows.length;j++){
												if(mp.containsKey(comeshowRows[j][0])){
													dataRows[i][0]=comeshowRows[j][0];
													break;
												}
											}
										}
									}
								 	if(!mp.containsKey(dataRows[i][0])){ 
								 	  out.print("<tr>");
								 	  out.print("<th>"+dataRows[i][1]+"</th>");
										out.print(getButtonInfo(dataRows[i][0],"0",dataRows[i][1]));
									}
								    out.print("</tr>");
							}
								for(int i=0;i<dataRows.length;i++){
								//System.out.println("== lipf=  sm_code  == "+sm_code+" ==region_code=="+region_code+" ====dataRows[i][0]  ==== "+dataRows[i][0]+"  === dataRows[i][1] ==== "+dataRows[i][1]);
									
									
									
									//add by lipf 20120629 办理过来电显示五元、十元等，都显示为来号显示
									if("来号显示".equals(dataRows[i][1])){
										if(comeshowRows!=null){
											for(int j=0;j<comeshowRows.length;j++){
												if(mp.containsKey(comeshowRows[j][0])){
													dataRows[i][0]=comeshowRows[j][0];
													break;
												}
											}
										}
									}
								 	if(mp.containsKey(dataRows[i][0])){ 
								 	  out.print("<tr>");
								 	  out.print("<th>"+dataRows[i][1]+"</th>");
										out.print(getButtonInfo(dataRows[i][0],"1",dataRows[i][1]));
									}
								    out.print("</tr>");
							}
								
								
								
								%>
					
          </TBODY>
        </table>
    <div class="title">
			<div id="title_zi">收费短信提醒</div>
		</div> 
		 <table cellspacing="0">		  
        	<TBODY> 
					<tr>
						<th>收费短信提醒</th>
						<td>
							<input type="button" class="b_text" value="开通" onclick="doStart('01')"/>
							<input type="button" class="b_text" value="关闭" onclick="doStart('02')"/>
							</td>
					</tr>
				</TBODY>
			</table>
 </div>
</form>
</body>
</html>
