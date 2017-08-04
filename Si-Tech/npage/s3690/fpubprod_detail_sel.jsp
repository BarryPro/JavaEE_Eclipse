<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-03-19
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%@ page import="java.util.ArrayList" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s3500/pub.js"></script>

<%
    //�õ��������
    ArrayList retArray = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
    String[] paramsIn = null;
    String[] paraIn = null;
    String opName = "���";

    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    Logger logger = Logger.getLogger("fpubprod_sel.jsp");

%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/

    /*�õ�����Ա�Ĺ��ź�����*/

    String workno = (String)session.getAttribute("workNo");
    String nopass  = (String)session.getAttribute("password");
    String powerRight = ((String)session.getAttribute("powerRight")).trim();
    String prodCode = request.getParameter("prodCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);

	String group_id = "";
    String org_id = "";
    
	String sqlStr = "";
	//ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
	//String[][] result2  = null;
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result2" scope="end" />
	<%
	String province_run = "";
	if (result2 != null && result2.length != 0) 
	{
		province_run = result2[0][0];
	}
	
    
    String class_code = "";
int recordNum = 0;
    try
    {
        if(province_run.equals("20"))   //����
        {
        	sqlStr = "select '9999999', a.group_id, nvl(b.innet_type,'99') "
        	        +"  from dLoginMsg a, sTownCode b "
        	        +" where a.login_no =:workno "
        	        +"   and substr(a.org_code,1,2) = b.region_code(+)"
        	        +"   and substr(a.org_code,3,2) = b.district_code(+)"
        	        +"   and substr(a.org_code,5,3) = b.town_code(+)";
        }
        else
        {
        	sqlStr = "select org_id, a.group_id, nvl(b.innet_type,'99') from dLoginMsg a, sTownCode b where a.login_no =:workno and a.group_id = b.group_id(+)";
        }
        System.out.print("sqlStr:"+sqlStr);
        //retArray = callView.sPubSelect("3",sqlStr);
        
        paraIn[0] = sqlStr;    
        paraIn[1]="workno="+workno;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
        	<wtc:param value="<%=paraIn[0]%>"/>
        	<wtc:param value="<%=paraIn[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr2" scope="end"/>
<%

        //System.out.print("retArray:"+retArray);
        //result = (String[][])retArray.get(0);
        if(retCode2.equals("000000")){
            result = retArr2;
        }
        if (result[0][0].trim().length() == 0) {
            throw new Exception("��ѯ����Ա��������Ȩ��ʧ�ܣ�");
        }
        org_id = result[0][0];
        group_id = result[0][1];
        class_code = result[0][2];
    }
    catch(Exception e){
        logger.error("��ѯsSmSelPAttr����!");
    }

    String owner_code = "JT";
    String credit_code = "E";
    String product_level = "1"; //����Ʒ
    String business_code = "0"; //����

    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    //System.out.print("sqlStr="+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <HEAD>
<TITLE>������BOSS-���Ų�Ʒ��ѯ</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type=text/javascript>
	var sflagcheck="0";
function saveTo()
{
	
	var rIndex;        //ѡ�������
	var retValue = ""; //����ֵ
	var chPos;         //�ַ�λ��
	var obj;
	var fieldNo;        //���������к�
	var retFieldNum = document.fPubSimpSel.retFieldNum.value;
	var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
	var retNum = retQuence.substring(0,retQuence.indexOf("|"));
	retQuence = retQuence.substring(retQuence.indexOf("|")+1);
	var tempQuence;
	if(retFieldNum == "")	
	{     
		return false;   
	}
	for(i=0;i<document.fPubSimpSel.elements.length;i++)
	{ 
		if (document.fPubSimpSel.elements[i].name=="List")
		{
			if (document.fPubSimpSel.elements[i].checked==true)
			{
				rIndex = document.fPubSimpSel.elements[i].RIndex;
				retValue += document.all("Rinput" + rIndex + "0").value + ",";
				retValue += document.all("Rinput" + rIndex + "2").value + ",";
				retValue += document.all("Rinput" + rIndex + "4").value + ",";
				retValue += "0000,";
				retValue += document.all("Rinput" + rIndex + "11").value + ",";
								
				var iCk=-1;
				var youhuimax;
				var youhuistr;
				var flag_14_val = document.all("flag_14_" + rIndex ).value;
				
				//alert("flag_14_val = "+flag_14_val);
				
				if(flag_14_val!=1){
				if (document.all("flag_" + rIndex)[0].checked) 
				{
					iCk=0;
					if (document.all("userPrice_" + rIndex).value=="")
					{
						rdShowMessageDialog("�����������Ϣ");
						return false;
					}
					if (!forReal(document.all("userPrice_" + rIndex)))
					{
					    hiddenTip();
					    rdShowMessageDialog("�����ʽ����",0);
						return false;
					}
					if (parseFloat(document.all("userPrice_" + rIndex).value) <= 0 || parseFloat(document.all("userPrice_" + rIndex).value)>1)
					{
						//rdShowMessageDialog("������Ϣ�������󣬱���С��1");
						rdShowMessageDialog("����ʱ���ֵӦ��0��1֮���С��,С���������λ����!");
						document.all("userPrice_" + rIndex).select();
						document.all("userPrice_" + rIndex).focus();
						return false;
					}	
					
					var a=document.all("userPrice_"+rIndex).value.indexOf(".");
					if(a!=-1){
						var fStr=document.all("userPrice_"+rIndex).value.substring(a+1);
						if(fStr.length>2){
							rdShowMessageDialog("С���������λ��");
							return false;
						}
					}
					
					if(document.all("isyhhzs_" + rIndex).value=="1") {
					if(document.all("youhuihzs_" + rIndex).value=="") {
						rdShowMessageDialog("��������ߴ���Ϣ");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)*(1-parseFloat(document.all("userPrice_" + rIndex).value))).toFixed(2);
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("��ߴ�������д�����ֵΪ"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)<youhuimax) {
							rdShowMessageDialog("��ߴ�������д����СֵΪ"+youhuimax);
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}
					
					youhuistr=(parseFloat(document.all("youhuihzs_" + rIndex).value).toFixed(2)-youhuimax).toFixed(2);
				 }
				}
				if (document.all("flag_" + rIndex)[1].checked) 
				{
					iCk=1;
					if (document.all("userPrice_" + rIndex).value=="")
					{
						rdShowMessageDialog("�����붨����Ϣ");
						return false;
					}
					if (!forInt(document.all("userPrice_" + rIndex)))
					{
						return false;
					}
					
					if(document.all("isyhhzs_" + rIndex).value=="1") {
					
						if(document.all("youhuihzs_" + rIndex).value=="") {
						rdShowMessageDialog("��������ߴ���Ϣ");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)-parseFloat(document.all("userPrice_" + rIndex).value)).toFixed(2);
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("��ߴ�������д�����ֵΪ"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)<youhuimax) {
							rdShowMessageDialog("��ߴ�������д����СֵΪ"+youhuimax);
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}					
					youhuistr=(parseFloat(document.all("youhuihzs_" + rIndex).value).toFixed(2)-youhuimax).toFixed(2);
				}
					
				}
				if (iCk==-1)
				{
					rdShowMessageDialog("��ѡ���������");
					document.all("userPrice_" + rIndex).select();
					document.all("userPrice_" + rIndex).focus();
					return false;
				}
				
			
				retValue += document.all("flag_" + rIndex)[iCk].value + ",";
				retValue += document.all("userPrice_" + rIndex).value + ",";
				if(document.all("isyhhzs_" + rIndex).value=="1") {
					retValue += youhuistr + "|";
				}else {
					retValue +="|";
				}
				
				
				if(document.all("flag_" + rIndex)[iCk].value=="" && document.all("userPrice_" + rIndex).value=="") {
				}else {
					/*
					alert(
									"rIndex = "+rIndex+"\n"+
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									"oldpricess = "+document.all("Rinput" + rIndex + "10").value+"\n"+
									"flagss = "+document.all("flag_" + rIndex)[iCk].value+"\n"+
									"userPrice = "+document.all("userPrice_" + rIndex).value+"\n"
									
							 );
							 */
					var myPacketsd = new AJAXPacket("ajax_checkYJMessage.jsp","����У���������Ժ����Ժ�......");
					myPacketsd.data.add("offerids",document.all("Rinput" + rIndex + "0").value);
					myPacketsd.data.add("oldpricess",document.all("Rinput" + rIndex + "10").value);
					myPacketsd.data.add("flagss",document.all("flag_" + rIndex)[iCk].value);
					myPacketsd.data.add("userPrice",document.all("userPrice_" + rIndex).value);
					myPacketsd.data.add("opcode","3690");
					core.ajax.sendPacket(myPacketsd,checksimtypesd);
					myPacketsd=null;
				}	
				}else{
					/*
					alert(
									"rIndex = "+rIndex+"\n"+
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									"oldpricess = "+document.all("Rinput" + rIndex + "10").value+"\n"+
									"flagss = "+"0\n"+
									"userPrice = "+document.all("userPrice_" + rIndex).value+"\n"
									
							 );
							 */

				retValue +="0" + ",";
				retValue += document.all("userPrice_" + rIndex).value + ",";
				retValue +="|";
				
				
						var myPacketsd = new AJAXPacket("ajax_checkYJMessage.jsp","����У���������Ժ����Ժ�......");
					myPacketsd.data.add("offerids",document.all("Rinput" + rIndex + "0").value);
					myPacketsd.data.add("oldpricess",document.all("Rinput" + rIndex + "10").value);
					myPacketsd.data.add("flagss","0");
					myPacketsd.data.add("userPrice",document.all("userPrice_" + rIndex).value);
					myPacketsd.data.add("opcode","3690");
					core.ajax.sendPacket(myPacketsd,checksimtypesd);
					myPacketsd=null;
				}
					if(sflagcheck=="1") {
					break;
					}
				
				
			/*tempQuence = retQuence;
			for(n=0;n<retNum;n++)
			{   
				chPos = tempQuence.indexOf("|");
				fieldNo = tempQuence.substring(0,chPos);
				//alert(fieldNo);
				obj = "Rinput" + rIndex + fieldNo;
				//alert(obj);
					retValue = retValue + document.all(obj).value + "|";
					tempQuence = tempQuence.substring(chPos + 1);
				}
				window.returnValue= retValue;*/
			}
		}
	}
	if(retValue =="")
	{
		rdShowMessageDialog("��ѡ����Ϣ�",0);
		return false;
	}

