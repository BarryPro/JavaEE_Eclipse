<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
   * ����: gaopeng
   * ��Ȩ: si-tech
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




	public String readValue(String param1,String param2,String param3,String paths) {//����keyֵ��·����ѯproperties�ļ���rdmessage��Ϣ
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
 
 //���·���Ϊ���ܷ���
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
	//ÿ��byte�������ַ����ܱ�ʾ�������ַ����ĳ��������鳤�ȵ�����
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//�Ѹ���ת��Ϊ����
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//С��0F������Ҫ��ǰ�油0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}

private Key getKey(byte[] arrBTmp) throws Exception {
	//����һ���յ�8λ�ֽ����飨Ĭ��ֵΪ0��
	byte[] arrB = new byte[8];
	//��ԭʼ�ֽ�����ת��Ϊ8λ
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//������Կ
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
		20130219gaopeng�޸ģ�������ѯ��ǰ������ֻ�����Ĺ��������뵱ǰ��¼���ŵĹ������У����������а����ҵ��(����aaa8zy����)
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
		20130219gaopeng�޸ģ�������ѯ��ǰ������ֻ�����Ĺ��������뵱ǰ��¼���ŵĹ������У����������а����ҵ��(����aaa8zy����)
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
			
			/* ����С�����10014ʡ�����š����ǿͷ����� �Ĳ��������
				 10014�Ĺ��ſ��԰���
				 �ͷ����ſ��԰���
			*/
			
			if("<%=regionCode%>"!="<%=regCodegp%>" && "10014"!="<%=groupID%>" && "<%=accountType%>" != "2")
			{
				rdShowMessageDialog("����в��������������־��ѯ������",0);
				removeCurrentTab();
			}
			
		});
		
		function doCommit(flag){
			
			var startCust = $("#startCust").val();
			var endCust = $("#endCust").val();
			
			if($("#startCust").val().length == 0 || $("#endCust").val().length == 0 ){
				rdShowMessageDialog("�����뿪ʼ����ʱ�䣡",0);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm386/fm386Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
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
			
			var acName = "�û�������־��ѯ/����ռ��";
			var iWidth = window.screen.availWidth-100; //�������ڵĿ��;
			var iHeight = window.screen.availHeight-100; //�������ڵĸ߶�;
			var iTop = "70";
			var iLeft ="240";
			var acPath = "";
			var param = "";
			/*���Ի���*/
			if(flag == "3"){
				//acPath = "http://10.110.180.71:80/DPI/NetLogQuery?1=1";
				acPath = "http://10.110.180.71:9000/KFMain/Index?Kfuser="+iLoginNo+"&Pass=<%=loginName_jiami%>&phonenum="+iPhoneNo+"&typecode="+flag+"&starttime="+startCust+"&endtime="+endCust;
			}else if(flag == "4"){
				//acPath = "http://10.110.180.71:80/DPI/AppDutyQuery";
				acPath = "http://10.110.180.71:9000/KFMain/Index?Kfuser="+iLoginNo+"&Pass=<%=loginName_jiami%>&phonenum="+iPhoneNo+"&typecode="+flag+"&starttime="+startCust+"&endtime="+endCust;
			}
			//alert(acPath);
			/*���߻���
			acPath = "http://10.117.80.38:8011/MdiEntry.aspx?Kfuser="+iLoginNo+"&Pass=<%=loginName_jiami%>&phonenum="+iPhoneNo+"&typecode="+flag+"&starttime="+startCust+"&endtime="+endCust;
			http://10.110.180.71:9000/DPI/NetLogQuery?Kfuser=806661&Pass=F20019C6889EFB669F372D776120C056&phonenum=15845006700&typecode=3&starttime =��&endtime=��
			http://10.110.180.71:9000/DPI/AppDutyQuery?Kfuser=806661&Pass=F20019C6889EFB669F372D776120C056&phonenum=15845006700&typecode=3&starttime =��&endtime=��
			*/
			//alert(acPath);
			window.open(acPath,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=yes');
			
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			if(retCode == "000000"){
				
				
			}else{
				
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
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
	  		<td width="20%" class="blue">�ֻ�����</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="phoneNo" name="phoneNo" class="InputGrey" readonly value="<%=phoneNo%>"/>&nbsp;&nbsp;
	  		</td>
	    </tr>
	     <tr>
      	<td class="blue">��ʼʱ��</td>
				<td>
						<input type="text" id="startCust" v_must="1" value="<%=date1%>" name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								First. onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
				<td class="blue">����ʱ��</td>
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
				<!-- <input class="b_foot" id="configBtn" name="configBtn"  type="button" value="������־��ѯ"   onclick="doCommit('3');">&nbsp;&nbsp; -->
				<input class="b_foot" id="configBtn2" name="configBtn2"  type="button" value="��������ռ��"   onclick="doCommit('4');">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
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
