<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-14
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>    
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%request.setCharacterEncoding("GBK");%>
<%
  String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
	
	System.out.println("-----------diling----------opCode="+opCode);
	System.out.println("-----------diling----------opName="+opName);
%>
<%
    //�õ��������
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[][] allNumStr =  new String[][]{};
    
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
    
%>

<%
/*
SQL���        sql_content
ѡ������       sel_type
����           title
�ֶ�1����      field_name1
*/
	System.out.println("AAAAAAAAAa");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
	  String iccid = request.getParameter("iccid");
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String user_no = request.getParameter("user_no");
	  String sm_code =request.getParameter("sm_code");
	  String op_code= request.getParameter("op_code");//luxc20070122 add
    String sqlFilter = "";

    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	System.out.println("luxc:op_code="+op_code);
    if (iccid != null)
    {
	    if (iccid.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
	    }
		}    
    if (cust_id != null)
    {
	    if (cust_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.cust_id=" + cust_id + " and b.cust_id=" + cust_id + " and c.cust_id=" + cust_id;
	    }
    }
    if (unit_id != null)
    {
	    if (unit_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and b.unit_id=" + unit_id;
	    }
    }
    if (user_no != null)
    {
	    if (user_no.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and e.service_type=c.sm_code and e.service_no='" + user_no + "'";
	    }
    }
    if (sm_code != null)
    {
			if (sm_code.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and c.sm_code ='" + sm_code+"'";
	    }
	}
	
	if(iccid == null){
	    iccid = "";
	}
	if(cust_id == null){
	    cust_id = "";
	}
	if(unit_id == null){
	    unit_id = "";
	}
	if(user_no == null){
	    user_no = "";
	}
	/*luxc 20070122 add ������sql�� c.run_code='A' �������ȥ�� ��Ϊ��̬��� */
	System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   "+op_code);
	if("3523".equals(op_code))
		sqlFilter = sqlFilter + " and c.run_code ='I' and c.op_time<=to_date(to_char(last_day(add_months(sysdate,-1)),'yyyymmdd')||' 23:59:59','yyyymmdd hh24:mi:ss') ";
	else
		sqlFilter = sqlFilter + " and c.run_code ='A' ";
		
    String sqlStr = "SELECT nvl(count(*),0) num FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e,ssmproduct f,ssmcode g WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id  and  b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and c.user_no = e.msisdn and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code and c.REGION_CODE='"+regionCode+"'  " + sqlFilter;//and c.sm_code not in('va','vp')
    
    
    String sqlStr1 = "select * from (SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no, c.user_no, TRIM (c.user_name), c.product_code, d.product_name, b.unit_id, c.account_id, g.sm_name,Trim(e.service_no),h.apn_no,rownum id FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e,ssmproduct f,ssmcode g,dGrpApnMsg h WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id and b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and c.user_no = e.msisdn and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code AND c.id_no=h.id_no(+) and c.REGION_CODE='"+regionCode+"'  " + sqlFilter + " ) where id <"+iEndPos+" and id>="+iStartPos;//and c.sm_code not in('va','vp')
	//String sqlStr1 = "select * from (select z.*,rownum id from (SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no, Trim(e.service_no), TRIM (c.user_name), c.product_code, d.product_name, b.unit_id, c.account_id, g.sm_name,c.user_no,h.apn_no,sum(decode(j.refund_flag,'Y',nvl(i.prepay_fee,0),0)),sum(case when j.refund_flag<>'Y' or j.refund_flag is null then nvl(i.prepay_fee,0) else 0 end) FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e,ssmproduct f,ssmcode g,dGrpApnMsg h,dConMsgPre i,sPayType j WHERE c.product_code=d.product_code AND a.cust_id=b.cust_id and b.cust_id= c.cust_id AND d.product_level=1 AND d.product_status='Y' AND c.bill_date>Last_Day(sysdate)+1 and c.user_no= e.msisdn and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code AND c.id_no=h.id_no(+) and i.pay_type=j.pay_type(+) and c.account_id=i.contract_no(+) and c.REGION_CODE='"+regionCode+"'" + sqlFilter + " group by a.id_iccid,a.cust_id,b.unit_name,c.id_no,e.service_no,c.user_name,c.product_code,d.product_name,b.unit_id,c.account_id,g.sm_name,c.user_no,h.apn_no) z)where id <"+iEndPos+" and id>="+iStartPos;
	
	
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!sqlStr1="+sqlStr1);
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
<TITLE>������BOSS-���ſͻ���ѯ</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
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
      {     return false;   }
       //���ص�����¼
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          {
                  if (document.fPubSimpSel.elements[i].name=="List")
                  {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                       if (document.fPubSimpSel.elements[i].checked==true)
                       {     //�ж��Ƿ�ѡ��
                             //alert(document.fPubSimpSel.elements[i].value);
                             rIndex = document.fPubSimpSel.elements[i].RIndex;
                             tempQuence = retQuence;
                             for(n=0;n<retNum;n++)
                             {
                                chPos = tempQuence.indexOf("|");
                                fieldNo = tempQuence.substring(0,chPos);
                                //alert(fieldNo);
                                obj = "Rinput" + rIndex +"-"+ fieldNo;
                                //alert(obj);
                                //alert(document.all(obj).value);
                                //alert(retValue);
                                retValue = retValue + document.all(obj).value + "|";
                                //alert(retValue);
                                tempQuence = tempQuence.substring(chPos + 1);
                             }
                             //alert(retValue);
                             window.returnValue= retValue;
                             //alert(retValue);
                             
                       }
                }
            }
        
        if(retValue =="")
        {
            rdShowMessageDialog("��ѡ����Ϣ�",0);
            return false;
        }
        retValue=retValue+"0.00|0.00|"
        //alert(retValue);
        opener.getvaluecust(retValue);
        window.close();
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
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">���Ų�Ʒ��ѯ</div>
	</div>
