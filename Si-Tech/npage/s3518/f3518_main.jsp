<%
   /*
   * ����: ���Ų�Ʒ��۵���
�� * �汾: v1.0
�� * ����: 2006/10/30
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.GregorianCalendar"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%!
	public String returnValue(String star,String end){
	  String valuess="0";
    SimpleDateFormat localTime=new SimpleDateFormat("yyyyMMdd");
    try{
        Date sdate = localTime.parse(star);
        Date edate=localTime.parse(end);
        long time = System.currentTimeMillis();
        System.out.println(time+"##"+sdate.getTime()+"##"+edate.getTime());
        if(time>=sdate.getTime()&& time<=edate.getTime()){
            System.out.println("true");
            valuess="1";           
        }
        return valuess;
    }catch(Exception e){
      valuess="0";
      return valuess;
    }
  }
%>
	
<%	
	//��ȡ�û�session��Ϣ
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                     //��½����
	String mrzsnr="";
	
	Logger logger = Logger.getLogger("f3518_main.jsp");
	
    String opCode = "3518";
    String opName = "���Ų�Ʒ��۵���";
	String id_no = request.getParameter("id_no");
	String id_iccid = request.getParameter("id_iccid");
	String unit_id = request.getParameter("unit_id");
	String cust_id = request.getParameter("cust_id");
	String unit_name = request.getParameter("unit_name");

	String strDate = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	System.out.println("@@"+sdf);
	GregorianCalendar cal = new GregorianCalendar();
	cal.setTime(new Date());
	
	strDate = sdf.format(cal.getTime());
	
	cal.add(GregorianCalendar.MONTH, 1);
	strDate = sdf.format(cal.getTime());
	System.out.println("##"+strDate);
	strDate = strDate.substring(0,6)+"01";
	System.out.println("**"+strDate);
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	String[][] result = new String[][]{};
	String paraArr[] = new String[3];
	paraArr[0] = id_no;
	paraArr[1] = workNo;
	paraArr[2] = cust_id;
	System.out.println("====wanghfa====f3518_main.jsp==== paraArr[0] = " + paraArr[0]);
	System.out.println("====wanghfa====f3518_main.jsp==== paraArr[1] = " + paraArr[1]);
	System.out.println("====wanghfa====f3518_main.jsp==== paraArr[2] = " + paraArr[2]);
	
	//acceptList = impl.callFXService("s3518QryID",paraArr,"13");
%>
    <wtc:service name="s3518QryIDEXC" retcode="retCode" retmsg="retMsg" outnum="16" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/> 
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
	String errCode=retCode;   
	String errMsg=retMsg; 
	if("000000".equals(errCode)){
	    result = retArr;
%>


<script type="text/javascript">
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
    //core.rpc.onreceive = doProcess;
}
	var oldrow = -1;
	var nowrow = -1;
	var sflagcheck="0";

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
	
function doModify()
{
	var j=0;
	var idNo = new Array();
	var priceType = new Array();
	var productCode = new Array();
	var priceValue = new Array();
	var beginTime = new Array();
	var endTime = new Array();
	var hiddenBeginTime = new Array();
	var hiddenEndTime = new Array();
	var service_type = new Array();
	var service_code = new Array();
	var price_code = new Array();
	var login_accept = new Array();
	var yyhzs=new Array();
	if(<%=result.length%>!="1")
	{
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
			if(document.all.checkbox1[i].checked)
			{	
				if(!forDate(document.all.beginTime[i]))
				{
					return;
				}
				if(!forDate(document.all.endTime[i]))
				{
					return;
				}
				if(document.all.beginTime[i].value < <%=strDate%>)
				{
					rdShowMessageDialog("��ʼʱ��Ӧ������1��֮��!");
					document.all.beginTime[i].focus();
					return;
				}
				if(document.all.beginTime[i].value > document.all.endTime[i].value)
				{
					rdShowMessageDialog("��ʼʱ��Ӧ�ڽ���ʱ��֮ǰ!");
					document.all.beginTime[i].focus();
					return;
				}
				if(document.all.endTime[i].value > 20500101)
				{
					rdShowMessageDialog("����ʱ��Ӧ��20500101֮ǰ!");
					document.all.endTime[i].focus();
					return;
				}
				var youhuimax;
				var youhuistr;
				if(document.all("priceType"+i)[0].checked==true)
				{
					priceType[j]=document.all("priceType"+i)[0].value;
					document.all.priceValue[i].v_type="float";
					document.all.priceValue[i].v_name="������ݣ�����(������������С�������λ)";
					document.all.priceValue[i].v_maxlength="4";
					$("input[name='priceValue']").each(function(){
					    if(!forReal(this)){
    						return;
    					}
				    });

					if(document.all.priceValue[i].value <=0 || document.all.priceValue[i].value >1)
					{
						rdShowMessageDialog("����ʱ���ֵӦ��0��1֮���С��,С���������λ����!");
						document.all.priceValue[i].focus();
						return;
					}
					
					
				if(document.all("isyhhzs_" + i).value=="0"){
			
				}else {
			
					
						if(document.all("youhuihzs_" + i).value=="") {
						rdShowMessageDialog("��������ߴ���Ϣ");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("priceolds" + i).value)*(1-parseFloat(document.all.priceValue[i].value))).toFixed(2);
					if(parseFloat(document.all("youhuihzs_" + i).value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("��ߴ�������д�����ֵΪ"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_" + i).select();
						document.all("youhuihzs_" + i).focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_" + i).value)<youhuimax) {
							rdShowMessageDialog("��ߴ�������д����СֵΪ"+youhuimax);
						document.all("youhuihzs_" + i).select();
						document.all("youhuihzs_" + i).focus();
							return false;						
					}
					youhuistr=(parseFloat(document.all("youhuihzs_" + i).value).toFixed(2)-youhuimax).toFixed(2);
					
				}
					
				}
				else
				{
					priceType[j]=document.all("priceType"+i)[1].value;
					document.all.priceValue[i].v_type="money";
					document.all.priceValue[i].v_name="������ݣ��Ż�(���)";
					document.all.priceValue[i].v_maxlength="16.2";
					//if(!forMoney(document.all.priceValue[i]))
					if(!forReal(document.all.priceValue[i]))
					{
						return;
					}
					if(document.all.priceValue[i].value.indexOf(".") != -1){
						if(document.all.priceValue[i].value.toString().split(".")[1] != "00"){
							rdShowMessageDialog("�Ż�ʱ��С�������λ���ֱ���Ϊ00!");
							return;
						}
					}
					
					if(document.all("isyhhzs_" + i).value=="0"){
			
				}else {
			
					
						if(document.all("youhuihzs_" + i).value=="") {
						rdShowMessageDialog("��������ߴ���Ϣ");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("priceolds" + i).value)-parseFloat(document.all.priceValue[i].value)).toFixed(2);
					if(parseFloat(document.all("youhuihzs_" + i).value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("��ߴ�������д�����ֵΪ"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_" + i).select();
						document.all("youhuihzs_" + i).focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_" + i).value)<youhuimax) {
							rdShowMessageDialog("��ߴ�������д����СֵΪ"+youhuimax);
						document.all("youhuihzs_" + i).select();
						document.all("youhuihzs_" + i).focus();
							return false;						
					}
					youhuistr=(parseFloat(document.all("youhuihzs_" + i).value).toFixed(2)-youhuimax).toFixed(2);
					
				}
				
				}
				
				
				
				priceValue[j]=document.all.priceValue[i].value;
				productCode[j]=document.all.productCode[i].value;
				beginTime[j]=document.all.beginTime[i].value;
				endTime[j]=document.all.endTime[i].value;
				hiddenBeginTime[j]=document.all.hiddenBeginTime[i].value;
				hiddenEndTime[j]=document.all.hiddenEndTime[i].value;
				service_type[j]=document.all.serviceType[i].value;
				service_code[j]=document.all.serviceCode[i].value;
				price_code[j]=document.all.priceCode[i].value;
				login_accept[j]=document.all.loginAccept[i].value;
				

				if(document.all("isyhhzs_" + i).value=="0"){
					yyhzs[j]="0.00";
				}else {
					yyhzs[j]=youhuistr;
				}
				
				

				
					var myPacketsd = new AJAXPacket("/npage/s3690/ajax_checkYJMessage.jsp","����У���������Ժ����Ժ�......");
					myPacketsd.data.add("offerids",document.all.productCode[i].value);
					myPacketsd.data.add("oldpricess",document.all.priceCode[i].value);
					myPacketsd.data.add("flagss",priceType[j]);
					myPacketsd.data.add("userPrice",document.all.priceValue[i].value);
					myPacketsd.data.add("opcode","3518");
					core.ajax.sendPacket(myPacketsd,checksimtypesd);
					myPacketsd=null;
					
					if(sflagcheck=="1") {
					break;
					}
					
				j++;
			}
		}
	} 
	else
	{
		if(document.all.checkbox1.checked)
		{	
			if(!forDate(document.all.beginTime))
			{
				return;
			}
			if(!forDate(document.all.endTime))
			{
				return;
			}
			if(document.all.beginTime.value < <%=strDate%>)
			{
				rdShowMessageDialog("��ʼʱ��Ӧ������1��֮��!");
				document.all.beginTime.focus();
				return;
			}
			if(document.all.beginTime.value > document.all.endTime.value)
			{
				rdShowMessageDialog("��ʼʱ��Ӧ�ڽ���ʱ��֮ǰ!");
				document.all.beginTime.focus();
				return;
			}
			if(document.all.endTime.value > 20500101)
			{
				rdShowMessageDialog("����ʱ��Ӧ��20500101֮ǰ!");
				document.all.endTime.focus();
				return;
			}
			var youhuimax;
			var youhuistr;
			if(document.all.priceType0[0].checked==true)
			{
				priceType[j]=document.all.priceType0[0].value;
				document.all.priceValue.v_type="float";
				document.all.priceValue.v_name="������ݣ�����(������������С�������λ)";
				document.all.priceValue.v_maxlength="4";
				if(!forReal(document.all.priceValue))
				{
					return;
				}
				if(document.all.priceValue.value <=0 || document.all.priceValue.value >=1)
				{
					rdShowMessageDialog("����ʱ���ֵӦ��0��1֮���С��,С���������λ����!");
					document.all.priceValue.focus();
					return;
				}
				
				if(document.all("isyhhzs_0").value=="0"){
					
				}else {
					
					
						if(document.all("youhuihzs_0").value=="") {
						rdShowMessageDialog("��������ߴ���Ϣ");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("priceolds0").value)*(1-parseFloat(document.all.priceValue.value))).toFixed(2);
					if(parseFloat(document.all("youhuihzs_0").value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("��ߴ�������д�����ֵΪ"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_0").select();
						document.all("youhuihzs_0").focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_0").value)<youhuimax) {
							rdShowMessageDialog("��ߴ�������д����СֵΪ"+youhuimax);
						document.all("youhuihzs_0").select();
						document.all("youhuihzs_0").focus();
							return false;						
					}
					
					youhuistr=(parseFloat(document.all("youhuihzs_0").value).toFixed(2)-youhuimax).toFixed(2);
					
				}
				
			}
			else
			{
				priceType[j]=document.all.priceType0[1].value;
				document.all.priceValue.v_type="money";
				document.all.priceValue.v_name="������ݣ��Ż�(���)";
				document.all.priceValue.v_maxlength="16.2";
				//if(!forMoney(document.all.priceValue))
				if(!forReal(document.all.priceValue))
				{
					return;
				}
	    	if(document.all.priceValue.value.indexOf(".") != -1){
					if(document.all.priceValue.value.toString().split(".")[1] != "00"){
						rdShowMessageDialog("�Ż�ʱ��С�������λ���ֱ���Ϊ00!");
						return;
					}
				}
				
				if(document.all("isyhhzs_0").value=="0"){
					
				}else {
					
					
						if(document.all("youhuihzs_0").value=="") {
						rdShowMessageDialog("��������ߴ���Ϣ");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("priceolds0").value)-parseFloat(document.all.priceValue.value)).toFixed(2);
					if(parseFloat(document.all("youhuihzs_0").value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("��ߴ�������д�����ֵΪ"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_0").select();
						document.all("youhuihzs_0").focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_0").value)<youhuimax) {
							rdShowMessageDialog("��ߴ�������д����СֵΪ"+youhuimax);
						document.all("youhuihzs_0").select();
						document.all("youhuihzs_0").focus();
							return false;						
					}
					youhuistr=(parseFloat(document.all("youhuihzs_0").value).toFixed(2)-youhuimax).toFixed(2);
					
				}
				
			}

			
			priceValue[j]=document.all.priceValue.value;
			productCode[j]=document.all.productCode.value;
			beginTime[j]=document.all.beginTime.value;
			endTime[j]=document.all.endTime.value;
			hiddenBeginTime[j]=document.all.hiddenBeginTime.value;
			hiddenEndTime[j]=document.all.hiddenEndTime.value;
			service_type[j]=document.all.serviceType.value;
			service_code[j]=document.all.serviceCode.value;
			price_code[j]=document.all.priceCode.value;
			login_accept[j]=document.all.loginAccept.value;
			
			 if(document.all("isyhhzs_0").value=="0"){
					yyhzs[j]="0.00";
				}else {
					yyhzs[j]=youhuistr;
				}
					
					var myPacketsd = new AJAXPacket("/npage/s3690/ajax_checkYJMessage.jsp","����У���������Ժ����Ժ�......");
					myPacketsd.data.add("offerids",document.all.productCode.value);
					myPacketsd.data.add("oldpricess",document.all.priceCode.value);
					myPacketsd.data.add("flagss",priceType[j]);
					myPacketsd.data.add("userPrice",document.all.priceValue.value);
					myPacketsd.data.add("opcode","3518");
					core.ajax.sendPacket(myPacketsd,checksimtypesd);
					myPacketsd=null;
 
			j++;
		}
	}   
	if(j==0)
	{   
		rdShowMessageDialog("��ѡ��һ����Ϣ!");
		return;
	}   
	
	var vPriceValue = priceValue.join(",");
	var vProductCode = productCode.join(",");
	var vBeginTime = beginTime.join(",");
	var vEndTime = endTime.join(",");
	var vHiddenBeginTime = hiddenBeginTime.join(",");
	var vHiddenEndTime = hiddenEndTime.join(",");
	var vService_type = service_type.join(",");
	var vService_code = service_code.join(",");
	var vPrice_code = price_code.join(",");
	var vLogin_accept = login_accept.join(",");
	var vPriceType = priceType.join(",");
	var vyyhzs=yyhzs.join(",");

	if(sflagcheck=="0") {
	
	var getSysAccept_Packet = new AJAXPacket("f3518_cfm.jsp","�����ύ���������Ժ�......");
	getSysAccept_Packet.data.add("retType","cfm");
	getSysAccept_Packet.data.add("idNo",<%=id_no%>);
	getSysAccept_Packet.data.add("productCode",vProductCode);
	getSysAccept_Packet.data.add("priceType",vPriceType);
	getSysAccept_Packet.data.add("priceValue",vPriceValue);
	getSysAccept_Packet.data.add("beginTime",vBeginTime);
	getSysAccept_Packet.data.add("endTime",vEndTime);
	getSysAccept_Packet.data.add("hiddenBeginTime",vHiddenBeginTime);
	getSysAccept_Packet.data.add("hiddenEndTime",vHiddenEndTime);
	getSysAccept_Packet.data.add("service_type",vService_type);
	getSysAccept_Packet.data.add("service_code",vService_code);
	getSysAccept_Packet.data.add("price_code",vPrice_code);
	getSysAccept_Packet.data.add("login_accept",vLogin_accept);
	getSysAccept_Packet.data.add("yyhzs",vyyhzs);
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null; 
	
}
        
} 
  function checksimtypesd(packet) {
 var retcode = packet.data.findValueByName("retcode");
 var retmsg = packet.data.findValueByName("retmsg");
  var retprodids = packet.data.findValueByName("retprodids");

 		if(retcode!="000000") {
 		rdShowMessageDialog("��Ʒ"+retprodids+"У��ʧ�ܣ�������룺"+retcode+"������ԭ��"+retmsg);
 			sflagcheck="1";
 		}
 		else {
 			sflagcheck="0";
 		}
 
 }
 
       
        
function doProcess(packet)
{       
    var qryType = packet.data.findValueByName("qryType");
    var errCode = packet.data.findValueByName("errCode");
    var errMsg = packet.data.findValueByName("errMsg");
    self.status="";
    if(parseInt(errCode)!=0)
	{   
		rdShowMessageDialog("������룺"+errCode+",������Ϣ��"+errMsg,0);
		return false;
	}   
	else
	{   
		rdShowMessageDialog("�����ɹ���",2);
		history.go(-1);
	}   
}       
        
function beginTimeChange(num)
{ 

			soncheckbox(num);
	
	   
	if(<%=result.length%>=="1")
	{   
		document.all.beginTime.value="<%=strDate%>";
	}   
	else
	{   
		document.all.beginTime[num].value="<%=strDate%>";	
	} 
}  

function sOnclicks(num) {

			if (document.all("isyhhzs_" + num).value=="1") {

	if(<%=result.length%>!="1")
	{
			if(document.all.priceValue[num].value!="") {
				var youhuimax;
				if(document.all("priceType"+num)[0].checked==true)
				{
						youhuimax=parseFloat(Math.abs(document.all("priceolds" + num).value)*(1-parseFloat(document.all.priceValue[num].value))).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;			
				    //$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");
				    soncheckbox(num);
				}
				if(document.all("priceType"+num)[1].checked==true)
				{
						youhuimax=parseFloat(Math.abs(document.all("priceolds" + num ).value)-parseFloat(document.all.priceValue[num].value)).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;		
				    soncheckbox(num);			
				}
			}
		}else {
						if(document.all.priceValue.value!="") {
				var youhuimax;
				if(document.all("priceType"+num)[0].checked==true)
				{
						youhuimax=parseFloat(Math.abs(document.all("priceolds" + num).value)*(1-parseFloat(document.all.priceValue.value))).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;	
				    //$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");		
				    soncheckbox(num);
				}
				if(document.all("priceType"+num)[1].checked==true)
				{
						youhuimax=parseFloat(Math.abs(document.all("priceolds" + num ).value)-parseFloat(document.all.priceValue.value)).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;		
				    soncheckbox(num);			
				}
			}
		
		}
	}

}

function soncheckbox(num) {
	
	if(<%=result.length%>!="1")
	{
	for(var i=0;i<document.all.checkbox1.length;i++)
		{
		
			if(document.all.checkbox1[i].checked)
			{	
				if(document.all("priceType"+i)[1].checked==true)
				{	
					
				   if (document.all("isyhhzs_" + i).value=="1") {		
		var dixianxianshi;
		var youhhzsxianshi;
		
							dixianxianshi=parseFloat(Math.abs(document.all("priceolds" + i).value)-parseFloat(document.all.priceValue[i].value)).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_" + i).value);
					    $("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ;����"+dixianxianshi+"����ߴ�"+youhhzsxianshi+"��");					
					}else {
							$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");
					}
	
			}else if(document.all("priceType"+i)[0].checked==true){
				
											   if (document.all("isyhhzs_" + i).value=="1") {		
		var dixianxianshi;
		var youhhzsxianshi;
		
							dixianxianshi=parseFloat(Math.abs(document.all("priceolds" + i).value)*(1-parseFloat(document.all.priceValue[i].value))).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_" + i).value);
					    $("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ;����"+dixianxianshi+"����ߴ�"+youhhzsxianshi+"��");					
					}else {
							$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");
					}
			}
	   
	}
}

}else {

		
					if(document.all.checkbox1.checked)
			{	
				if(document.all("priceType0")[1].checked==true)
				{	
					
				   if (document.all("isyhhzs_0").value=="1") {		
		var dixianxianshi;
		var youhhzsxianshi;
	
							dixianxianshi=parseFloat(Math.abs(document.all("priceolds0").value)-parseFloat(document.all.priceValue.value)).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_0").value);
					    $("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ;����"+dixianxianshi+"����ߴ�"+youhhzsxianshi+"��");					
					}else {
							$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");
					}
	
			}else if(document.all("priceType0")[0].checked==true){
				
											   if (document.all("isyhhzs_0").value=="1") {		
		var dixianxianshi;
		var youhhzsxianshi;
	
							dixianxianshi=parseFloat(Math.abs(document.all("priceolds0").value)*(1-parseFloat(document.all.priceValue.value))).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_0").value);
					    $("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ;����"+dixianxianshi+"����ߴ�"+youhhzsxianshi+"��");					
					}else {
							$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");
					}
			}
	   
	}else {
	
	$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");
	
	}

}
}


function clearNoNum(obj){   obj.value = obj.value.replace(/[^\d.]/g,"");  //��������֡��͡�.��������ַ�  

 obj.value = obj.value.replace(/^\./g,"");  //��֤��һ���ַ������ֶ�����. 

  obj.value = obj.value.replace(/\.{2,}/g,"."); //ֻ������һ��. ��������.   

obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");

} 

function shuzicheck(obj) {
	if(obj.value.indexOf(".")!=-1) {
	obj.value=parseFloat(obj.value).toFixed(2)
 }
}    
		
</script>
</head> 
<BODY>
<FORM method="post" name="form1" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ų�Ʒ��۵���</div>
</div>
<table cellspacing=0>
  <tr> 
    <td class='blue'> 
		֤������
    </td>
    <td colspan="3"> 
		<input type="text" name="id_iccid" value="<%=id_iccid%>" readonly disabled>
    </td>
  </tr>
  <tr> 
    <td class='blue'> 
		���ű��
    </td>
    <td> 
		<input type="text" name="unit_id" value="<%=unit_id.trim()%>" readonly disabled>
    </td>
    <td class='blue'> 
		��������
    </td>
    <td> 
		<input type="text" name="unit_name" value="<%=unit_name.trim()%>" readonly disabled>
    </td>
  </tr>  
</table>
<table cellspacing="0">
	<tr>
		<th>ѡ��</th>
		<th>��Ʒ����</th>
		<th>��Ʒ����</th>
		<th>�������</th>
		<th>��������</th>
		<th>ԭʼ�۸�</th>
		<th>�������</th>				
		<th>��ʼʱ��</th>
		<th>����ʱ��</th>
	</tr>
<%
		
for(int i = 0; i <result.length; i++)
{	
	      	/*result[0][13]="0";
      		result[1][13]="1";
      		result[2][13]="0";
      		result[3][13]="1";
       		result[0][14]="";
      		result[1][14]="4000";    
      		result[2][14]="";  
      		result[3][14]="5000";  */
