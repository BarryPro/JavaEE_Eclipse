<%
/********************
 version v2.0
 ������: si-tech
 update by liutong @ 2008.09.03
 update by qidp @ 2009-08-18 for ���ݶ˵�������
********************/
%>
<%--baixf modify 20070815 �ͻ������ݵ�¼�����Ƿ��м��ſͻ�����Ȩ�޶���ʾ���š�ec����
    op_code:1993 ���ſͻ�����
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%> <!--����֤-->
<%        
	//Logger logger = Logger.getLogger("f1100_1.jsp");
	//ArrayList retArray = new ArrayList();
	//String[][] result = new String[][]{};
	// S1100View callView = new S1100View(); 
	String printAccept = "";
	String IccIdAccept="";
%>
<%
		/**        
		ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String[][] agentInfo = (String[][])arr.get(2);
		String workNo = baseInfo[0][2];
		String workName = baseInfo[0][3];
		String Role = baseInfo[0][5];
		String Department = baseInfo[0][16];
		String belongCode = Department.substring(0,7);
		String ip_Addr = agentInfo[0][2];
		String regionCode = Department.substring(0,2);
		String districtCode = Department.substring(2,4);
		String rowNum = "16";
		String getAcceptFlag = "";
		**/		
        				      				
		String opCode = "1100";
		String opName = "�ͻ�����";
		String workNo =(String)session.getAttribute("workNo");
		String workName =(String)session.getAttribute("workName");
		String powerRight =(String)session.getAttribute("powerRight");
		String Role =(String)session.getAttribute("Role");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String ip_Addr =(String)session.getAttribute("ip_Addr");
		String belongCode =orgCode.substring(0,7);
		String districtCode =orgCode.substring(2,4);
		String rowNum = "16";
		String getAcceptFlag = "";
%>
<%
   /**     //ȡ�ô�ӡ��ˮ
        try
        {
                String sqlStr ="select sMaxSysAccept.nextval from dual";
                retArray = callView.view_spubqry32("1",sqlStr);
                result = (String[][])retArray.get(0);
                printAccept = (result[0][0]).trim();
        }catch(Exception e){
                out.println("rdShowMessageDialog('ȡϵͳ������ˮʧ�ܣ�',0);");
                getAcceptFlag = "failed";
        }    
        **/
     String sqlStrl ="select sMaxSysAccept.nextval from dual";
    //ȡ�ô�ӡ��ˮ(�滻ԭejb)   ��ҳ����� 20080828
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel" retmsg="retMsgl" outnum="1">
		<wtc:sql><%=sqlStrl%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultl" scope="end" />
	<%
		if(retCodel.equals("000000")){
		  	printAccept = (resultl[0][0]).trim();
                	IccIdAccept = printAccept;/*wangdana add*/
		}else{
			getAcceptFlag = "failed";
		}               
	String sqlStrl0 ="SELECT count(*) FROM dChnGroupMsg a,dbChnAdn.sChnClassMsg b WHERE a.group_id='"+groupId+"' AND a.is_active='Y' AND a.class_code=b.class_code AND b.class_kind='2'";  
	%> 
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel0" retmsg="retMsgl0" outnum="1">
		<wtc:sql><%=sqlStrl0%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultl0" scope="end" />
	<%
	/* add by qidp @ 2009-08-12 for ���ݶ˵������� . */
	    String inputFlag = (String)request.getParameter("inputFlag");   //��ʾλ��ֵΪ1ʱ��ʾ�Ǵ����۷���ת��
	    /*
	    String cont_tp = "";
	    String group_name = "";
	    String cont_user = "";
	    String cont_mobile = "";
	    String cont_addr = "";
	    String cont_email = "";
	    String cont_zip = "";
	    */
	    System.out.println("# inputFlag = "+inputFlag);
	    
	    /*
	    if("1".equals(inputFlag)){
	        cont_tp = (String)request.getParameter("cont_tp");          //���ſͻ�����
    	    group_name = (String)request.getParameter("group_name");    //���ſͻ�����
    	    cont_user = (String)request.getParameter("cont_user");      //���ſͻ���ϵ��
    	    cont_mobile = (String)request.getParameter("cont_mobile");  //���ſͻ���ϵ�绰
    	    cont_addr = (String)request.getParameter("cont_addr");      //���ſͻ���ϵ��ַ
    	    cont_email = (String)request.getParameter("cont_email");    //���ſͻ���ϵ����
    	    cont_zip = (String)request.getParameter("cont_zip");        //���ſͻ���ϵ�ʱ�
	    }
	    */
	/* end by qidp @ 2009-08-12 for ���ݶ˵������� . */
	%>
<!------------------------------------------------------------->
<html>
<head>
<title>�ͻ�����</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
</head>
<!----------------------------------------------------------------->
<SCRIPT type=text/javascript>
var numStr="0123456789"; 
onload=function(){
    document.all.newCust.focus();
    document.all.pa_flag.value="1";	
    if(typeof(frm1100.oldCust)!="undefined")
    {   //�ж��Ƿ��ǲ��ϻ�
        if(frm1100.oldCust.checked == true)
        {	
            var obj="tbs"+9;           
            document.all(obj).style.display="";
        }
    } 
    if(typeof(frm1100.custId)!="undefined")
    {   
        if(frm1100.custId.value != "")      //�ָ����ύǰ�Ŀͻ�ID��ť��ʾ״̬
        {       frm1100.custQuery.disabled = true;           }
    }
    if((typeof(frm1100.idType)!="undefined")&&(typeof(frm1100.idIccid)!="undefined"))
    {	change_idType();}  //��ԭ���ύǰ��֤������   
    
    change();//luxc 2008326 add ��Ϊ������� ����ҳ�治��ȷ
    change_instigate();
    
    /*  add by qidp @ 2009-08-12 for ���ݶ˵������� .  */
    <% if("1".equals(inputFlag)){ %>
        document.all.ownerType[1].selected = true;
        change();
    <% } %>
    /* end by qidp @ 2009-08-12 for ���ݶ˵������� . */
}

function doProcess(packet)
{
   	//RPC������findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    self.status="";
	if((retCode).trim()=="")
	{
       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
       return false;
	}
    //---------------------------------------    
    if(retType == "ClientId")
    {
    	
            //�õ��½��ͻ�ID
        var retnewId = packet.data.findValueByName("retnewId");
        if(retCode=="000000")
        {
			document.frm1100.custId.value = retnewId;
			document.frm1100.temp_custId.value = retnewId;
			document.frm1100.districtCode.focus();
			document.frm1100.districtCode.focus();
		 
			document.all.read_idCard_one.disabled=false;//����֤
			document.all.read_idCard_two.disabled=false;//����֤
			document.all.scan_idCard_two.disabled=false;//����֤
        }
        else
        {
			retMessage = retMessage + "[errorCode1:" + retCode + "]";
			rdShowMessageDialog(retMessage,0);
			return false;
        }       
     }
    //-----------------------------------------
    if(retType == "checkPwd")
    {
        //��������У��
        var retResult = packet.data.findValueByName("retResult");
		frm1100.checkPwd_Flag.value = retResult; 
	    if(frm1100.checkPwd_Flag.value == "false")
	    {
	    	rdShowMessageDialog("�ϼ��ͻ�����У��ʧ�ܣ����������룡",0);
	    	frm1100.parentPwd.value = "";
	    	frm1100.parentPwd.focus();
	    	frm1100.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }
		else
		{
			rdShowMessageDialog("�ϼ��ͻ�����У��ɹ���",2);
		}
     }        
    //----------------------------------------
    if(retType == "getInfo_withID")
    {
            clear_CustInfo();  
        if(retCode == "000000")
        {
           var retInfo = packet.data.findValueByName("retInfo");
           if(retInfo != "")
           {
               //var recordNum = acket.data.findValueByName("recordNum"); 
               //showParentInfo(retInfo);       
               for(i=0;i<7;i++)
               {           
                    var chPos = retInfo.indexOf("|");
                    valueStr = retInfo.substring(0,chPos);
                    retInfo = retInfo.substring(chPos+1);
                    var obj = "in" + i;
                    document.all(obj).value = valueStr;
                } 
             }
			 else
			 {
			   rdShowMessageDialog("�ͻ������ڣ�",0);  
			   return false;
			 }
         }           
         else
         {
             retMessage = retMessage + "[errorCode2:" + retCode + "]";
             rdShowMessageDialog(retMessage,0);
			 return false;
         }
     }
	 if(retType=="chkX")
	 {
    var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
				rdShowMessageDialog("У��ɹ�!",2);			
				document.all.print.disabled=false;
				document.all.uploadpic_b.disabled=false;//����֤
			}else if(retCode=="100001"){
				retMessage = retCode + "��"+retMessage;	
				rdShowMessageDialog(retMessage);		 
				document.all.print.disabled=false;
				document.all.uploadpic_b.disabled=false;//����֤
				return true;
    	}else{
				retMessage = "����" + retCode + "��"+retMessage;			 
				rdShowMessageDialog(retMessage,0);
				document.all.print.disabled=true;
				document.all.uploadpic_b.disabled=true;//����֤
				document.all(retObj).focus();
				return false;
			 
		}
	 }
	 if(retType=="checkName")
	 {
			var flag = packet.data.findValueByName("flag");
			var custId = packet.data.findValueByName("custId");
			if(flag=="0"){
     		rdShowMessageDialog("�ÿͻ����ƿ�������ʹ�ã�",2);
     		document.all("idCheck").disabled=false;
			}
			else if(flag=="1"){
				
				rdShowMessageDialog("�ÿͻ������Ѿ����ڣ�<BR>�ͻ�IDΪ"+custId+"��",0);
			}
		
	 }
  	if(retType=="iccIdCheck")
	 {
	 	if(retCode == "000000")
	 	{
	 		rdShowMessageDialog("У��ͨ����");
	 		document.all.get_Photo.disabled=false;
	 	}
	 	else
	 	{
	 		retMessage = retCode + "��"+retMessage;	
			rdShowMessageDialog(retMessage);
			document.all.idIccid.value="";
	 	}
	 }
}

//dujl add at 20100415 for ���֤У��
function checkIccId()
{
	if(document.all.idType.value.split("|")[0] != "0")
	{
		rdShowMessageDialog("ֻ�����֤����У�飡");
		return false;
	}
	if(document.all.custName.value.trim() == "")
	{
		rdShowMessageDialog("��������ͻ����ƣ�");
		return false;
	}
	if(document.all.idIccid.value.trim() == "")
	{
		rdShowMessageDialog("��������֤�����룡");
		return false;
	}
	if(document.all.ziyou_check.value != 0)
	{
		rdShowMessageDialog("������Ӫҵ�������Բ�ѯ��");
		return false;
	}
	document.all.iccIdCheck.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","������֤���֤��Ϣ�����Ժ�......");
	myPacket.data.add("retType","iccIdCheck");
	myPacket.data.add("idIccid",document.all.idIccid.value);
	myPacket.data.add("custName",document.all.custName.value);
	myPacket.data.add("IccIdAccept",document.all.IccIdAccept.value);
	myPacket.data.add("opCode",document.all.opCode.value);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	document.all.iccIdCheck.disabled=false;
}

