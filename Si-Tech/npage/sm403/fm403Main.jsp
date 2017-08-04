<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ page import="com.sitech.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!




	public String readValue(String param1,String param2,String param3,String paths) {//根据key值和路径查询properties文件中rdmessage信息
  String returnValues=null;
  Properties props = new Properties();
  String key = param1+"."+param2+"."+param3;
        try {
        System.out.println(paths+"------wanghyd");
        InputStream in = new BufferedInputStream(new FileInputStream(paths));
         props.load(in);
          returnValues =new String(props.getProperty(key).getBytes("ISO-8859-1"),"gbk"); 
            System.out.println(key+returnValues+"------wanghyd");
            return returnValues;
        } catch (FileNotFoundException ex) {
         ex.printStackTrace();
         System.out.println("wrong------wanghyd-ssss"+ex);
         return null;
         
        }catch (Exception e) {
         e.printStackTrace();
         System.out.println("wrong------wanghyd"+e);
         return null;
         
        }
        
        
 }
 
 //以下方法为加密方法
private String encrypt11111(String host){
	if (host==null || "".equals(host)){
		return ""; 
	}
	try{
		Cipher encryptCipher = null;
		String strDefaultKey = "crmuk012";
		//Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Key key = getKey(strDefaultKey.getBytes());

		encryptCipher = Cipher.getInstance("DES");
		encryptCipher.init(Cipher.ENCRYPT_MODE, key);

		return byteArr2HexStr(encryptCipher.doFinal(host.getBytes()));
	}
	catch(Exception e){
		e.printStackTrace();
		return "";
	}
}


private static String byteArr2HexStr(byte[] arrB) throws Exception {
	int iLen = arrB.length;
	//每个byte用两个字符才能表示，所以字符串的长度是数组长度的两倍
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//把负数转换为正数
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//小于0F的数需要在前面补0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}

private Key getKey(byte[] arrBTmp) throws Exception {
	//创建一个空的8位字节数组（默认值为0）
	byte[] arrB = new byte[8];
	//将原始字节数组转换为8位
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//生成密钥
	Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	return key;
}

%>
<wtc:service name="TlsPubSelBoss" outnum="1">
		<wtc:param value="select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual"/>
	</wtc:service>
	<wtc:array id="newdate" scope="end"/>
<%
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String date1=dateStr+" 00:00:00";
java.util.Calendar calendar = java.util.Calendar.getInstance();
calendar.setTime(sdf.parse(newdate[0][0]));
calendar.add(calendar.HOUR,-2);
String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
String date2=dateStr1;

		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		String accountType = (String)session.getAttribute("accountType");
		/*
	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}*/
		
		
	 String loginName=loginNo;
	 
	 String loginName_jiami = encrypt11111(loginName);
	
	 
%>
<%
/**
		20130219gaopeng修改，新增查询当前输入的手机号码的归属地市与当前登录工号的归属地市，不允许跨地市办理该业务(工号aaa8zy除外)
		start
**/
		String sqlregC= "select trim(b.region_code) from dcustmsg a,dcustdoc b where a.cust_id=b.cust_id and a.phone_no='"+phoneNo+"'";
 
%>		
<wtc:service name="TlsPubSelBoss" outnum="1">
		<wtc:param value="<%=sqlregC%>"/>
	</wtc:service>
	<wtc:array id="result_sqlregC" scope="end"/>

<%
String regCodegp="00";

if(result_sqlregC.length>0 )
{
		regCodegp=result_sqlregC[0][0];
}
/**
		20130219gaopeng修改，新增查询当前输入的手机号码的归属地市与当前登录工号的归属地市，不允许跨地市办理该业务(工号aaa8zy除外)
		end
**/
%>


  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			/* 跨地市、不是10014省级工号、不是客服工号 的不允许办理
				 10014的工号可以办理
				 客服工号可以办理
			*/
			
			if("<%=regionCode%>"!="<%=regCodegp%>" && "10014"!="<%=groupID%>" && "<%=accountType%>" != "2")
			{
				rdShowMessageDialog("跨地市不允许进行上网日志查询操作！",0);
				removeCurrentTab();
			}
			
		});
		
		function doCommit(flag){
			
			var startCust = $("#startCust").val();
			var endCust = $("#endCust").val();
			
			if($("#startCust").val().length == 0 || $("#endCust").val().length == 0 ){
				rdShowMessageDialog("请输入开始结束时间！",0);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm386/fm386Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "<%=phoneNo%>";
			var iUserPwd = "";
			var opNote = startCust+"--"+endCust;
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("opNote",opNote);
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
			
			var acName = "用户上网日志查询/流量占比";
			var iWidth = window.screen.availWidth-100; //弹出窗口的宽度;
			var iHeight = window.screen.availHeight-100; //弹出窗口的高度;
			var iTop = "70";
			var iLeft ="240";
			var acPath = "";
			var param = "";
			/*测试环境*/
			if(flag == "3"){
				//acPath = "http://10.110.180.71:80/DPI/NetLogQuery?1=1";
				acPath = "http://10.110.180.71:9000/KFMain/Index?Kfuser="+iLoginNo+"&Pass=<%=loginName_jiami%>&phonenum="+iPhoneNo+"&typecode="+flag+"&starttime="+startCust+"&endtime="+endCust;
			}else if(flag == "4"){
				//acPath = "http://10.110.180.71:80/DPI/AppDutyQuery";
				acPath = "http://10.110.180.71:9000/KFMain/Index?Kfuser="+iLoginNo+"&Pass=<%=loginName_jiami%>&phonenum="+iPhoneNo+"&typecode="+flag+"&starttime="+startCust+"&endtime="+endCust;
			}
			//alert(acPath);
			/*上线环境
			acPath = "http://10.117.80.38:8011/MdiEntry.aspx?Kfuser="+iLoginNo+"&Pass=<%=loginName_jiami%>&phonenum="+iPhoneNo+"&typecode="+flag+"&starttime="+startCust+"&endtime="+endCust;
			http://10.110.180.71:9000/DPI/NetLogQuery?Kfuser=806661&Pass=F20019C6889EFB669F372D776120C056&phonenum=15845006700&typecode=3&starttime =？&endtime=？
			http://10.110.180.71:9000/DPI/AppDutyQuery?Kfuser=806661&Pass=F20019C6889EFB669F372D776120C056&phonenum=15845006700&typecode=3&starttime =？&endtime=？
			*/
			//alert(acPath);
			window.open(acPath,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=yes');
			
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			if(retCode == "000000"){
				
				
			}else{
				
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		
		
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">手机号码</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="phoneNo" name="phoneNo" class="InputGrey" readonly value="<%=phoneNo%>"/>&nbsp;&nbsp;
	  		</td>
	    </tr>
	     <tr>
      	<td class="blue">开始时间</td>
				<td>
						<input type="text" id="startCust" v_must="1" value="<%=date1%>" name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								First. onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
				<td class="blue">结束时间</td>
				<td>
					<input type="text" id="endCust" v_must="1" value="<%=date2%>"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})"/>
								<img id = "imgCustEnd" 
									onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})" 
				 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
      </tr>
	  </table>
	 <div>
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<!-- <input class="b_foot" id="configBtn" name="configBtn"  type="button" value="上网日志查询"   onclick="doCommit('3');">&nbsp;&nbsp; -->
				<input class="b_foot" id="configBtn2" name="configBtn2"  type="button" value="上网流量占比"   onclick="doCommit('4');">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
		</tr>
		
		</table>
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="oCustId" id="oCustId" value=""/>
	 

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