if(sflagcheck=="0") {
	opener.getvalue(retValue);
	window.close(); 
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
function allChoose()
{   //��ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = true;
        }
    }  
}

function cancelChoose()
{   //ȡ����ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = false;
        }
    }  
}

function sOnclicks(num) {
			if (document.all("isyhhzs_" + num).value=="1") {
			if(document.all("userPrice_" + num).value!="") {
				var youhuimax;
				if (document.all("flag_" + num)[0].checked) 
				{
						youhuimax=parseFloat(Math.abs(document.all("Rinput" + num + "10").value)*(1-parseFloat(document.all("userPrice_" + num).value))).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;		
				    //$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");	
				    soncheckbox(num);	
				}
				if (document.all("flag_" + num)[1].checked) 
				{
						youhuimax=parseFloat(Math.abs(document.all("Rinput" + num + "10").value)-parseFloat(document.all("userPrice_" + num).value)).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;		
				    soncheckbox(num);			
				}
			}
		}

}

function soncheckbox(num) {
	

	var retFieldNum = document.fPubSimpSel.retFieldNum.value;
	var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
	var retNum = retQuence.substring(0,retQuence.indexOf("|"));
	retQuence = retQuence.substring(retQuence.indexOf("|")+1);
	var tempQuence;
	var rIndex;
	if(retFieldNum == "")	
	{     
		return false;   
	}
	for(i=0;i<document.fPubSimpSel.elements.length;i++)
	{ 
		if (document.fPubSimpSel.elements[i].name=="List")
		{
			if (document.fPubSimpSel.elements[i].checked==true)
			{
				
		var dixianxianshi;
		var youhhzsxianshi;
    rIndex = document.fPubSimpSel.elements[i].RIndex;
			if (document.all("isyhhzs_" + rIndex).value=="1") {
							if (document.all("flag_" + rIndex)[1].checked) 
					{
							dixianxianshi=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)-parseFloat(document.all("userPrice_" + rIndex).value)).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_" + rIndex).value);
					    $("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ;����"+dixianxianshi+"����ߴ�"+youhhzsxianshi+"��");					
					}else if (document.all("flag_" + rIndex)[0].checked) {
						  dixianxianshi=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)*parseFloat(document.all("userPrice_" + rIndex).value)).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_" + rIndex).value);
					    $("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ;����"+dixianxianshi+"����ߴ�"+youhhzsxianshi+"��");			
							
			    }
	
			}else {
							$("#keShowSpan").text("ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ");
			}
	   
	}
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