//dujl add at 20100421 for ���֤У��
// ��ȡ���֤��Ƭ
function getPhoto()
{
	window.open("fgetIccIdPhoto.jsp?idIccid="+document.all.idIccid.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}

//   copy from common_util.js   ҳ�����   liutong@20080828
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
    if((obj_no.value).trim().length<5)
	{
      rdShowMessageDialog("֤�����볤����������5λ����");
	  obj_no.focus();
  	  return false;
	}
	else
	{
      if(idname=="���֤")
	  {
        if(checkElement(obj_no)==false) return false;
	  }
	}
  }
  else 
	return;
  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
	  myPacket.data.add("retType","chkX");
	  myPacket.data.add("retObj",x_no);
	  myPacket.data.add("x_idType",getX_idno(idname));
	  myPacket.data.add("x_idNo",obj_no.value);
	  myPacket.data.add("x_chkKind",chk_kind);
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
  
}
function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="���֤") return "0";
  else if(xx=="����֤") return "1";
  else if(xx=="��ʻ֤") return "2";
  else if(xx=="����֤") return "4";
  else if(xx=="ѧ��֤") return "5";
  else if(xx=="��λ") return "6";
  else if(xx=="У԰") return "7";
  else if(xx=="Ӫҵִ��") return "8";
  else return "0";
}

//--------------------------------------------
//����ϼ��ͻ���Ϣ
function clear_CustInfo()
{
        for(i=0;i<6;i++)
        {          
                var obj = "in" + i;
                document.all(obj).value = "";
        }
}

//--------------------------------------------
function check_newCust(){ 
	    if(document.all.custQuery.disabled==true){document.all.custQuery.disabled=false}
	    document.all.Reset.click();
         //�½��ͻ�����������
        if(document.frm1100.newCust.checked == true){
        window.document.frm1100.oldCust.checked = false;
        var temp1="tbs"+9;           
            document.all(temp1).style.display = "none";
            document.all("card_id_type").style.display="";
            document.all("svcLvl").style.display="none";
      
            window.document.frm1100.parentId.value = "";
            window.document.frm1100.parentPwd.value = "";
            window.document.frm1100.parentName.value = "";
            window.document.frm1100.parentAddr.value = "";
            window.document.frm1100.parentIdType.value = "";
            window.document.frm1100.parentIdidIccid.value = "";
        }
}
function check_oldCust(){
	document.all.Reset.click();
	document.all("card_id_type").style.display="none";
	document.all.oldCust.checked=true;
	document.all("svcLvl").style.display="none";
         //���ͻ�����������    
    if(document.frm1100.oldCust.checked == true)
    {
        window.document.frm1100.newCust.checked = false;
        var temp2="tbs"+9;           
            document.all(temp2).style.display="";
    }
}

function change(){      
	//�Ը�������������Ŀ���       
	var ic = document.frm1100.ownerType.options[document.frm1100.ownerType.selectedIndex].value;       
	document.getElementById("preBox").style.checked=false;//wangzn 091203
	if(ic=="01")
	{ 
		document.all("tb0").style.display="";   
		document.all("tb1").style.display="none";      
		document.all("td2").style.display="none";
		document.all("td3").style.display="none";
		document.all("checkName").style.display="none";
		document.all("ownerType_Type").style.display="";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=false;
		document.all("print").disabled=true;
		document.all.custPwd.value="";
		document.all.cfmPwd.value="";
		document.getElementById("preBox").style.display="none";//wangzn 091201
		document.getElementById("svcLvl").style.display="none";//zhangyan 2011-12-13 15:46:32		
	}
	else if(ic=="02")
	{
		document.all("tb0").style.display="none";
		document.all("tb1").style.display="none";
		document.all("td2").style.display="none";
		document.all("td3").style.display="";   
		document.all("checkName").style.display="";
		document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=true;
		document.all("print").disabled=true;
		document.all.custPwd.value="111111";
		document.all.cfmPwd.value="111111";
		document.getElementById("preBox").style.display="";//wangzn 091201
		document.getElementById("svcLvl").style.display="";//zhangyan 2011-12-13 15:46:32	
	}
	else if(ic=="03")
	{
		document.all("tb0").style.display="none";
		document.all("tb1").style.display="none";
		document.all("td2").style.display="";   	
		document.all("td3").style.display="none";
		document.all("checkName").style.display="none";
		document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=true;
		document.all("print").disabled=true;
		document.getElementById("preBox").style.display="none";//wangzn 091201
		document.getElementById("svcLvl").style.display="none";//zhangyan 2011-12-13 15:46:32	
	}
	else if(ic=="04")
	{
		document.all("tb0").style.display="none";
		document.all("tb1").style.display="none";
		document.all("td2").style.display="none";
		document.all("td3").style.display="";   
		document.all("checkName").style.display="";
		document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=true;
		document.all("print").disabled=true;
		document.all.custPwd.value="111111";
		document.all.cfmPwd.value="111111";
		document.getElementById("preBox").style.display="";//wangzn 091201
		document.getElementById("svcLvl").style.display="";//zhangyan 2011-12-13 15:46:32			
	}
	//dujl add at 20100421 for ���֤У��
	if(document.all.ownerType.value != "01")
	{
		document.all.iccIdCheck.disabled = true;
	}
	else
	{
		document.all.iccIdCheck.disabled = false;
	}
}

function change_instigate()
{
	if(document.all.instigate_flag.value=="Y")
	{
		document.all.getcontract_flag.disabled=false;
	}
	else
	{
		document.all.getcontract_flag.value="0";
		document.all.getcontract_flag.disabled=true;
	}
}

function change_idType()//����֤
{		

			
		if(document.all.idType.value=="0|���֤")
		{ 
			document.all.pa_flag.value="1";	
		document.all("card_id_type").style.display="";
		}
		else{
		document.all.pa_flag.value="0";
	 
		document.all("card_id_type").style.display="none";
	}
    var Str = document.frm1100.idType.value;
    if(Str.indexOf("���֤") > -1)
    {   document.frm1100.idIccid.v_type = "idcard";   }
    else
    {   document.frm1100.idIccid.v_type = "string";   }
    document.all.print.disabled=true;
}

function change_custPwd()
{   
    check_HidPwd(frm1100.parentPwd.value,"show",(frm1100.in1.value).trim(),"hid");
    /*
    if(frm1100.checkPwd_Flag.value != "true");
    {
    	rdShowMessageDialog("�ϼ��ͻ�����У��ʧ�ܣ����������룡",0);
    	frm1100.parentPwd.value = "";
    	frm1100.parentPwd.focus();
    	return false;	        	
    }
    frm1100.checkPwd_Flag.value = "false"; 
    */
}
//------------------------------------
function printCommit()
{       
    getAfterPrompt();
	if(frm1100.ownerType.value=="02"||frm1100.ownerType.value=="04")
	{
		if(frm1100.custPwd.value == "")
		{
			rdShowMessageDialog("���ſ������벻��Ϊ��!",0);
	    	//frm1100.parentPwd.focus();
	    	return false;
		}
		/*luxc 20080326 add*/
		
		if(document.all.instigate_flag.value=="0"||document.all.instigate_flag.value=="")
		{
			rdShowMessageDialog("��ѡ��߷����ű�־!",0);
			return false;
		}
		else if(document.all.instigate_flag.value=="Y" 
			&& (document.all.getcontract_flag.value=="0"||document.all.getcontract_flag.value==""))
		{
			rdShowMessageDialog("��ѡ�� �Ƿ��þ�������Э��!",0);
			return false;
		}
	}
		
		var obj = null;
		//��ȷ�ϴ�ӡ����������ڴ�ӡ��Ʊ
        if(frm1100.oldCust.checked == true)
        {	//���ϻ��������ж�
        	//parentId parentPwd parentIdidIccid parentName
	        if(frm1100.parentId.value == "")
	        {	
	        	rdShowMessageDialog("ѡ���ϻ����ͻ�ID����Ϊ�գ�",0);
	        	frm1100.parentId.focus();
	        	return false;
	        }
	        /*if(frm1100.parentPwd.value == "")
	        {	
	        	rdShowMessageDialog("ѡ���ϻ����ͻ����벻��Ϊ�գ�",0);
	        	frm1100.parentPwd.focus();
	        	return false;
	        }*/
	        if(frm1100.parentIdidIccid.value == "")
	        {	
	        	rdShowMessageDialog("ѡ���ϻ����ͻ�֤�����벻��Ϊ�գ�",0);
	        	frm1100.parentIdidIccid.focus();
	        	return false;
	        }
	        if(frm1100.parentName.value == "")
	        {	
	        	rdShowMessageDialog("ѡ���ϻ����ͻ����Ʋ���Ϊ�գ�",0);
	        	frm1100.parentName.focus();
	        	return false;
	        }		
	        if(frm1100.parentName.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("�ϼ��ͻ��������зǷ��ַ�'~'�����޸ģ�",0);
				return false;
			}	
			if(frm1100.parentAddr.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("�ϼ��ͻ���ַ���зǷ��ַ�'~'�����޸ģ�",0);
				return false;
			}		  	  
        }
        if(frm1100.custName.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("�ͻ��������зǷ��ַ�'~'�����޸ģ�",0);
			return false;
		}	
		if(frm1100.idAddr.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("֤����ַ���зǷ��ַ�'~'�����޸ģ�",0);
			return false;
		}	
		if(frm1100.contactAddr.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("��ϵ�˵�ַ���зǷ��ַ�'~'�����޸ģ�",0);
			return false;
		}
		if(frm1100.contactPerson.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("��ϵ���������зǷ��ַ�'~'�����޸ģ�",0);
			return false;
		}
		if(frm1100.contactPhone.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("��ϵ�˵绰���зǷ��ַ�'~'�����޸ģ�",0);
			return false;
			
		}
		if(document.frm1100.contactMAddr.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("��ϵ��ͨѶ��ַ���зǷ��ַ�'~'�����޸ģ�",0);
			return false;
		}
        change_idType();   //�жϿͻ�֤�������Ƿ������֤ 
        if((frm1100.contactMail.value).trim() == "")
        {
			frm1100.contactMail.value = "";       	
        }
        //�ж����ա�֤����Ч����Ч��	birthDay	idValidDate
        obj = "tb" + 0;
        obj1 = "tb" + 1;
        if((typeof(frm1100.birthDay)!="undefined")&&
           (frm1100.birthDay.value != "")&&
           (document.all(obj).style.display == ""))
        {	
        	if(validDate(frm1100.birthDay) == false)
        	{	return false;		}
        }
        else if((typeof(frm1100.yzrq)!="undefined")&&
           (frm1100.yzrq.value != "")&&
           (document.all(obj1).style.display == ""))
        {	
        	if(validDate(frm1100.yzrq) == false)
        	{	return false;		}			
        }
		
	     if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//����֤
	rdShowMessageDialog("�����ϴ����֤��Ƭ",0);
	return false;
	}
        
