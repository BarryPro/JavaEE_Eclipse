<%
/********************
version v2.0
¿ª·¢ÉÌ: si-tech
update zhaohaitao at 2008.12.24
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*;"%>
<%

String region_code=(String)session.getAttribute("regCode");
String conID = request.getParameter("pContractNo");
String vEnConPaswd = request.getParameter("vConPaswd");
vEnConPaswd = Encrypt.encrypt(vEnConPaswd);
String vConPaswdFlag = "0";
 
String sqlStr = "select max(c.bill_order),d.type_name,e.pay_name ,a.pay_code from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no and a.contract_no="+conID+" and c.serial_no=0 and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code group by c.contract_no,d.type_name,e.pay_name,a.pay_code";

//CallRemoteResultValue value=  viewBean.callService("0",null,"sPubSelect","4", inParas); 
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode" retmsg="retMsg" outnum="4">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
<%
String billOrder = "";
String wm_counttype = "";
String wm_paytype = "";
String wm_paycode = "";
if(result.length>0){
	billOrder = result[0][0];
	wm_counttype = result[0][1];
	wm_paytype = result[0][2];
	wm_paycode = result[0][3];
}   
    
String bank_name="";
String post_name="";
String pay_name="";

if(wm_paycode.equals("4")){
	String sqlStr1 = "select d.bank_name,e.bank_name,f.pay_name  from dConMsg a,dCustMsg b, sbankcode d,spostcode e ,spaycode f ,dconusermsg g where  a.contract_no="+conID+" and g.contract_no=a.contract_no and b.id_no=g.id_no and d.region_code=substr(b.belong_code,1,2) and e.region_code=d.region_code and d.bank_code=a.bank_code and f.region_code=d.region_code and e.post_bank_code=a.post_bank_code and f.pay_code=a.pay_code ";
	
	//CallRemoteResultValue value1=  viewBean1.callService("0",null,"sPubSelect","3", inParas1); 
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode2" retmsg="retMsg2" outnum="3">
    <wtc:sql><%=sqlStr1%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%
	if(result1.length>0){
		bank_name=result1[0][0];
		post_name=result1[0][1];
		pay_name=result1[0][2];
	}
}else{

}


System.out.println("99999999999999999999");

StringBuffer sqlBuffer= new StringBuffer();
sqlBuffer.append("select  CONTRACT_PASSWD, BANK_CUST,ODDMENT, PREPAY_FEE, ");
sqlBuffer.append("DEPOSIT, MIN_YM, OWE_FEE, ACCOUNT_MARK,");
sqlBuffer.append("ACCOUNT_LIMIT, PAY_CODE, BANK_CODE, POST_BANK_CODE,");
sqlBuffer.append("ACCOUNT_NO,ACCOUNT_TYPE,STATUS ");
sqlBuffer.append(" FROM dConMsg WHERE contract_no =");
sqlBuffer.append(conID);
StringBuffer sqlBuffer2= new StringBuffer();
sqlBuffer2.append("SELECT POST_FLAG,POST_TYPE,POST_ADDRESS,POST_ZIP,FAX_NO,MAIL_ADDRESS  FROM dCustPost where contract_no=");
sqlBuffer2.append(conID);

StringBuffer sqlBuffer3= new StringBuffer();
sqlBuffer3.append("select m.card_name,n.grp_name from dCustMsg a, dConMsg  b , sbigCardCode m,sgrpbigflag n where b.con_cust_id = a.cust_id ");
sqlBuffer3.append("and b.contract_no =");
sqlBuffer3.append(conID);
sqlBuffer3.append("  and  substr(a.attr_code,2,2) = m.card_type and  substr(a.attr_code,5,1) = n.grp_flag");

//ArrayList tmpSelList = implSel.sPubSelect("15",sqlBuffer.toString());
%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode3" retmsg="retMsg3" outnum="15">
		<wtc:param value="<%=sqlBuffer.toString()%>"/>
	</wtc:service>
	<wtc:array id="tmpSelList" scope="end"/>
<%
System.out.println(sqlBuffer.toString());
String [][] tri_metaData = new String[][]{};
String [][] tri_metaData2 = new String[][]{};
String [][] tri_metaData3 = new String[][]{};

if(retCode3.equals("000000")&&tmpSelList.length>0)
{
	
	tri_metaData = null;
	tri_metaData = tmpSelList;
	if(tri_metaData.length != 0)
	{	
		if(tri_metaData[0].length != 0)
		{
			if(0==Encrypt.checkpwd2(tri_metaData[0][0],vEnConPaswd))
			{
				vConPaswdFlag = "1";
			}
		}
	}
}
String tri_metaDataStr =WtcUtil.createArray("js_tri_metaDataStr",tri_metaData.length);

//ArrayList tmpSelList2 = implSel.sPubSelect("6",sqlBuffer2.toString());
%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode4" retmsg="retMsg4" outnum="6">
		<wtc:param value="<%=sqlBuffer2.toString()%>"/>
	</wtc:service>
	<wtc:array id="tmpSelList2" scope="end"/>
<%
if(retCode4.equals("000000") && tmpSelList2.length>0)
{
	tri_metaData2 = tmpSelList2;
}
String tri_metaDataStr2 = WtcUtil.createArray("js_tri_metaDataStr2",tri_metaData2.length);

//ArrayList tmpSelList3 = implSel.sPubSelect("2",sqlBuffer3.toString());
%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode5" retmsg="retMsg5" outnum="2">
		<wtc:param value="<%=sqlBuffer3.toString()%>"/>
	</wtc:service>
	<wtc:array id="tmpSelList3" scope="end"/>
<%

String sGrpName = "";
String sCardName = "";
if(tmpSelList3 != null)
{
	tri_metaData3 = tmpSelList3;
	if(tri_metaData3.length != 0)
	{
		 if(tri_metaData3[0].length == 2)
		{
			sCardName = tri_metaData3[0][0];
			sGrpName = tri_metaData3[0][1];
			System.out.println(" sGrpName = " + sGrpName);
			System.out.println(" sCardName = " + sCardName);
		}
	}
	
}
%>

<%=tri_metaDataStr%>
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {       
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {  System.out.println("tri_metaData = " + tri_metaData[p][q]);
%>
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
%>

<%=tri_metaDataStr2%>
<%   
  for(int m=0;m<tri_metaData2.length;m++)
  {       
	  for(int n=0;n<tri_metaData2[m].length;n++)
	  {  System.out.println("tri_metaData2 = " + tri_metaData[m][n]);
%>
        
        js_tri_metaDataStr2[<%=m%>][<%=n%>]="<%=tri_metaData2[m][n]%>";
<%
	  }
  }
%>

var response = new AJAXPacket();
var billOrder = "<%=billOrder%>";
var wm_counttype = "<%=wm_counttype%>";
var wm_paytype = "<%=wm_paytype%>";
var bank_name = "<%=bank_name%>";
var post_name = "<%=post_name%>";
var pay_name = "<%=pay_name%>";
var sGrpName = "<%=sGrpName%>";
var sCardName = "<%=sCardName%>";
var vConPaswdFlag = "<%=vConPaswdFlag%>";
response.data.add("rpc_page","f1211ConMsg");
response.data.add("ConMsg",js_tri_metaDataStr);
response.data.add("ConPostMsg",js_tri_metaDataStr2);
response.data.add("grpName",sGrpName);
response.data.add("billOrder",billOrder);
response.data.add("wm_counttype",wm_counttype);
response.data.add("wm_paytype",wm_paytype);
response.data.add("bank_name",bank_name);
response.data.add("post_name",post_name);
response.data.add("pay_name",pay_name);
response.data.add("cardName",sCardName);
response.data.add("vConPaswdFlag",vConPaswdFlag);
core.ajax.receivePacket(response);