</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
    <%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

  <table cellspacing="0">
<TR>
	<Th nowrap>��Ʒ����</Th>
	<Th nowrap>��Ʒ����</Th>
	<Th>�������</Th>
	<Th nowrap>��������</Th>
	<Th>�۸����</Th>
	<Th nowrap>�۸�����</Th>
	<!--<TD nowrap>�շѷ�ʽ</TD>-->
	<Th>�շѷ�ʽ����</Th>
	<!--<TD nowrap>��ȡ��ʽ</TD>-->
	<Th��ȡ��ʽ����</Th>
	<Th nowrap>�۸�</Th>
	<Th nowrap>�������</Th>
</TR> 
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("");
     fieldNum = String.valueOf(tempNum);
%> 

<%
    //���ݴ����Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      	
            paramsIn = new String[1];
            paramsIn[0] = prodCode;

            //retArray = callView.callFXService("sHGetProdDet", paramsIn, "12", "region", "01");
            %>
            <wtc:service name="sHGetProdDetE" routerKey="region" routerValue="<%=regionCode%>" retcode="sHGetProdDetCode" retmsg="sHGetProdDetMsg" outnum="15" >
            	<wtc:param value="<%=paramsIn[0]%>"/>
            </wtc:service>
            <wtc:array id="sHGetProdDetArr" scope="end"/>
            <%
            