var upflag =document.all.up_flag.value;//����֤
if(upflag==3&&(document.all.but_flag.value =="1"))//����֤
{
	rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
	return false;
	}
if(upflag==4&&(document.all.but_flag.value =="1"))//����֤
{
	rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
	return false;
	}
	
	
if(upflag==5&&(document.all.but_flag.value =="1"))//����֤
{
	rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+document.all.pic_name.value);
	return false;
	}
			
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//����֤
	rdShowMessageDialog("�����ϴ����֤��Ƭ",0);
	return false;
	}
		var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

		if((frm1100.idValidDate.value).trim().length>0)
	    {		 
           if(validDate(frm1100.idValidDate)==false) return false;

		   if(to_date(frm1100.idValidDate)<=d)
		   {
			  rdShowMessageDialog("֤����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
	          document.all.idValidDate.focus();
			  document.all.idValidDate.select();
		      return false;
		   }
		}

		if(document.all.ownerType.options[document.all.ownerType.selectedIndex].text=="��ͨ")
		{
             if((document.all.birthDay.value).trim().length>0)
		     {
		       if(to_date(frm1100.birthDay)>=d)
		       {
			     rdShowMessageDialog("���������ڲ������ڵ�ǰʱ�䣬���������룡");
	             document.all.birthDay.focus();
			     document.all.birthDay.select();
		         return false;
		       }
			 }
		}
		else
		{
             if((document.all.yzrq.value).trim().length>0)
		     {
		       if(to_date(frm1100.yzrq)<=d)
		       {
			     rdShowMessageDialog("Ӫҵִ����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
	             document.all.yzrq.focus();
			     document.all.yzrq.select();
		         return false;
		       }
			 }
		}

		/*if(document.all("td2").style.display=="")
	    {
			if(jtrim(document.all.oriGrpNo.value).length==0)
			{
              rdShowMessageDialog("������ԭ���źţ�");
              document.all.oriGrpNo.focus();
			  return false;
			}
		}*/
				
        //--------------------------             
        if(check(frm1100))
        { 
 		     if((document.all.custPwd.value).trim().length>0)
			  {
			     if(document.all.custPwd.value.length!=6)
				 {
				   rdShowMessageDialog("�ͻ����볤������");
    	           document.all.custPwd.focus();
				   return false;
				 }
			     if(checkPwd(document.frm1100.custPwd,document.frm1100.cfmPwd)==false)
				    return false;
			  }
	        var t = null;
	        var i;
	        if(document.frm1100.newCust.checked == true)
	        {
	            document.frm1100.parentId.value = document.frm1100.custId.value;
	            sysNote = "�½���:�ͻ�ID[" + 
	                 document.frm1100.custId.value + "]";
	        } 
	        else
	        {
	            sysNote = "���ϻ�:�ͻ�ID[" + 
	                 document.frm1100.custId.value + "]:�ϼ��ͻ�ID[" + 
	                 document.frm1100.parentId.value + "]";
	        }
	        document.frm1100.sysNote.value = sysNote;
			if((document.all.opNote.value).trim().length==0)
			{//luxc20061218�޸ı�ע�ֶ� ��ֹ̫���岻��wchg��
              document.all.opNote.value="<%=workName%>"+"��["+(document.all.custName.value).trim().substring(0,14)+"]"+document.all.ownerType.options[document.all.ownerType.selectedIndex].text+"�ͻ�����";
			}
			if((document.all.opNote.value).trim().length>60)
			{
				rdShowMessageDialog("�û���ע��ֵ����ȷ�������д���");
				document.all.opNote.focus();
				return false;
			}
			//wangzn 091202
			 if(document.frm1100.isPre.checked){
					if(!document.frm1100.preUnitId.readOnly){
						rdShowMessageDialog("��ѡ��Ǳ�ڼ��ű�ţ�");
						return false;
					}
		   }
			
	       if(!check(frm1100)){
	 			return false;
	 		}else
	 		{
				checkPwdEasy(document.frm1100.custPwd.value);	//2010-8-30 17:28 wanghfa��� �ͻ�������������
			}
			// dujl at 20100324 for R_HLJMob_liubq_CRM_PD3_2010_0117@�����Ż�BOSSϵͳ�������������ܵ����� ���
//	        showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    	}else{
    		return false;
    		}    
}

//2010-8-30 17:29 wanghfa��� ��֤������ڼ� start
function checkPwdEasy(pwd) {
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "");
	checkPwd_Packet.data.add("idNo", document.all.idIccid.value);
	checkPwd_Packet.data.add("opCode", "1100");
	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}

function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");

	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "0") {
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ�ͻ�������Ϣ��")==1) {
			<% if("1".equals(inputFlag)) { %>
				document.frm1100.target="hidden_frame";
			<% }else{ %>
			//����֤
				frm1100.target=""; 
			<% } %>
			//wangzn 20091202
			var isPre = "0";
			if(document.frm1100.isPre.checked) {
				isPre="1";
			}
			frm1100.action="f1100_2.jsp?inputFlag="+document.frm1100.inputFlag.value+"&custId="+document.frm1100.custId.value+"&regionCode="+document.frm1100.regionCode.value+"&districtCode="+document.frm1100.districtCode.value+"&custName="+document.frm1100.custName.value+"&custPwd="+document.frm1100.custPwd.value+"&custStatus="+document.frm1100.custStatus.value+"&custGrade="+document.frm1100.custGrade.value+"&ownerType="+document.frm1100.ownerType.value+"&custAddr="+document.frm1100.custAddr.value+"&idType="+document.frm1100.idType.value+"&idIccid="+document.frm1100.idIccid.value+"&idAddr="+document.frm1100.idAddr.value+"&idValidDate="+document.frm1100.idValidDate.value+"&contactPerson="+document.frm1100.contactPerson.value+"&contactPhone="+document.frm1100.contactPhone.value+"&contactAddr="+document.frm1100.contactAddr.value+"&contactPost="+document.frm1100.contactPost.value+"&contactMAddr="+document.frm1100.contactMAddr.value+"&contactFax="+document.frm1100.contactFax.value+"&contactMail="+document.frm1100.contactMail.value+"&unitCode="+document.frm1100.unitCode.value+"&parentId="+document.frm1100.parentId.value+"&custSex="+document.frm1100.custSex.value+"&birthDay="+document.frm1100.birthDay.value+"&professionId="+document.frm1100.professionId.value+"&vudyXl="+document.frm1100.vudyXl.value+"&custAh="+document.frm1100.custAh.value+"&custXg="+document.frm1100.custXg.value+"&unitXz="+document.frm1100.unitXz.value+"&yzlx="+document.frm1100.yzlx.value+"&yzhm="+document.frm1100.yzhm.value+"&yzrq="+document.frm1100.yzrq.value+"&frdm="+document.frm1100.frdm.value+"&groupCharacter=''"+"&workno="+document.frm1100.workno.value+"&sysNote="+document.frm1100.sysNote.value+"&opNote="+document.frm1100.opNote.value+"&opNote="+document.frm1100.opNote.value+"&ip_Addr="+document.frm1100.ip_Addr.value+"&oriGrpNo="+document.frm1100.oriGrpNo.value+"&instigate_flag="+document.frm1100.instigate_flag.value+"&getcontract_flag="+document.frm1100.getcontract_flag.value+"&filep="+document.frm1100.filep.value+"&card_flag="+document.frm1100.card_flag.value+"&m_flag="+document.frm1100.m_flag.value+"&sf_flag="+document.frm1100.sf_flag.value+"&idType="+document.frm1100.idType.value+"&pic_name="+document.all.pic_name.value+"&but_flag="+document.all.but_flag.value+"&isPre="+isPre+"&preUnitId="+document.all.preUnitId.value+"&IccIdAccept="+document.all.IccIdAccept.value+"&selSvcLvl="+document.all.selSvcLvl.value;
			frm1100.submit();
		}
	}
}
//2010-8-30 17:29 wanghfa��� ��֤������ڼ� end








function chkValid()
{
     var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

	 if((frm1100.idValidDate.value).trim().length>0)
	 {		 
        if(validDate(frm1100.idValidDate)==false) return false;

	    if(to_date(frm1100.idValidDate)<=d)
	    {
		  rdShowMessageDialog("֤����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
	      document.all.idValidDate.focus();
		  document.all.idValidDate.select();
	      return false;
	    }
	}
}
/// begin    add by liutong 20080909
function validDate(obj)
{
  var theDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theDate+=one;
  }
  if(theDate.length!=8)
  {
	rdShowMessageDialog("���ڸ�ʽ������ȷ��ʽΪ�����������������ա������������룡");
	//obj.value="";
	obj.select();
 	obj.focus();
	return false;
  }
  else
  {
     var year=theDate.substring(0,4);
	 var month=theDate.substring(4,6);
	 var day=theDate.substring(6,8);
	 if(myParseInt(year)<1900 || myParseInt(year)>3000)
	 {
       rdShowMessageDialog("��ĸ�ʽ������Ч���Ӧ����1900-3000֮�䣬���������룡");
	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(month)<1 || myParseInt(month)>12)
	 {
       rdShowMessageDialog("�µĸ�ʽ������Ч�·�Ӧ����01-12֮�䣬���������룡");
  	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(day)<1 || myParseInt(day)>31)
	 {
       rdShowMessageDialog("�յĸ�ʽ������Ч����Ӧ����01-31֮�䣬���������룡");
	   //obj.value="";
	   obj.select();
       obj.focus();
	   return false;
	 }

     if (month == "04" || month == "06" || month == "09" || month == "11")  	         
	 {
         if(myParseInt(day)>30)
         {
	 	     rdShowMessageDialog("���·����30��,û��31�ţ�");
 	         //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
         }
      }                 
       
      if (month=="02")
      {
         if(myParseInt(year)%4==0 && myParseInt(year)%100!=0 || (myParseInt(year)%4==0 && myParseInt(year)%400==0))
		 {
           if(myParseInt(day)>29)
		   {
 		     rdShowMessageDialog("������·����29�죡");
      	     //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
		   }
		 }
		 else
		 {
           if(myParseInt(day)>28)
		   {
 		     rdShowMessageDialog("��������·����28�죡");
      	     //obj.value="";
			 obj.select();
	        obj.focus();
           return false;
		   }
		 }
      }
  }
  return true;
}