%>
    <tr>
		<td><input type="checkbox" name="checkbox1" onclick="beginTimeChange('<%=i%>')" value="<%=result[i][0]%>" <%if(result[i][9].equals(strDate)==true){%>disabled<%}else{}%>></td>
		<td><input type="text" name="productCode" value="<%=result[i][1]%>" size="10" class="button4" style="background='<%if((i+1)%2==1){%>#F5F5F5<%}else{%>#E8E8E8<%}%>'" readonly></td>
		<td><%=result[i][2]%></td>
	    <td><input type="text" name="serviceCode" value="<%=result[i][3]%>" size="10" class="button4" style="background='<%if((i+1)%2==1){%>#F5F5F5<%}else{%>#E8E8E8<%}%>'" readonly></td>
		<td><input type="hidden" name="serviceType" value="<%=result[i][4]%>" size="10" class="button4" style="background='<%if((i+1)%2==1){%>#F5F5F5<%}else{%>#E8E8E8<%}%>'" readonly><input type="text" name="serviceTypeName" value="<%=result[i][12]%>" size="10" class="button4" style="background='<%if((i+1)%2==1){%>#F5F5F5<%}else{%>#E8E8E8<%}%>'" readonly></td>
		<td><%=result[i][5]%><input type="hidden" name="priceolds<%=i%>" value="<%=result[i][5]%>"></td>			
	    <td>
	    	<input type="radio" onClick='sOnclicks(<%=i%>)' name="priceType<%=i%>" value="0" <%=result[i][6].equals("0")==true?"checked":""%>>����
	    	<input type="radio" onClick='sOnclicks(<%=i%>)' name="priceType<%=i%>" value="1" <%=result[i][6].equals("1")==true?"checked":""%>>�Ż�&nbsp;
	    	ֵ<input type="text" id="priceValue" onBlur='sOnclicks(<%=i%>)' name="priceValue" value="<%=result[i][7]%>" size="10" v_must="1">
	    	<input type=hidden name="isyhhzs_<%=i%>" value="<%=result[i][14]%>">
	    	<%
	    	     if("1".equals(result[i][14])) {
	    	     //out.println(returnValue(result[i][8],result[i][9]).equals("1"));
	    	         if(returnValue(result[i][8],result[i][9]).equals("1")) {
	    	     		 mrzsnr="ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ;����"+result[i][13]+"����ߴ�"+result[i][15]+"��";	    	     		 
	    	     		 }
	      		     if("".equals(result[i][15])) {
	      		     %>
	      		       &nbsp;��ߴ�&nbsp;<input type=text v_name='��ߴ�' onblur='shuzicheck(this);soncheckbox(<%=i%>);'  onkeyup='clearNoNum(this)' size=10 name='youhuihzs_<%=i%>' value='0' >
	      		       <%
	      		     }else {
	      		     	%>
	      		     	 &nbsp;��ߴ�&nbsp;<input type=text v_name='��ߴ�' onblur='shuzicheck(this);soncheckbox(<%=i%>);'  onkeyup='clearNoNum(this)' size=10 name='youhuihzs_<%=i%>' value='<%=result[i][15]%>' >
	      		     	 <%
	      		     }
      		    }else {
      		
      		  	}
      		  	%>
      		  	
	    </td>
		<td><input type="text" id="beginTime" name="beginTime" value="<%=result[i][8]%>" readOnly class="InputGrey" size="8" v_format = "yyyyMMdd" v_type="date" v_must="1" v_name="��ʼʱ��" maxlength="8"></td>
		<td><input type="text" id="endTime" name="endTime" value="<%=result[i][9]%>" readOnly class="InputGrey" size="8" v_format = "yyyyMMdd" v_type="date" v_must="1" v_name="����ʱ��" maxlength="8"></td>
		<input type="hidden" name="priceCode" value="<%=result[i][10]%>">
		<input type="hidden" name="loginAccept" value="<%=result[i][11]%>">
		<input type="hidden" id="hiddenBeginTime" name="hiddenBeginTime" value="<%=result[i][8]%>">
		<input type="hidden" id="hiddenEndTime" name="hiddenEndTime" value="<%=result[i][9]%>">
</tr>
<%
	}
}	
else{
%>
	<script language="javascript" >
		rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>",0);
		history.go(-1);
	</script>
<%
}
%>	
 	<tr>
 		<td colspan="9" style="text-align:right;">
 			<font class="orange" id="keShowSpan"><%if(!"".equals(mrzsnr)){out.print(mrzsnr);}else{%>ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ<%}%></font>
 		</td>
	</tr>
</table>
<table cellspacing=0>
  <tr id="footer"> 
    <td> 
        <input name="confirm" type="button" class="b_foot" value="�޸�" onClick="doModify()">
        <input name="back" type="button" class="b_foot" value="����" onClick="history.go(-1)">
        <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
    </td>
  </tr> 
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