<table cellspacing="0" >
<tr>
<TR>
	<TH nowrap>֤������</TH>
	<TH nowrap>���ſͻ�ID</TH>
	<TH nowrap>���ſͻ�����</TH>
	<TH nowrap>���Ų�ƷID</TH>
	<TH nowrap>�����û����</TH>
	<TH nowrap>�û�����</TH>
	<TH nowrap>��Ʒ����</TH>
	<TH nowrap>��Ʒ����</TH>
	<TH nowrap>���ű��</TH>
	<TH nowrap>��Ʒ�����ʻ�</TH>
	<TH nowrap>Ʒ������</TH>
	<TH nowrap style='display:none'>Ʒ�ƴ���</TH>   
	<TH nowrap>�������</TH></TR>
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
     fieldNum = String.valueOf(tempNum+1);
%>

<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
   
    try
    {
    
    
%>
    <wtc:service name="s3096QryCheckE" routerKey="region" routerValue="<%=regionCode%>" retcode="code2" retmsg="msg2" outnum="15" >
        <wtc:param value="<%=workno%>"/>
        <wtc:param value="<%=unit_id%>"/> 
        <wtc:param value="u04"/> 
        <wtc:param value=""/> 
        <wtc:param value="<%=iccid%>"/> 
        <wtc:param value="<%=cust_id%>"/> 
        <wtc:param value="<%=user_no%>"/> 
    </wtc:service>
    <wtc:array id="result_t" scope="end"/>

<%
            //retArray = callView.sPubSelect(fieldNum,sqlStr1);
            //retArray1 = callView.sPubSelect("1",sqlStr);
            result = result_t;
            //System.out.println("$$$$$$$$$$$$$$$$$$---"+result_t[0][14]);
            //allNumStr = allNumStr_t;
            //int recordNum = Integer.parseInt(allNumStr[0][0].trim());
            int recordNum = result.length;
            
            System.out.println("--------------OK-------------------"+recordNum);
            //System.out.println("luxcluxc="+fieldNum+"="+result[0][0]); 
            for(int i=0;i<recordNum;i++)
            {
                typeStr = "";
                inputStr = "";
                out.print("<TR>");
                for(int j=0;j<13;j++)
                {
                    if(j==0)
                    {
                        
      					
                        typeStr = "<TD>";
                        if(selType.compareTo("") != 0)
                        {
                            typeStr = typeStr + "<input type='" + selType +
                                "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }

      					typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                        " id='Rinput" + i +"-"+ j + "' value='" +
                        (result[i][j]).trim() + "' readonly></TD>";
      					
                    }
                    else if(j==11)
                    {
      					inputStr = inputStr + "<TD style='display:none'>" + (result[i][j]).trim() + "<input type='hidden' " +
                        " id='Rinput" + i +"-"+ j + "'  value='" +
                        (result[i][j]).trim() + "' readonly></TD>";
      					
                    }
                    else
                    {
      					inputStr = inputStr + "<TD>" + (result[i][j]).trim() + "<input type='hidden' " +
                        " id='Rinput" + i +"-"+ j + "'  value='" +
                        (result[i][j]).trim() + "' readonly></TD>";
      					
                    }
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
        }catch(Exception e){

        }
%>
<%


%>
   </tr>
  

<!------------------------------------------------------>
   
        <TR id="footer">
            <TD align=center colspan=15 >
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");
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
    
  </div>
  <!------------------------>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>