function myParseInt(nu)
{
  var ret=0;
  if(nu.length>0)
  {
    if(nu.substring(0,1)=="0")
	{
       ret=parseInt(nu.substring(1,nu.length));
	}
	else
	{
       ret=parseInt(nu);
	}
  }
  return ret;
}
function to_date(obj)
{
  var theTotalDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theTotalDate+=one;
  }
  return theTotalDate;
}
/// end    add by liutong 20080909
function printInfo(printType)
{
	var retInfo = "";
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
	var retInfo = "";  //��ӡ����

    if(printType == "Detail")
    {	//��ӡ�������
    	
        var getAcceptFlag = "<%=getAcceptFlag%>";
        if(getAcceptFlag == "failed")
        {	return "failed";	}
	    /*retInfo = retInfo + "10|2|0|0|��ӡ��ˮ:  " + "<%=printAccept%>" + "|"; */
		
		//��ӡ�������
        //retInfo+=frm1100.custId.value+"|";
		/*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|"; */
		//retInfo+= frm1100.workName.value+"|";
		cust_info+= "�ͻ�������     "+frm1100.custName.value+"|";
		//retInfo+= "֤�����ͣ�   "+frm1100.idType.value+"|";
		cust_info+= "֤�����룺     "+frm1100.idIccid.value+"|";
		cust_info+= "�ͻ���ַ��     "+frm1100.idAddr.value+"|";
		//retInfo+=" |";
		cust_info+= "��ϵ��������   "+frm1100.contactPerson.value+"|";
		cust_info+= "��ϵ�˵绰��   "+frm1100.contactPhone.value+"|";
		cust_info+= "��ϵ�˵�ַ��   "+frm1100.contactAddr.value+"|";
		
		opr_info+= "��ӡ��ˮ:     " + "<%=printAccept%>" + "|";
		opr_info+=" "+"|";
		opr_info+= "�ͻ�������*|";

		note_info1+=document.all.sysNote.value+"|";
		note_info1+=document.all.opNote.value+"|";
		note_info1+=" |";

		//��������Ϣ(oneTok:12-15)
		note_info2+=document.all.assu_name.value+"|";
		note_info2+=document.all.assu_phone.value+"|";
		note_info2+=document.all.assu_idAddr.value+"|";
		note_info2+=document.all.assu_idIccid.value+"|";
		
		//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	}
	  
    if(printType == "Bill")
    {
      //��ӡ��Ʊ
	}
	return retInfo;	
}


function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=185;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {	return false;	}
   
	var pType="print";                   // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";                    //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept="<%=printAccept%>";    // ��ˮ��
	var printStr = printInfo(printType); //����printinfo()���صĴ�ӡ����
	var mode_code=null;                      //�ʷѴ���
	var fav_code=null;                       //�ط�����
	var area_code=null;                  //С������
	var opCode="1100" ;                         //��������
	var phoneNo=null;                         //�ͻ��绰

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
   //var path = "gdPrint_1100.jsp?DlgMsg=" + DlgMessage;
   //var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   //var ret=window.showModalDialog(path,"",prop);
  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);

   //if(typeof(ret)!="undefined")
   //{
     //if((ret=="confirm")&&(submitCfm == "Yes"))
     //{
	 if(!check(frm1100)){
	 	return false;
	 }else{
			if(rdShowConfirmDialog("ȷ��Ҫ�ύ�ͻ�������Ϣ��")==1)
			{
				<% if("1".equals(inputFlag)){ %>
               document.frm1100.target="hidden_frame";
               <% }else{ %>
				//����֤
				frm1100.target=""; 
				<% } %>
				//wuxy alter 20090917 ��Ϊinstigate_flag ����û�н�= ���¸�ֵû�л�ȡ��
				
				//wangzn 20091202
				var isPre = "0";
				if(document.frm1100.isPre.checked){
					isPre="1";
				}
			  frm1100.action="f1100_2.jsp?inputFlag="+document.frm1100.inputFlag.value+"&custId="+document.frm1100.custId.value+"&regionCode="+document.frm1100.regionCode.value+"&districtCode="+document.frm1100.districtCode.value+"&custName="+document.frm1100.custName.value+"&custPwd="+document.frm1100.custPwd.value+"&custStatus="+document.frm1100.custStatus.value+"&custGrade="+document.frm1100.custGrade.value+"&ownerType="+document.frm1100.ownerType.value+"&custAddr="+document.frm1100.custAddr.value+"&idType="+document.frm1100.idType.value+"&idIccid="+document.frm1100.idIccid.value+"&idAddr="+document.frm1100.idAddr.value+"&idValidDate="+document.frm1100.idValidDate.value+"&contactPerson="+document.frm1100.contactPerson.value+"&contactPhone="+document.frm1100.contactPhone.value+"&contactAddr="+document.frm1100.contactAddr.value+"&contactPost="+document.frm1100.contactPost.value+"&contactMAddr="+document.frm1100.contactMAddr.value+"&contactFax="+document.frm1100.contactFax.value+"&contactMail="+document.frm1100.contactMail.value+"&unitCode="+document.frm1100.unitCode.value+"&parentId="+document.frm1100.parentId.value+"&custSex="+document.frm1100.custSex.value+"&birthDay="+document.frm1100.birthDay.value+"&professionId="+document.frm1100.professionId.value+"&vudyXl="+document.frm1100.vudyXl.value+"&custAh="+document.frm1100.custAh.value+"&custXg="+document.frm1100.custXg.value+"&unitXz="+document.frm1100.unitXz.value+"&yzlx="+document.frm1100.yzlx.value+"&yzhm="+document.frm1100.yzhm.value+"&yzrq="+document.frm1100.yzrq.value+"&frdm="+document.frm1100.frdm.value+"&groupCharacter=''"+"&workno="+document.frm1100.workno.value+"&sysNote="+document.frm1100.sysNote.value+"&opNote="+document.frm1100.opNote.value+"&opNote="+document.frm1100.opNote.value+"&ip_Addr="+document.frm1100.ip_Addr.value+"&oriGrpNo="+document.frm1100.oriGrpNo.value+"&instigate_flag="+document.frm1100.instigate_flag.value+"&getcontract_flag="+document.frm1100.getcontract_flag.value+"&filep="+document.frm1100.filep.value+"&card_flag="+document.frm1100.card_flag.value+"&m_flag="+document.frm1100.m_flag.value+"&sf_flag="+document.frm1100.sf_flag.value+"&idType="+document.frm1100.idType.value+"&pic_name="+document.all.pic_name.value+"&but_flag="+document.all.but_flag.value+"&isPre="+isPre+"&preUnitId="+document.all.preUnitId.value+"&selSvcLvl="+document.all.selSvcLvl.value;
			  frm1100.submit();
			}
	   }
     //}
   //}
}

function checkPwd(obj1,obj2)
{
        //����һ����У��,����У��
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                var message = "�û������ȷ���û����벻һ�£����������룡";
                rdShowMessageDialog(message,0);
                if(obj1.type != "hidden")
                {   obj1.value = "";    }
                if(obj2.type != "hidden")
                {   obj2.value = "";    }
                obj1.focus();
                return false;
        }
        return true;
}

function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
	/*
  		Pwd1,Pwd2:����
  		wd1Type:����1�����ͣ�Pwd2Type������2������      show:���룻hid������
  	
	if((Pwd1).trim().length==0)
	{
        rdShowMessageDialog("�ͻ����벻��Ϊ�գ�",0);
        frm1100.custPwd.focus();
		return false;
	}
    else 
	{
	   if((Pwd2).trim().length==0)
	   {
         rdShowMessageDialog("ԭʼ�ͻ�����Ϊ�գ���˶����ݣ�",0);
         frm1100.custPwd.focus();
		 return false;
	   }
	}*/
	var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","checkPwd"); 
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",(Pwd2).trim());
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;		
}

function getId()
{
    //�õ��ͻ�ID
        document.frm1100.custId.readonly = true;
        document.frm1100.custQuery.disabled = true;   
        var getUserId_Packet = new AJAXPacket("f1100_getId.jsp","���ڻ�ÿͻ�ID�����Ժ�......");
    	getUserId_Packet.data.add("retType","ClientId");
        getUserId_Packet.data.add("region_code","<%=regionCode%>");
        getUserId_Packet.data.add("idType","0");
        getUserId_Packet.data.add("oldId","0");
        core.ajax.sendPacket(getUserId_Packet);
        getUserId_Packet=null;
}

function choiceSelWay()
{	
    //ѡ��ͻ���Ϣ�Ĳ�ѯ��ʽ
	if(frm1100.parentId.value != "")
	{	//���ͻ�ID���в�ѯ
		getInfo_withId();	
		return true;
	}
	if(frm1100.parentIdidIccid.value != "")
	{	//�ͻ�֤������
 		getInfo_IccId();
		return true;
	}
	if(frm1100.parentName.value != "")
	{	//�ͻ�����
		getInfo_withName();
		return true;
	}
 	rdShowMessageDialog("�ͻ���Ϣ������ID��֤����������ƽ��в�ѯ��������������������Ϊ��ѯ������",0);
}

function getInfo_withId()
{
    //���ݿͻ�ID�õ������Ϣ
    if(document.frm1100.parentId.value == "")
    {
        rdShowMessageDialog("������ͻ�ID��",0);
        return false;
    }
	else
	{
	  if((document.all.parentId.value).trim().length>14)
	  {
         rdShowMessageDialog("�ͻ�ID��������",0);
         return false;
	  }
	}
    if(for0_9(frm1100.parentId) == false)
    {	
    	frm1100.parentId.value = "";
    	return false;	
    }
    var getIdPacket = new AJAXPacket("fpsb_rpc.jsp","���ڻ���ϼ��ͻ���Ϣ�����Ժ�......");
        var parentId = document.frm1100.parentId.value;
        getIdPacket.data.add("retType","getInfo_withID");
        getIdPacket.data.add("fieldNum","6");
        getIdPacket.data.add("sqlStr",parentId);
        core.ajax.sendPacket(getIdPacket);
        getIdPacket=null; 
}   
function for0_9(obj) //�ж��ַ��Ƿ���0��9���������
{  
	
    if (!forString(obj)){
	  ltflag = 1;
	  obj.select();
	  obj.focus();
	  return false;
	}else{
	  if (obj.value.length == 0){
	    return true;
	  }
	}    
	if (!isMadeOf(obj.value,numStr)){
      flag = 1;
      rdShowMessageDialog("'" + obj.v_name + "'��ֵ����ȷ�����������֣�");
	  obj.select();
	  obj.focus();
	  return false;
    }	
	return true;	
}
function isMadeOf(val,str)
{

	var jj;
	var chr;
	for (jj=0;jj<val.length;++jj){
		chr=val.charAt(jj);
		if (str.indexOf(chr,0)==-1)
			return false;			
	}
	
	return true;
}
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
    */
    var path = "psbgetCustInfo.jsp";   //����Ϊ*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  

    var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	rpc_chkX("parentIdType","parentIdidIccid","B");
}