//callView.printRetValue();
      		//result = (String[][])retArray.get(4);
            //allNumStr = (String[][])retArray.get(0);
            //recordNum = result.length;
            recordNum = sHGetProdDetArr.length;
            
            System.out.println("recordNum:" + recordNum);
System.out.println("fieldNum:" + fieldNum);
      		for(int i=0;(i<recordNum) && (i<iEndPos);i++)
      		{
      		//out.println("-"+sHGetProdDetArr[i][12]);
      		//out.println("sHGetProdDetArr[i][14] - "+sHGetProdDetArr[i][14]);
      		//sHGetProdDetArr[0][12]="0";
      		//sHGetProdDetArr[1][12]="1";
       		//sHGetProdDetArr[0][13]="";
      		//sHGetProdDetArr[1][13]="4000";     		
      		//System.out.println("sHGetProdDetArr["+recordNum+"]["+iEndPos+"]="+sHGetProdDetArr[recordNum][iEndPos]);
                if (i < iStartPos) continue;
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR >");
      		    for(int j=0;j<12;j++)
      		    {
      		    System.out.println("sHGetProdDetArr["+i+"]["+j+"]="+sHGetProdDetArr[i][j]);
      		    	if (j==6 || j==8)
      		    		continue;
                    if(j==0)
                    {
                        typeStr = "<TD >&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onClick='soncheckbox("+i+")'  onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (sHGetProdDetArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (sHGetProdDetArr[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else if(j==7 || j==11)
                    {
          		        inputStr = inputStr + "<TD style='display:none;'>&nbsp;" + (sHGetProdDetArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (sHGetProdDetArr[i][j]).trim() + "'readonly></TD>";          		            
                    } 
                	else
                    {
          		        inputStr = inputStr + "<TD >&nbsp;" + (sHGetProdDetArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (sHGetProdDetArr[i][j]).trim() + "'readonly></TD>";          		            
                    }          		           
      		    }
      		    
      		    if("1".equals(sHGetProdDetArr[i][14])) {
      		    	inputStr += "<TD nowrap><input type=hidden name=flag_14_"+i+" value=1   />����&nbsp;<select name=userPrice_"+i+"><option value='0.6'>6��</option><option value='0.65'>6.5��</option><option value='0.7'>7��</option><option value='0.75'>7.5��</option><option value='0.8'>8��</option><option value='0.85'>8.5��</option><option value='0.9'>9��</option><option value='0.95'>9.5��</option><option value='1'>���ۿ�</option></select><input type=hidden name=isyhhzs_"+i+" value="+sHGetProdDetArr[i][12]+"></td>";
      		    }else{
      		    	inputStr += "<TD nowrap><input type=hidden name=flag_14_"+i+" value=0   /><input type=radio name=flag_"+i+" value=0 onClick='sOnclicks("+i+")'>����&nbsp;<input type=radio name=flag_"+i+" value=1 onClick='sOnclicks("+i+")'>�Ż�&nbsp;";
      		    	inputStr += "<input type=text v_name='�������' size=5 name=userPrice_"+i+" onBlur='sOnclicks("+i+")'><input type=hidden name=isyhhzs_"+i+" value="+sHGetProdDetArr[i][12]+">";
      		    
	      		    if("1".equals(sHGetProdDetArr[i][12])) {
		      		    
		      		       inputStr += "&nbsp;��ߴ�&nbsp;<input type=text v_name='��ߴ�' onblur='shuzicheck(this);soncheckbox("+i+");'  onkeyup='clearNoNum(this)' size=10 name=youhuihzs_"+i+" value='0' ></TD>";
		      		    
	      		    }else {
	      		    inputStr += "</TD>";
	      		  	}
      		  	}
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
     	}catch(Exception e){
     		System.out.println(e.toString());
       		
     	}          
%>
<%


%>   
   </tr>
   	<tr>
   		<td colspan="9" style="text-align:right;">
   			<font class="orange" id="keShowSpan">ע���Ż�Ϊ�����Żݵ�Ǯ�����۸�-�Ż�=���ռ�Ǯ</font>
   		</td>
  	</tr>
  </table>
    <TABLE cellSpacing=0>
    <tr><td>
<%	
//    int iQuantity = allNumStr.length;
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
</td></tr>
</table>
<!------------------------------------------------------>
    <TABLE cellSpacing=0>
        <TR id="footer"> 
            <TD align=center>
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
<%
				}
%>             
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;        
            </TD>
        </TR>
    </TABLE>
	
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
