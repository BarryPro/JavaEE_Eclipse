<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.08.29
������������������������������������������

  ��ҳ�� ֻ�ṩ e964����ȡ����ѡ��SIM�� ģ����е�д������������ģ���벻Ҫ���ã�
         
������������������������������������
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("gb2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
    String[][] retInfo = new String[][]{};
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    String sys_Date = "";
    String showType = "";

    String fieldNum = "";
    String s2= new String();
    StringBuffer s1 = new StringBuffer(1000);

   String strDllData = new String();
   String tmpStr1 = new String();
   String tmpStr2 = new String();
%>
<%  String path=request.getRealPath("");
    String op_code=request.getParameter("op_code");
    String opName = "SIM��д��";
    String pageTitle = request.getParameter("pageTitle");
    String regioncode = request.getParameter("regioncode");
    String phone = request.getParameter("phone");
    String sim_type=request.getParameter("sim_type");
    String sim_no=request.getParameter("sim_no");
    String simCardNumber = request.getParameter("simCardNumber");
    String simimsi = request.getParameter("simimsi");
    String simsmsp = request.getParameter("simsmsp");
    String simpin1 = request.getParameter("simpin1");
    String simpin2 = request.getParameter("simpin2");
    String simpuk1 = request.getParameter("simpuk1");
    String simpuk2 = request.getParameter("simpuk2");
    String simhomeprov = request.getParameter("simhomeprov");
    
    String sim_data="";
    String imsi_no=request.getParameter("simimsi");
    String work_no =(String)session.getAttribute("workNo");
    String passwd=(String)session.getAttribute("password");
System.out.println("gaopeng init");
    /*diling ����deleteShowCardNoFlag�ж� ΪisDelCardNoʱ��ȥ��д������card_no����ʾ��*/
    String deleteShowCardNoFlag = (String)request.getParameter("deleteShowCardNoFlag") == null? "":(String)request.getParameter("deleteShowCardNoFlag");
		/* ningtn д������regioncode�ж� */
		
    String selectRegionCode = regioncode == null ? "" : regioncode;
	String simKi = "";
	String simOpc = "";
	 		//�õ�д������
	 	String sqlStr="SELECT EKI_NO  FROM dbresadm.DBLKCARDRES WHERE CARD_NO ='"+simCardNumber+"'";
     		System.out.println(sqlStr+";sqlStr in fwritecard.jsp");
%>
       <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regioncode%>"  retcode="retCode" retmsg="retMessage" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%

      	if(retCode.equals("0")||retCode.equals("000000")){
      		if(result.length==0){
              		  	retCode="000001";
			        	retMessage="SIM�����벻���ڣ�"; %>
					 	<script>
							alert("SIM��������Ϣ����");
							window.close();
						</script>
			  <%
			}
			else
			{
              	retCode="000000";
			  	retMessage="SIM��������ҳɹ���";
			  	simKi=result[0][0].substring(0,32);
			  	simOpc=result[0][0].substring(32);
			  	%>
			 <wtc:service name="sg412Qry" outnum="30" routerKey="region" routerValue="<%=regioncode%>" retcode="simretCode" retmsg="simretMsg" >
				<wtc:param value="0"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=op_code%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=passwd%>"/>
				<wtc:param value="<%=phone%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=simKi%>"/>
				<wtc:param value="<%=simOpc%>"/>
				<wtc:param value="<%=simhomeprov%>"/>
			</wtc:service>
			<wtc:array id="simResults" scope="end" />
			  	<%
			  	String retsimCode=simretCode;
			  	String retsimMsg=simretMsg;
			  	
			  	System.out.println("liangyl--------"+simretCode);
			  	if("000000".equals(simretCode)){
			  		String[] retResutl=simResults[0][0].split(",");
			  		retsimCode = retResutl[1].split("=")[1];
			  		retsimMsg = retResutl[2].split("=")[1];
			  		System.out.println("liangyl------------------------"+retsimCode);
			  		System.out.println("liangyl------------------------"+retsimMsg);
			  		if("0".equals(retsimCode)){
			  			simKi=retResutl[3].split("=")[1];
					  	simOpc=retResutl[4].split("=")[1];
					  	System.out.println(simKi);
					  	System.out.println(simOpc);
			  		}
			  		else{
			  			%>
			  			<script type=text/javascript>
					  		alert("ki,opc����ʧ�ܣ�");
					  		alert("�������:<%=retsimCode%>,��������:<%=retsimMsg%>");
							window.close();
						</script>
					<%
			  		}
			  		//SeqNo=0,ResultCode=6305,ResultMessage=�����������ݿ�ָ���쳣null,EncPresetDataK=,EncPresetDataOPc=,Signature=
			  	}
			  	else{
			  		%>
			  		<script type=text/javascript>
				  		alert("ki,opc����ʧ�ܣ�");
				  		alert("�������:<%=retsimCode%>,��������:<%=retsimMsg%>");
						window.close();
					</script>
			  		<%
			  	}
			  	
			  	
			  	sim_data=sim_no+","+simimsi+","+simKi+","+simsmsp+","+simpin1+","+simpin2+","+simpuk1+","+simpuk2;
				System.out.println("liangyl---------------"+sim_data);
			}

         }else{
			retCode="000002";
			retMessage="SIM��������Ϣ����";

			%>
			<script>
			rdShowMessageDialog("SIM�����벻���ڣ�");
			window.close();
			</script>
			<%
		}
%>

<%

      //��ʾ���� All����ʾȫ��;Default:ֻ��ʾĬ�ϵ�
    String tital = request.getParameter("pageTitle");   //��ʾ���� All����ʾȫ��;Default:ֻ��ʾĬ�ϵ�
    String selType = "M";

%>

<HTML><HEAD><TITLE>�������ƶ�BOSS<%=pageTitle%></TITLE>
<BODY>
<SCRIPT type=text/javascript>
function writecard()
{
	//alert("ccccccccccc");
	var simdata="<%=sim_data%>";
	//alert(simdata);
	var simsim1=simdata.substring(0,12);
	//alert(simsim1);
	//alert(simdata.length);
	var simsim3=simdata.substring(13,simdata.length);
	//alert("cccccccc="+simsim3);
	//alert("dddd="+document.all.prov_code.value);
	if(document.all.card_no.value=="" || document.all.card_no.value=="FFFFFFFFFFFFFFFF")
	{
		document.all.simdata.value=simdata;
	}else
	{
		//alert("fffffffffff");
		document.all.simdata.value=simsim1+document.all.prov_code.value+simsim3;
		//alert("gggggggggg");
	}
	//alert(document.all.simdata.value);
 /* 
  * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
  */
 //   path = "http://10.110.0.100:33000/OPSWriteCard/writecard/NewWriteCard.jsp"
	path = "http://10.110.26.27:33000/OPSWriteCard/writecard/NewWriteCard.jsp";
	path = path + "?datatype=1&operid=<%=work_no%>&homecity=451";
    path = path + "&phonenum=<%=phone%>" + "&res_code=<%=sim_type%>" ;
    path = path + "&data="+document.all.simdata.value;
   // alert("path="+path);
   var retInfo = window.showModalDialog("Trans.html",path,"","dialogWidth:50;dialogHeight:40;");
  // 	 retInfo1 = RESULT=0&OP_ID=100&REQUEST_SOURCE=1&CARD_SERIAL=00000000000000000000&MSISDN=13720017196&ICCID=89860000000000000000&IMSI=400612345678900&PIN1=1234&PIN2=1234&PUK1=12345678&PUK2=12345678&KI=11111111111111111111111111111111
    //alert("retInfo="+retInfo);
	if(typeof(retInfo) == "undefined")
    {
    	rdShowMessageDialog("д������!");
    	return false;   }
    var chPos;
    chPos = retInfo.indexOf("&");
    if(chPos < 0)
    {
    	rdShowMessageDialog("д������!");
    	return false ;	}
    //alert( retInfo.substring(0,chPos));
    retInfo=retInfo+"&";
    var retVal=new Array();
    for(i=0;i<12;i++){
    	var chPos = retInfo.indexOf("&");
        valueStr = retInfo.substring(0,chPos);
        var chPos1 = valueStr.indexOf("=");
        valueStr1 = valueStr.substring(chPos1+1);
        retInfo = retInfo.substring(chPos+1);
        retVal[i]=valueStr1;
        //alert("retVal["+i+"]="+retVal[i]);
    }
    //return;
    if(retVal[0]!="0")
    {
		rdShowMessageDialog("д��ʧ�ܣ��������"+retVal[0]+"����д");
		document.all.writecardbz.value="1";
		return false;

	}else
	{
		var imsino=writecardocx.GetSIMIMSI();
		document.all.write_sim.value=retVal[5];
		//alert("document.all.write_sim.value="+document.all.write_sim.value);
		//alert("imsino="+imsino)
		if(imsino=="<%=imsi_no%>")
		{
			rdShowMessageDialog("д���ɹ�,��ʼ�޸Ŀ�״̬");
			document.all.writecardbz.value="2";
			savedata();
		}else
		{
			rdShowMessageDialog("д��ʧ�ܣ��˿��ѻ�����������");
			document.all.writecardbz.value="1";
			return false;
		}

	}
}
 function  doProcess(packet)
 {
 	var errCode=packet.data.findValueByName("retCode");
	var errMsg=packet.data.findValueByName("retMessage");
	var retType=packet.data.findValueByName("retType");
	if(retType=="getwritename")
	{
		if(parseInt(errCode)!=0)
		{
		rdShowMessageDialog(errCode+":"+errMsg);
		return false;
		}
		else
		{
			var cardstatus = packet.data.findValueByName("cardstatus");

			document.all.cardstatus.value= cardstatus;
			writecard();
		}
	}
 }

function getwritename(){

//	alert(document.all.card_no.value);
    var getAccountId_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/innet/fgetwritename_1104.jsp","���ڻ��д����������Ժ�......");
    	getAccountId_Packet.data.add("retType","getwritename");
		getAccountId_Packet.data.add("region_code","<%=regioncode%>");
		getAccountId_Packet.data.add("sim_type",(document.all.sim_type.value).trim());
		getAccountId_Packet.data.add("prov_code",(document.all.prov_code.value).trim());
		getAccountId_Packet.data.add("card_type",(document.all.card_type.value).trim());
		getAccountId_Packet.data.add("card_no",(document.all.card_no.value).trim());
		//alert(document.all.card_no.value);
		getAccountId_Packet.data.add("sim_data","<%=sim_data%>");
		core.ajax.sendPacket(getAccountId_Packet);

		getAccountId_Packet=null;


}
function turnToDepend1()
{//д��
	
	//0|89860088221708B56415|0|08178168080091363091|
	
	
	
	// var retInfo = "0|89860088221708B56415|0|08178168080091363091|be66d22dd34e6e9158ba361493eafaa3|2bad4224e0eb36c9b115ac9060b66aa2|";   // add by sungq
 //   window.returnValue= retInfo;
//    window.close();
 	try{
	//	var ocxver=writecardocx.GetVersion();
		var isgoodcard=writecardocx.IsCardExist();

		if(isgoodcard==0){
			var card_bz=writecardocx.GetSIMICCID();
			if(document.all.sim_type.value!="10006")
			{
				if(card_bz.substring(0,4)=="8986")
				{
					rdShowMessageDialog("�����տ�");
					document.all.writecardbz.value="1";
					return false;
				}
			}
			var card_no="<%=simCardNumber%>";//writecardocx.GetICCSerial();//ȡ�տ����к�
			//card_no='0806000150001189';//ģ��տ���
			//update by diling for ���ڹ��ֹ�˾�����Ż�Զ��д�������������ʾ
			if("<%=deleteShowCardNoFlag%>"!="isDelCardNo"){
			    rdShowMessageDialog("card_no="+card_no);
			}
			document.all.card_no.value=card_no;
			if(card_no==""||card_no=="FFFFFFFFFFFFFFFF")
			{
				document.all.cardstatus.value="3";
				writecard();
			}
			else
			{
				var prov_code=card_no.substring(8,9);
				var card_type=card_no.substring(6,8);
				if(card_type!=(document.all.sim_type.value).trim().substring(3,5))
				{
					rdShowMessageDialog(card_type+"  card_type");
					rdShowMessageDialog((document.all.sim_type.value).trim().substring(3,5)+"    document.all.sim_type.value).trim().substring(3,5");
					rdShowMessageDialog("��������ʵ�����Ͳ�����",0);
					return false;
				}
				document.all.prov_code.value=prov_code;
				document.all.card_type.value=card_type;
				getwritename();//���տ���Դ

			}
		}
		else{
			rdShowMessageDialog("����뿨!");
			document.all.writecardbz.value="1";
			return false;
		}
	}catch(e){
		rdShowMessageDialog(e.name+":"+e.message,0);
 		rdShowMessageDialog("���ڼ�������,���Ժ�",0);
 	}
}


function savedata(){
	document.all.writecardbz.value="0";
	turnToDepend();
}

function turnToDepend()
{
	var retCode_Now=(document.all.writecardbz.value).trim();
	//alert("sss="+document.all.simdata.value);

	var returnsim=document.all.write_sim.value;
	//alert("returnsim="+returnsim);

	var retCode = retCode_Now;
	//var retName = retName_Now + retName_After + retName_AddNo;
    if(retCode =="1")
    {
    	rdShowMessageDialog("д��ʧ�ܣ�",0);
    	return false;
    }
    if(retCode =="3")
    {
    	rdShowMessageDialog("д���ɹ�,�޸Ŀ�״̬ʧ�ܣ�",0);
    	return false;
    }
    var retInfo = retCode+"|"+returnsim+"|"+document.all.cardstatus.value+"|"+document.all.card_no.value +"|<%=simKi%>|<%=simOpc%>|";   // add by sungq
    window.returnValue= retInfo;
    window.close();

}
//-----------------------------------------------

</SCRIPT>

<!--**************************************************************************************-->
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</HEAD>

<BODY>
<FORM method=post name="getsimno">
    <%@ include file="/npage/include/header_pop.jsp" %>

		<div class="title">
			<div id="title_zi">SIM��д��</div>
		</div>

	 <table cellspacing="0">
          <tr>
            <td nowrap width="16%" >
              <div align="left">SIM������</div>
            </td>
            <td nowrap >
             <input type="text" name="sim_type" readonly value="<%=sim_type%>">
            </td>
            <td nowrap width="16%" >
              <div align="left">�������</div>
              </td>
              <td nowrap >
              <input type="text" name="phone_no" readonly value="<%=phone%>">
            </td>
          </tr>
          <tr>
          <td nowrap width="16%" >
          <div align="left">sim������</div>
              </td>
             <td nowrap >
             <input type="text" name="sim_no" readonly value="<%=sim_no%>">
             <input type="hidden" name="prov_code" >
             <input type="hidden" name="returnsim" >
             <input type="hidden" name="simdata" >
             <input type="hidden" name="card_no" >
             <input type="hidden" name="writecardbz" value="1" >
             <input type="hidden" name="card_type">
             <input type="hidden" name="cardstatus">
            <input type="hidden" name="write_sim" >
             </td>
           <td nowrap width="16%" >

           </td>

                    <td nowrap  >
                    </td>


             </tr>
	</table>

    <TABLE  cellSpacing="0">
    <TBODY>
        <TR >
            <TD align=center id="footer" >
                <input class="b_text" name=commit onClick="turnToDepend1()" style="cursor:hand" type=button value=д��>&nbsp;
                <input class="b_text" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>


  <!------------------------>
  <input type="hidden" name="modeCode" >
  <input type="hidden" name="modeName" >
  <!------------------------>
   <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>

<OBJECT
ID= "writecardocx"
CLASSID="clsid:930C8A98-EC73-4C37-9E20-9F4E0A5F93C4"
CODEBASE="/ocx/hljqqx.cab#version=1,0,0,1"
WIDTH = 0
HEIGHT = 0
ALIGN = center
HSPACE = 0
VSPACE = 0>
</OBJECT>
</BODY></HTML>