function getInfo_withName()
{ 
        ////���ݿͻ����Ƶõ������Ϣ
    if(document.frm1100.parentName.value == "")
    {
        rdShowMessageDialog("������ͻ����ƣ�",0);
        return false;
    }
    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "CUST_NAME="+ frm1100.parentName.value ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|"; 
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)                           
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);
    rpc_chkX("parentIdType","parentIdidIccid","B");
}


function getInfo_IccId()
{ 
    //���ݿͻ�֤������õ������Ϣ
    if((document.frm1100.parentIdidIccid.value).trim().length == 0)
    {
        rdShowMessageDialog("������ͻ�֤�����룡",0);
        return false;
    }
	else if((document.frm1100.parentIdidIccid.value).trim().length < 5)
	{
        rdShowMessageDialog("֤�����볤������������λ����",0);
        return false;
	}

    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "ID_ICCID="+document.frm1100.parentIdidIccid.value; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
     custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
     //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);
     //rpc_chkX("parentIdType","parentIdidIccid","B");
}

function get_inPara()
{
    //��֯���˵Ĳ���
    var inPara_Str = "";    
        inPara_Str = inPara_Str + document.frm1100.temp_custId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.regionCode.value + "|" + document.frm1100.districtCode.value + "|";
        inPara_Str = inPara_Str + document.frm1100.custName.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custPwd.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custStatus.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custGrade.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.ownerType.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custAddr.value + "|";
        var tempStr = document.frm1100.idType.value; 
        inPara_Str = inPara_Str + tempStr.substring(0,tempStr.indexOf("|")) + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idIccid.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idValidDate.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPerson.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPhone.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPost.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactMAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactFax.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactMail.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.unitCode.value + "|"; //��������
        inPara_Str = inPara_Str + document.frm1100.parentId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custSex.value + "|";  //�ͻ��Ա�
        inPara_Str = inPara_Str + document.frm1100.birthDay.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.professionId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.vudyXl.value + "|"; //ѧ��
        inPara_Str = inPara_Str + document.frm1100.custAh.value + "|"; //�ͻ����� 
        inPara_Str = inPara_Str + document.frm1100.custXg.value + "|"; //�ͻ�ϰ��
        inPara_Str = inPara_Str + document.frm1100.unitXz.value + "|"; //��λ����
        inPara_Str = inPara_Str + document.frm1100.yzlx.value + "|"; //ִ������
        inPara_Str = inPara_Str + document.frm1100.yzhm.value + "|"; //ִ�պ���
        inPara_Str = inPara_Str + document.frm1100.yzrq.value + "|"; //ִ����Ч��
        inPara_Str = inPara_Str + document.frm1100.frdm.value + "|"; //���˴���
        inPara_Str = inPara_Str + document.frm1100.groupCharacter.value + "|";//Ⱥ����Ϣ
        inPara_Str = inPara_Str + "1100" + "|";
        inPara_Str = inPara_Str + document.frm1100.workno.value + "|";  
        inPara_Str = inPara_Str + document.frm1100.sysNote.value + "|";
        inPara_Str = inPara_Str + document.frm1100.opNote.value + "|";  
        document.frm1100.inParaStr.value = inPara_Str;
}


function jspReset()
{
    //ҳ��ؼ���ʼ��    
    var obj = null;
    var t = null;
        var i;
    for (i=0;i<document.frm1100.length;i++)
    {    
                obj = document.frm1100.elements[i];                                              
                packUp(obj); 
            obj.disabled = false;
    }
    document.frm1100.commit.disabled = "none"; 
} 
 
function jspCommit()
{
         //ҳ���ύ
         document.frm1100.commit.disabled = "none";
         action="f1100_2.jsp"
         frm1100.submit();   //����������������ύ
}

function change_ConPerson()
{   //��ϵ��������ͻ����Ƹ������ı�
	if(document.all.ownerType.value=="02"){
		frm1100.contactPerson.value = frm1100.custName.value;
		document.all.idCheck.disabled=true;
		document.all.print.disabled=true;
	}
}
function change_ConAddr()
{   //��ϵ��������ͻ����Ƹ������ı�
	frm1100.contactAddr.value = frm1100.custAddr.value;
	frm1100.contactMAddr.value = frm1100.custAddr.value;
}

function checkName(){
	if(!forString(document.all.custName)){
		return false;
	}
	var custName=document.all.custName.value;
	var checkPwd_Packet = new AJAXPacket("f1100_checkName.jsp?custName="+custName,"���ڽ��пͻ�����У�飬���Ժ�......");
  checkPwd_Packet.data.add("retType","checkName");
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

function changeCardAddr(obj){
	if(document.all.ownerType.value=="01"){
		document.all.custAddr.value=obj.value;
		document.all.contactAddr.value=obj.value;
		document.all.contactMAddr.value=obj.value;
	}
}

function chcek_pic()//����֤
{
	
var pic_path = document.all.filep.value;
	
var d_num = pic_path.indexOf("\.");
var file_type = pic_path.substring(d_num+1,pic_path.length);
//�ж��Ƿ�Ϊjpg���� //�����豸����ͼƬ�̶�Ϊjpg����
if(file_type.toUpperCase()!="JPG")
{ 
		rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
		document.all.up_flag.value=3;
		document.all.print.disabled=true;
		resetfilp();
	return ;
	}

	var pic_path_flag= document.all.pic_name.value;
	
	if(pic_path_flag=="")
	{
	rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
	document.all.up_flag.value=4;
	document.all.print.disabled=true;
	resetfilp();
	return;
}
	else
		{
			if(pic_path!=pic_path_flag)
			{
			rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+pic_path_flag);
			document.all.up_flag.value=5;
			document.all.print.disabled=true;
			resetfilp();
		return;
		}
		else{
			document.all.up_flag.value=2;
			}
			}
			
	}
	
/*** dujl add at 20090806 for R_HLJMob_cuisr_CRM_PD3_2009_0314@���ڹ淶�ͻ����������л��������зǷ��ַ�У������� ****/
function feifa(textName)
{
	if(textName.value != "")
	{
		if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
		{
			rdShowMessageDialog("����������Ƿ��ַ������������룡");
			textName.value = "";
 	  		return;
		}
	}
}

/**** tianyang add for �����ַ����� start ****/	
/*function feifaCustName(textName)
{
	if(textName.value != "")
	{
			if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
			{
				rdShowMessageDialog("����������Ƿ��ַ������������룡");
				textName.value = "";
	 	  		return;
			}
	}
}*/
function feifaCustName(textName)
{
	if(textName.value != "")
	{
		if(document.all.ownerType.value=="01"&&document.all.isJSX.value=="0"){
			var m = /^[\u0391-\uFFE5]+$/;
			var flag = m.test(textName.value);
			if(!flag){
				rdShowMessageDialog("ֻ�����������ģ����˿���������ѡ������ſ�����");
				reSetCustName();
			}
			if(textName.value.length > 6){
				rdShowMessageDialog("ֻ��������6�����֣����������룡");
				reSetCustName();
			}
		}else{
			if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
			{
				rdShowMessageDialog("����������Ƿ��ַ������˿���������ѡ������ſ�����");
				textName.value = "";
	 	  		return;
			}
		}
	}
}
function reSetCustName(){/*���ÿͻ�����*/
	document.all.custName.value="";
	document.all.contactPerson.value="";
}
/**** tianyang add for �����ַ����� end ****/
	
	
	
	
	
	
	
	
function uploadpic(){//����֤
	
	if(document.all.filep.value==""){
		rdShowMessageDialog("��ѡ��Ҫ�ϴ���ͼƬ",0);
		return;
		}
	if(document.all.but_flag.value=="0"){
		rdShowMessageDialog("����ɨ����ȡͼƬ",0);
		return;
		}
	frm1100.target="upload_frame"; 
	var actionstr ="f1100_2.jsp?custId="+document.frm1100.custId.value+
									"&regionCode="+document.frm1100.regionCode.value+
									"&filep_j="+document.frm1100.filep.value+
									"&card_flag="+document.all.card_flag.value+ 
									"&but_flag="+document.all.but_flag.value+
									"&idSexH="+document.all.idSexH.value+
									"&custName="+document.all.custName.value+
									"&idAddrH="+document.all.idAddrH.value+
									"&birthDayH="+document.all.birthDayH.value+
									"&custId="+document.all.custId.value+
									"&idIccid="+document.all.idIccid.value+
									"&workno="+document.all.workno.value+
									"&IccIdAccept="+document.all.IccIdAccept.value+
									"&upflag=1";
									
	frm1100.action = actionstr; 
	document.all.upbut_flag.value="1";
	frm1100.submit()
	resetfilp();
	}
	
	function resetfilp(){//����֤
		document.getElementById("filep").outerHTML = document.getElementById("filep").outerHTML;
		}
		
		
	
	function preGrpQuery(){//wangzn add 091201 for Ǳ�ڼ�����ǩԼ
		
		if(!checkElement(document.getElementById('preUnitId')))
		{
			return false;
		}
		if(document.getElementById('preUnitId').value.length==0)
		{
			rdShowMessageDialog("������Ǳ�ڼ��ű�ţ��ٵ����ѯ��",0);
			return;
		}
		
		var preUnitId = document.getElementById("preUnitId").value;
		//var sqlStr = "SELECT Unit_Id,Unit_Name,unit_addr,contact_person,contact_phone,unit_zip,fax FROM dbvipadm.dgrppremsg where Unit_Id like '%25"+preUnitId+"%25' and add_flag <> 'F' and substr(boss_org_code,1,2)='<%=regionCode % >' ";
		
		
		var sqlStr = "50";
		var params = "preUnitId=%"+preUnitId+"%,regionCode="+<%=regionCode%>;
		var wtcOutNum = "7";	
		
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "2|3|4|5|6|0|1|";//�����ֶ� zhangyan mod ���Ӽ�������
		var fieldName = "���ű��|��������|���ŵ�ַ|��ϵ������|��ϵ�˵绰|��ϵ���ʱ�|��ϵ�˴���|";//����������ʾ���С�����
		var pageTitle = "Ǳ�ڼ�����Ϣ��ѯ";
		var path = "fPubSimpSel.jsp";
		path = path + "?sqlStr=" + sqlStr +"&params=" + params +"&wtcOutNum=" + wtcOutNum + "&retQuence=" + retQuence ;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType;
		var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
		if(retInfo ==undefined)
		{
			return;
		}
  		var retToField="contactAddr|contactPerson|contactPhone|contactPost|contactFax|preUnitId|custName|";/*zhangyan ����Ǳ�ڼ�������*/
  
		var chPos_field = retToField.indexOf("|");
		var chPos_retStr;
		var valueStr;
		var obj;
		while(chPos_field > -1)
		{
			obj = retToField.substring(0,chPos_field);
			chPos_retInfo = retInfo.indexOf("|");
			valueStr = retInfo.substring(0,chPos_retInfo);
			document.all(obj).value = valueStr;
			retToField = retToField.substring(chPos_field + 1);
			retInfo = retInfo.substring(chPos_retInfo + 1);
			chPos_field = retToField.indexOf("|");  
		}
  		document.getElementById("preUnitId").readOnly = true;
	}
	
		
		function preTrShow(preBox){//wangzn add 091201 for Ǳ�ڼ�����ǩԼ
			document.all("preTr").style.display="none";
			document.all("preUnitId").value="";
			document.all("preUnitId").readOnly=false;
			if(preBox.checked){
				document.all("preTr").style.display="";
			}
			
		}
</SCRIPT>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	<!--����֤-->
<FORM method=post name="frm1100"   onKeyUp="chgFocus(frm1100)"   ENCTYPE="multipart/form-data"  ><!--����֤-->
       
       <%@ include file="/npage/include/header.jsp" %>   
       <div class="title">
			<div id="title_zi">�ͻ�����</div>
		</div>

	<!------------------------------------------------------------------------>
              <TABLE cellspacing="0">
                <TBODY> 
                <TR> 
                  <TD width="16%" class="blue" > 
                    <div align="left">��������</div>
                  </TD>
                  <TD> 
                    <input name="newCust" onClick="check_newCust()" type="radio" value="new" checked index="2">
                    �½��� 
                    <input type="radio" name="oldCust" onClick="check_oldCust()" value="old" index="3">
                    ���ϻ� 
				  </TD>
                </TR>
                </TBODY> 
              </TABLE>                                
              <TABLE id=tbs9 width=100%  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR> 
                  <TD width="16%" class="blue" > 
                    <div align="left">�ϼ��ͻ�֤������</div>
                  </TD>
                  <TD width="34%"> <font class=orange> 
                    <input id=in2 name=parentIdidIccid class="button" maxlength="20" onKeyUp="if(event.keyCode==13)getInfo_IccId();" index="4">
                    *</font> 
                    <input name=IDQuery type=button style="cursor:hand" onClick="choiceSelWay()" class="b_text" id="custIdQuery" value=��Ϣ��ѯ>
                  </TD>
                  <TD width="16%" align="left"   class="blue" > 
                    <div align="left">�ϼ��ͻ�����</div>
                  </TD>
                  <TD width="34%">
				    <jsp:include page="/npage/common/pwd_1.jsp">
	                <jsp:param name="width1" value="16%"  />
	                <jsp:param name="width2" value="34%"  />
	                <jsp:param name="pname" value="parentPwd"  />
	                <jsp:param name="pwd" value="12345"  />
 	                </jsp:include> 
				<!--
                    <input class="button" id=in6 type="password" name=parentPwd  onkeyUp="if(event.keyCode==13)change_custPwd();" maxlength="6" index="5" value="">
				-->
                    <input name=custQuery2 type=button class="b_text" onClick="change_custPwd();" style="cursor:hand" id="accountIdQuery" value=У��>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">�ϼ��ͻ�����</div>
                  </TD>
                  <TD>  
                    <input class="button" id=in4 name=parentName onKeyUp="if(event.keyCode==13)getInfo_withName();feifaCustName(this);" size=20   maxlength="60">
                    <font class=orange>*</font>
                    <!--<font class=orange>*&nbsp;(�ϼ��ͻ�����Ϊ�����Ҳ��ó�������)</font>-->
                  </TD>
                  <TD class="blue" > 
                    <div align="left">�ϼ��ͻ�֤������</div>
                  </TD>
                  <TD> 
                    <input class="button" id=in3 name=parentIdType readonly>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" >
                    <div align="left">�ϼ��ͻ�ID</div>
                  </TD>
                  <TD> <font class=orange> 
                    <input class="button" id=in0 name=parentId  maxlength="22" onKeyUp="if(event.keyCode==13)getInfo_withId();"  v_type="0_9" v_must=0 v_maxlength=14 >
                    *</font> </TD>
                  <TD class="blue" > 
                    <div align="left">�ϼ��ͻ���ַ</div>
                  </TD>
                  <TD> 
                    <input class="button" id=in5 size=35 name=parentAddr   readonly maxlength="60">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>
              <TABLE cellSpacing="0" >
                <TBODY> 
                <TR> 
                  <TD width=16% class="blue"> 
                    <div align="left">�ͻ����</div>
                  </TD>
                  <TD width=34% class="blue"> 
                    <select align="left" name=ownerType onChange="change()" width=50 index="6">
					<%
					//�õ��������
					String sqlStrt ="select TYPE_CODE,TYPE_NAME from sCustTypeCode Order By TYPE_CODE";
					//retArray = callView.view_spubqry32("2",sqlStr);
					//int recordNum = Integer.parseInt((String)retArray.get(0));
					//result = (String[][])retArray.get(1);
					// result = (String[][])retArray.get(0);	
					%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodet" retmsg="retMsgt" outnum="2">
					<wtc:sql><%=sqlStrt%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="resultt" scope="end" />
					<%	
					int recordNum=0;
					if(retCodet.equals("000000")){
						System.out.println("����sPubSelect���óɹ�");
						recordNum = resultt.length;  
						System.out.println("recordNum  _________________________________________________________"+recordNum);
					}		
					//���ݵ�¼���ŵ�sfuncpower �в鿴�Ƿ��м��ſͻ�����Ȩ��
					/*
					sqlStr="select count(*) from sfuncpower where function_code='1993' and power_code in (select power_code from dloginmsg where login_no='" +workNo+ "')";
					retArray = callView.view_spubqry32("1",sqlStr);
					int recordNum1 = Integer.parseInt(((String[][])retArray.get(0))[0][0]);
					System.out.println("sqlStr="+sqlStr);
					System.out.println("recordNum="+recordNum1 );
					*/
					//sunwt �޸� 20080429
					String paramsIn[] = new String[2];
					paramsIn[0] = workNo;       //����
					paramsIn[1] = "1993";        //��������
					
					//SPubCallSvrImpl callViewCheck = new SPubCallSvrImpl();
					//ArrayList acceptList = new ArrayList();
					/**	try
					{
					acceptList = callViewCheck.callFXService("sFuncCheck", paramsIn, "1","region", regionCode);	
					errCode = callViewCheck.getErrCode();
					errMsg = callViewCheck.getErrMsg();
					}
					catch(Exception e)
					{
					e.printStackTrace();
					logger.error("Call sFuncCheck is Failed!");
					}
					**/
					%>
					<wtc:service name="sFuncCheck" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="1" >
					<wtc:param value="sFuncCheck"/>
					<wtc:params value="<%=paramsIn%>"/>
					<wtc:param value="1"/>
					<wtc:param value="region"/>
					<wtc:param value="<%=regionCode%>"/>
					</wtc:service>
					<wtc:array id="resultr" scope="end" />					
					<%
						System.out.println("_________________________________________________________________________");
						for(int i=0;i<resultr.length;i++){
							for(int j=0;j<resultr[i].length;j++){
								System.out.println("resultr["+i+"]["+j+"]"+"   "+resultr[i][j]);
	                        }
                  		}
				System.out.println("_________________________________________________________________________");

			if(retCode.equals("000000")){
					System.out.println("***************************************************************************");
					System.out.println("����sFuncCheck�ɹ�"+"___retCode :"+retCode+"  retMsg: "+retMsg);
					int recordNum1 =  resultr.length;       //��count(*)ȡ��
					System.out.println("recordNum1________________________________"+recordNum1);
					for(int i=0;i<recordNum;i++){
					if(!"01".equals(resultt[i][0]) && 0==recordNum1) {
						continue;
					}
						out.println("<option class='button' value='" + resultt[i][0] + "'>" + resultt[i][1] + "</option>");
					}
			}else{
					System.out.println("***************************************************************************");
					System.out.println("����sFuncCheckʧ��"+"___retCode :"+retCode+"  retMsg: "+retMsg);
			}

			%>
                    </select>
                  <!--wangzn add 091201 Ǳ�ڼ�����ǩԼ b-->
  <span id="preBox" style="display:none" value='1'>&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;
                  Ǳ�ڼ�����ǩԼ<input type="checkbox" id="isPre" name="isPre" onClick="preTrShow(this)" /></span>
                  <!--wangzn add 091201 Ǳ�ڼ�����ǩԼ e-->
                  </TD>
                  <TD width=16% class="blue" > 
                  	
                    <div align="left">�ͻ�ID</div>
                  </TD>
                  <TD width="34%" class="blue" > 
                    <input name=custId v_type="0_9" class="button" v_must=1 v_name="�ͻ�ID" maxlength="14" readonly>
                    <font class=orange>*</font> 
                    <input name=custQuery type=button class="b_text" onmouseup="getId();" onkeyup="if(event.keyCode==13)getId();" style="cursor:hand" id="accountIdQuery" value=��� index="7">
                  </TD>
                </TR>
                
                <!-- tianyang add for custNameCheck start -->
                <tr id="ownerType_Type">
                	<TD width=16% class="blue" > 
                    <div align="left">���˿�������</div>
                  </TD>
                  <TD colspan="3" width="34%" class="blue" >
                  	<select align="left" name="isJSX" onChange="reSetCustName()" width=50 index="6">
                  		<option class="button" value="0">�ǽ����ſ���</option>
                  		<option class="button" value="1">�����ſ���</option>                  		
                  	<select align="left" name=isJSX onChange="" width=50 index="6">
                  </TD>
                </tr>
                <!-- tianyang add for custNameCheck end -->
                <!--zhangyan add �ͻ�����ȼ� b-->
                <tr id="svcLvl"  style="display:none">
                	<TD width=16% class="blue" > 
                    	<div align="left">�ͻ�����ȼ�</div>
                 	</TD>
                  	<TD colspan="3" width="34%" class="blue" >
						<select align="left"  name = "selSvcLvl" id = "selSvcLvl" >
							<option class="button"  value="00" >00��>��׼������</option>
							<option class="button"  value="01" >01��>���Ƽ�����</option>
							<option class="button"  value="02" >02��>���Ƽ�����</option>
							<option class="button"  value="03" >03��>ͭ�Ƽ�����</option>
						</select>
                  	</TD>
                </tr> 
                <!--zhangyan add �ͻ�����ȼ� e-->            
              
                
                
                <TR> 
                  <TD> 
                    <div align="left" class="blue" >�ͻ���������</div>
                  </TD>
                  <TD> 
                    <select align="left" name=districtCode width=50 index="8">
                      <%
        //�õ��������
                String sqlStr2 ="select trim(DISTRICT_CODE),DISTRICT_NAME from  SDISCODE Where region_code='" + regionCode + "' order by DISTRICT_CODE";                     
               // retArray = callView.view_spubqry32("2",sqlStr);
                
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:sql><%=sqlStr2%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2" scope="end" />
			<%


 if(retCode2.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              int recordNum2 = result2.length;
                for(int i=0;i<recordNum2;i++){
                	if(result2[i][0].trim().equals(districtCode)){
                  	out.println("<option class='button' value='" + result2[i][0] + "'  selected >" + result2[i][1] + "</option>");
                  }
                	else{
                		out.println("<option class='button' value='" + result2[i][0] + "' >" + result2[i][1] + "</option>");
                	}
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}         
               
               
%>
                    </select>
                  </TD>
                  <TD class="blue" > 
                    <div align="left">�ͻ�����</div>
                  </TD>
                  <TD> 
                    <input name=custName id="custName"   v_must=1 v_maxlength=60 v_type="string" onkeyup="feifaCustName(this);"  onchange="change_ConPerson()"  maxlength="60" size=20 index="9" onblur="if(checkElement(this)){change_ConPerson()}">
                    <div id="checkName" style="display:none"><input type="button" class="b_text" value="��֤" onclick="checkName()"></div>
                    <font class=orange>*</font>
                    <!--<font class=orange>*&nbsp;(�ͻ�����Ϊ�����Ҳ��ó�������)</font>-->
                    </TD>
                </TR>
                <tr> 
                  <td width=16% class="blue" > 
                    <div align="left">֤������</div>
                  </td>
                  <td width=34%> 
                    <select align="left" name=idType onChange="change_idType()" width=50 index="10">
                      <%
                      
        //�õ��������
         String sqlStr3 ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";           
 %>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="3">
<wtc:sql><%=sqlStr3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result3" scope="end" /> 
 <%
      if(retCode3.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              int recordNum3 = result3.length;                  
                for(int i=0;i<recordNum3;i++){
                        out.println("<option class='button' value='" + result3[i][0] + "|" + result3[i][2] + "'>" + result3[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}              
               
           
%>
                    </select>
                  </td>
                  <td width=16% class="blue" > 
                    <div align="left">֤������</div>
                  </td>
                  <td width=34%> 
                    <input name="idIccid"  id="idIccid"     v_minlength=5 v_maxlength=20 v_type="string" onChange="change_idType()" maxlength="18"  index="11" value="" onBlur="feifa(this);">
                    <input type="button" name="idCheck" class="b_text" value="��֤" onclick="rpc_chkX('idType','idIccid','A')" >
                    <input type="button" name="iccIdCheck" class="b_text" value="У��" onclick="checkIccId()" >
		    <input type="hidden" name="IccIdAccept" value="<%=IccIdAccept%>">
                    <font class=orange>*</font> </td>
                </tr>
                
<TR id="card_id_type">
	    
      <td colspan=2 align=center>
  			<input type="button" name="read_idCard_one" class="b_text"   value="ɨ��һ�����֤" onClick="RecogNewIDOnly_one()" disabled>
				<input type="button" name="read_idCard_two" class="b_text"   value="ɨ��������֤" onClick="RecogNewIDOnly_two()"disabled>
				<input type="button" name="scan_idCard_two" class="b_text"   value="����" onClick="Idcard()" disabled>
				<input type="button" name="get_Photo" class="b_text"   value="��ʾ��Ƭ" onClick="getPhoto()" disabled>
  			
				</td>
  <td  class="blue">
      	֤����Ƭ�ϴ�
      </td>
      <td>
      	
				 <input type="file" name="filep" id="filep"  onchange="chcek_pic();" >    &nbsp;
				 
				 <iframe name="upload_frame" id="upload_frame" style="display:none"></iframe>
				
				<input type="hidden" name="idSexH" value="1">
  			<input type="hidden" name="birthDayH" value="20090625">
  			<input type="hidden" name="idAddrH" value="������">
  			
				 <input type="button" name="uploadpic_b" class="b_text"   value="�ϴ���Ƭ" onClick="uploadpic()"  disabled>
      	
      	</td>
     </tr>
                <tr> 
                  <td class="blue" > 
                    <div align="left">֤����ַ</div>
                  </td>
                  <td> 
                    <input name=idAddr  id="idAddr"    v_must=1 v_type="string"  maxlength="60" v_maxlength=60 size=30 index="12" onblur="if(checkElement(this)){changeCardAddr(this)}">
                    <font class=orange>*</font> </td>
                  <td class="blue" > 
                    <div align="left">֤����Ч��</div>
                  </td>
                  <td> 
                    <input class="button" name=idValidDate v_must=0 v_maxlength=8 v_type="date"  maxlength=8 size="8" index="13" onblur="if(checkElement(this)){chkValid();}">
                    <!--
                    <img src="../../js/common/date/button.gif" style="cursor:hand"  onclick="fPopUpCalendarDlg(idValidDate);return false" alt=�������������˵� align=absMiddle readonly>
                     -->
                  </td>
                </tr>
				
				
			 <TR>      
			
				   <jsp:include page="f1100_pwd.jsp">
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="custPwd"  />
					  <jsp:param name="pcname" value="cfmPwd"  />
			 			<jsp:param name="pvalue" value="" />
				   </jsp:include>
			  </TR>
                <!--TR bgcolor="#EEEEEE"> 
                  <TD> 
                    <div align="left">�ͻ����룺</div>
                  </TD>
                  <TD bgcolor="#EEEEEE"> 
                    <input name=custPwd type="password" v_type="0_9" class="button" v_must=0 v_maxlength=6 v_name="�ͻ�����" maxlength="6" id=passwd1 index="14">
                  </TD>
                  <TD> 
                    <div align="left">У��ͻ����룺</div>
                  </TD>
                  <TD> 
                    <input name=cfmPwd type="password" class="button" v_type="0_9" v_must=0 v_maxlength=6 v_name="У��ͻ�����" maxlength="6"  index="15">
                  </TD>
                </TR-->
                <TR> 
                  <TD class="blue" > 
                    <div align="left">�ͻ�״̬</div>
                  </TD>
                  <TD colspan="3"> 
                    <select align="left" name=custStatus width=50 index="16">
                      <%
        //�õ��������
       
                String sqlStr4 ="select trim(STATUS_CODE),STATUS_NAME from sCustStatusCode order by STATUS_CODE";                      
               // retArray = callView.view_spubqry32("2",sqlStr4);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
               // result = (String[][])retArray.get(0);
               
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode4" retmsg="retMsg4" outnum="2">
<wtc:sql><%=sqlStr4%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result4" scope="end" /> 
<%
         
          if(retCode4.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
                int recordNum4 = result4.length;                  
                for(int i=0;i<recordNum4;i++){
                        out.println("<option class='button' value='" + result4[i][0] + "'>" + result4[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}      
%>


<%             
%>
                    </select>
                    <select  align="left" name=custGrade width=50 index="17" style="display:none" >
                      <%
        //�õ��������
          String sqlStr5 ="select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode " + 
                   " where REGION_CODE ='" + regionCode + "' order by OWNER_CODE";                  
                //retArray = callView.view_spubqry32("2",sqlStr5);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
               
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="2">
<wtc:sql><%=sqlStr5%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result5" scope="end" /> 

<%    
    if(retCode5.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
               int recordNum5 = result5.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option class='button' value='" + result5[i][0] + "'>" + result5[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}      

               
%>
                    </select>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">�ͻ���ַ</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=custAddr class="button" v_type="string" v_must=1 v_maxlength=60  onchange="change_ConAddr()" maxlength="60" size=35 index="18" onblur="checkElement(this);">
                  	<font class=orange>*</font> 
                  </TD>
                  </TD>
                </TR>
                <!--wangzn add 091201 forǱ�ڼ�����ǩԼ b-->
                <tr id="preTr" style="display:none"> 
                	<td class="blue" >Ǳ�ڼ��ű��</td>
                	<td colspan="3"><input name="preUnitId" id="preUnitId" class="button"  maxlength="20" size=20 v_type=0_9 v_must=0 v_minlength=10 ><font class=orange>*</font>
                  <input name=preUnitIdQuery type=button class="b_text" onmouseup="preGrpQuery()" onkeyup="if(event.keyCode==13)preGrpQuery();" style="cursor:hand" id="preUnitIdQuery" value=��ѯ >
                </tr>
                 <!--wangzn add 091201 forǱ�ڼ�����ǩԼ e-->
                <TR> 
                  <TD class="blue" > 
                    <div align="left">��ϵ������</div>
                  </TD>
                  <TD>                  		
                  	<input name=contactPerson class="button" value="" v_type="string" onkeyup="feifaCustName(this);" maxlength="60" size=20 index="19" v_must=1 v_maxlength=20 onblur="checkElement(this);">
                  	<font class=orange>*</font>
                  	<!--<font class=orange>*&nbsp;(��ϵ������Ϊ�����Ҳ��ó�������)</font>-->
                  </TD>
                  <TD class="blue" > 
                    <div align="left">��ϵ�˵绰</div>
                  </TD>
                  <TD> 
                    <input name=contactPhone class="button" v_must=1 v_type="phone" maxlength="20"  index="20" size="20" onblur="checkElement(this);">
                    <font class=orange>*</font> </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">��ϵ�˵�ַ</div>
                  </TD>
                  <TD> 
                    <input name=contactAddr  class="button" v_must=1 v_type="string"  maxlength="60" v_maxlength=60 size=30 index="21"  onpropertychange="document.all.contactMAddr.value=this.value;" onblur="if(checkElement(this)){document.all.contactMAddr.value=this.value;}">
                    <font class=orange>*</font> </TD>
                  <TD class="blue" > 
                    <div align="left">��ϵ���ʱ�</div>
                  </TD>
                  <TD> 
                    <input name=contactPost class="button" v_type="zip" v_name="��ϵ���ʱ�" maxlength="6"  index="22" size="20">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">��ϵ�˴���</div>
                  </TD>
                  <TD> 
                    <input name=contactFax class="button" v_must=0 v_type="phone" v_name="��ϵ�˴���" maxlength="20"  index="23" size="20">
                  </TD>
                  <TD class="blue" > 
                    <div align="left">��ϵ��E_MAIL</div>
                  </TD>
                  <TD> 
                    <input name=contactMail class="button" v_must=0 v_type="email" v_name="��ϵ��E_MAIL" maxlength="30" size=30 index="24">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">��ϵ��ͨѶ��ַ</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=contactMAddr class="button" v_must=1 v_maxlength=60 v_type="string"  maxlength="60" size=30 index="25" onblur="checkElement(this);">
                    <font class=orange>*</font></TD>
                </TR>
                </TBODY> 
              </TABLE> 
                                        
              <TABLE id=tb0 cellSpacing="0" >
                <TBODY> 
                <TR> 
                  <TD width=16% class="blue" > 
                    <div align="left">�ͻ��Ա�</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=custSex width=50 index="26">
                      <%
        //�õ��������
            String sqlStr6 ="select trim(SEX_CODE), SEX_NAME from ssexcode order by SEX_CODE";                 
                //retArray = callView.view_spubqry32("2",sqlStr6);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
              
 %>
 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg6" outnum="2">
<wtc:sql><%=sqlStr6%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result6" scope="end" /> 

<%    
    if(retCode6.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
                int recordNum6 = result6.length;                  
                for(int i=0;i<recordNum6;i++){
                        out.println("<option class='button' value='" + result6[i][0] + "'>" + result6[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}            
%>
                    </select>
                  </TD>
                  <TD width=16%  class="blue" > 
                    <div align="left">��������</div>
                  </TD>
                  <TD width="34%"> 
                    <input  name=birthDay id="birthDay"   maxlength=8 index="27"  v_must=0 v_maxlength=8 v_type="date" size="8" onblur="checkElement(this);">
                    <!--
                    <img src="../../js/common/date/button.gif" style="cursor:hand"  onclick="fPopUpCalendarDlg(birthDay);return false" alt=�������������˵� align=absMiddle >
                -->
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">ְҵ���</div>
                  </TD>
                  <TD> 
                    <select align="left" name=professionId width=50 index="28">
                      <%
        //�õ��������
      
                String sqlStr7 ="select trim(PROFESSION_ID), PROFESSION_NAME from sprofessionid order by PROFESSION_ID DESC";                      
              //  retArray = callView.view_spubqry32("2",sqlStr7);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
               // result = (String[][])retArray.get(0);
               
%>
 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode7" retmsg="retMsg7" outnum="2">
<wtc:sql><%=sqlStr7%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result7" scope="end" /> 

<%    
    if(retCode7.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
               int recordNum7 = result7.length;                  
                for(int i=0;i<recordNum7;i++){
                        out.println("<option class='button' value='" + result7[i][0] + "'>" + result7[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}            
%>
                    </select>
                  </TD>
                  <TD class="blue" > 
                    <div align="left">ѧ��</div>
                  </TD>
                  <TD> 
                    <select align="left" name=vudyXl width=50 index="29">
                      <%
        //�õ��������
           String sqlStr8 ="select trim(WORK_CODE), TYPE_NAME from SWORKCODE Where region_code ='" + regionCode + "' order by work_code DESC";                    
              //  retArray = callView.view_spubqry32("2",sqlStr8);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
               
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode8" retmsg="retMsg8" outnum="2">
<wtc:sql><%=sqlStr8%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result8" scope="end" /> 

<%    
    if(retCode8.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
             int recordNum8 = result8.length;                  
                for(int i=0;i<recordNum8;i++){
                        out.println("<option class='button' value='" + result8[i][0] + "'>" + result8[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}    
  %>
                    </select>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">�ͻ�����</div>
                  </TD>
                  <TD> 
                    <input name=custAh class="button" maxlength="20"  index="30" size="20">
                  </TD>
                  <TD class="blue" > 
                    <div align="left">�ͻ�ϰ��</div>
                  </TD>
                  <TD> 
                    <input name=custXg class="button" maxlength="20"  index="31">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>                                
        
              <TABLE id=tb1 cellSpacing="0" style="display:none">
                <TBODY> 

                <TR> 
                  <TD width=16% class="blue" > 
                    <div align="left">��λ����</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=unitXz1 width=50 index="32">
                      <%
                      //�õ��������
               
                String sqlStr9 ="select trim(TYPE_CODE), TYPE_NAME from sunittype order by TYPE_CODE";                    
                //retArray = callView.view_spubqry32("2",sqlStr9);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
                
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode9" retmsg="retMsg9" outnum="2">
<wtc:sql><%=sqlStr9%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result9" scope="end" /> 

<%    
    if(retCode9.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
            int recordNum9 = result9.length;                  
                for(int i=0;i<recordNum9;i++){
                        out.println("<option class='button' value='" + result9[i][0] + "'>" + result9[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}          
%>
                    </select>
                  </TD>
                  <TD width=16% class="blue" > 
                    <div align="left">Ӫҵִ������</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=yzlx width=50 index="33">
                      <%
        //�õ��������
        
                String sqlStr10 ="select trim(LINCENT_TYPE), TYPE_NAME from slicencetype order by LINCENT_TYPE";                
               // retArray = callView.view_spubqry32("2",sqlStr10);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
               // result = (String[][])retArray.get(0);
              
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode10" retmsg="retMsg10" outnum="2">
<wtc:sql><%=sqlStr10%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result10" scope="end" /> 
<%    
    if(retCode10.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
           int recordNum10 = result10.length;                  
                for(int i=0;i<recordNum10;i++){
                        out.println("<option class='button' value='" + result10[i][0] + "'>" + result10[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}                       
%>
                    </select>
                  </TD>
                </TR>
                
                
                <TR> 
                  <TD class="blue" > 
                    <div align="left">Ӫҵִ�պ���</div>
                  </TD>
                  <TD> 
                    <input name=yzhm class="button" maxlength="20"  index="34">
                  </TD>
                  <TD class="blue" > 
                    <div align="left">Ӫҵִ����Ч��</div>
                  </TD>
                  <TD> 
                    <input name=yzrq class="button"  index="35" v_must=0 v_maxlength=8 v_type="date" v_name="Ӫҵִ����Ч��" maxlength=8 size="8">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">���˴���</div>
                  </TD>
                  <TD COLSPAN="3"> 
                    <input name=frdm class="button" maxlength="20"  index="36">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>
              
              
			     <TABLE width=100% id=td2 cellSpacing="0" style="display:none">
            
                <TR> 
				     
                  <TD width=16% class="blue" > 
                    <div align="left">ԭ���ź�</div>
                  </TD>
                  <TD width=84%> 
         			  <div align="left"><input name=oriGrpNo class="button" maxlength="10"  index="37" v_must=0 v_maxlength=10 v_type=0_9 v_name="ԭ���ź�"></div>
					   </td>
				   </tr>
				   
				   
				 <TABLE id=td3  cellSpacing="0" style="display:none">
				 	<TBODY> 
               <TR> 
         <TD width=16% class="blue" > 
                    <div align="left">���ŵȼ�</div>
                  </TD>
                  <TD width=34% colspan="3"> 
                    <select align="left" name=unitXz width=50 index="32">
<%
                //�õ��������
           
                String sqlStr11 ="select trim(owner_code), owner_NAME from dbvipadm.sGrpOwnerCode  where owner_code in ('C1','C2','C3')";                    
               // retArray = callView.view_spubqry32("2",sqlStr11);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
              //  result = (String[][])retArray.get(0);
              
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="2">
<wtc:sql><%=sqlStr11%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result11" scope="end" /> 

<%    
    if(retCode11.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              
            int recordNum11 = result11.length;                  
                for(int i=0;i<recordNum11;i++){
                        out.println("<option class='button' value='" + result11[i][0] + "'>" + result11[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}            


      
%>
                   </select>
                  </TD>
                </TR>
    <!--luxc 20080326 add-->
    <tr>
    	<td width=16% class="blue" >�Ƿ��ǲ߷�����</td>
    	<td width=34%>
    		<select align="left" name="instigate_flag" onChange="change_instigate()" width=50 index="42">
    			<option class="button" value="0">...��ѡ��...</option>
    			<option class="button" value="Y">��->Y</option>
    			<option class="button" value="N">��->N</option>
    		</select>
    		<font class=orange>*</font>
    	</td>
    	<td width=17% class="blue" >�Ƿ��þ�������Э��</td>
    		
    	<td width=33%>
    		<select align="left" name="getcontract_flag" width=50 index="42" disabled >
    			<option class="button" value="0">...��ѡ��...</option>
    			<option class="button" value="Y">��->Y</option>
    			<option class="button" value="N">��->N</option>
    		</select>
    	</td>
	</tr>  
	<!--luxc 20080326 add end-->
	
	   </TBODY> 
	  </TABLE>			  
  <TABLE cellSpacing="0">
    <TBODY> 
    <TR style="display:none"> 
      <TD width=16% class="blue" > 
        <div align="left">ϵͳ��ע</div>
      </TD>
      <TD> 
        <input class="button" name=sysNote size=60 readonly maxlength="60">
      </TD>
    </TR>
    <TR> 
      <TD width="16%" class="blue" > 
        <div align="left">�û���ע</div>
      </TD>
      <TD> 
        <input name=opNote class="button" size=60 maxlength="60" index="38"  v_must=0 v_maxlength=60 v_type="string" v_name="�û���ע">
      </TD>
    </TR>
    </TBODY> 
  </TABLE>                           
<TABLE cellSpacing="0">
  <TBODY>
    <TR> 
          <TD align=center id="footer"> 
            <input class="b_foot_long" name=print  onclick="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  type=button value=ȷ��  index="39" disabled>
	        <input class="b_foot" name=reset1 type=button  onclick=" window.location.href='f1100_1.jsp';" value=��� index="40">
	        <input class="b_foot" name=back type=button onclick="
	        <% 
                if("1".equals(inputFlag)){ 
                    out.print(" window.close() ");
                }else{
                    out.print(" removeCurrentTab() ");
                } 
            %>
	        " value=�ر� index="41">
            <input type="reset" name="Reset" value="Reset" style="display:none">
          </TD>
    </TR>
  </TBODY>
</TABLE>
  <input type="hidden" name="ReqPageName" value="f1100_1">
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" name="unitCode" value=<%=orgCode%>>
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
  <input type="hidden" id=in1 name="hidPwd" v_name="ԭʼ����">
  <input type="hidden" name="hidCustPwd">  			<!--���ܺ�Ŀͻ�����-->
  <input type="hidden" name="temp_custId">
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--����У���־-->
  <input type="hidden" name="workName" value=<%=workName%> >
  <input type="hidden" name="opCode" value="<%=opCode%>">
  
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
  <input type="hidden" name="inputFlag" value="<%=inputFlag%>">
  <iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
  <input type="hidden" name="card_flag" value="">  <!--���֤������־-->
  <input type="hidden" name="pa_flag" value="">  <!--֤����־-->
  <input type="hidden" name="m_flag" value="">   <!--ɨ����߶�ȡ��־������ȷ���ϴ�ͼƬʱ���ͼƬ��-->
  <input type="hidden" name="sf_flag" value="">   <!--ɨ���Ƿ�ɹ���־-->
  <input type="hidden" name="pic_name" value="">   <!--��ʶ�ϴ��ļ�������-->
	<input type="hidden" name="up_flag" value="0">
	<input type="hidden" name="but_flag" value="0"> <!--��ť�����־-->
	<input type="hidden" name="upbut_flag" value="0"> <!--�ϴ���ť�����־-->
	<input type="hidden" name="ziyou_check" value="<%=resultl0[0][0]%>">
  <%@ include file="/npage/include/footer.jsp" %> 
<jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
</body>
<%@ include file="interface_provider.jsp" %>   
</html>
