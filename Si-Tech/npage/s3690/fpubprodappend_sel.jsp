<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-14
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>

<%
    String opName = "���Ÿ��Ӳ�Ʒ��ѯ";
	//�õ��������
    Logger logger = Logger.getLogger("fpubprodappend_sel.jsp");
    ArrayList retArray = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[] paramsIn = null;
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();

    /*�õ�����Ա�Ĺ��ź�����*/
    String workno = (String)session.getAttribute("workNo");
    String nopass  = (String)session.getAttribute("password");
    String powerRight = ((String)session.getAttribute("powerRight")).trim();
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
	String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String product_code = request.getParameter("product_code");
    String biz_code = request.getParameter("biz_code").trim();
    String showType = request.getParameter("showType");   //��ʾ���� 
    String sqlStr = "";
    String org_id = "";
    String group_id = "";
    String class_code = "";
    String owner_code = "JT";
    String credit_code = "E";
    String business_code = "0"; //����
    String [] paraIn = new String[2];
    
    
    try
    {
        //ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
		//String[][] result2  = null;
		sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
		//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
		String province_run = "";
		%>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result2" scope="end" />
    	<%
		if (result2.length>0 && retCode1.equals("000000")) 
		{
			province_run = result2[0][0];
		}
		
		if(province_run.equals("20"))   //����
        {
        	sqlStr = "select '9999999', a.group_id, nvl(b.innet_type,'99') "
        	        +"  from dLoginMsg a, sTownCode b "
        	        +" where a.login_no =:workno "
        	        +"   and substr(a.org_code,1,2) = b.region_code"
        	        +"   and substr(a.org_code,3,2) = b.district_code"
        	        +"   and substr(a.org_code,5,3) = b.town_code";
        }
        else
        {
        	//sqlStr = "select a.org_id, a.group_id, b.innet_type from dLoginMsg a, sTownCode b where a.login_no = '" + workno + "' and a.group_id = b.group_id";
			sqlStr = "select a.org_id, a.group_id, nvl(b.innet_type,'99') from dLoginMsg a, sTownCode b where a.login_no =:workno and a.group_id = b.group_id(+)";//luxc20060906�޸�
        }
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
        if(retArr2.length>0 && retCode2.equals("000000")){
            result = retArr2;
        }
        //result = (String[][])retArray.get(0);
        org_id = result[0][0];
        group_id = result[0][1];
        class_code = result[0][2];
    }
    catch(Exception e){
        logger.error("��ѯsSmSelPAttr����!");
    }
%>

<%
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = "��Ʒ����|��Ʒ����|";

    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

	if(showType.compareTo("Default") == 0) //ֻ��ʾĬ�ϲ�Ʒʱ���б���
	{	fieldName = "��Ʒ����|��Ʒ����|";		}

    String selType = "M";
    selType = WtcUtil.repNull((String)request.getParameter("selType"));
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�������ƶ�BOSS<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type=text/javascript>
//-------------------------------------------------------------------
function turnToDepend()
{
	var retCode = "";

	//��Ʒ����|��Ʒ����|
	for(var i=0;i<pubProduct.elements.length;i++)
	{
		if (pubProduct.elements[i].name=="List")
		{   //�ж��Ƿ��ǵ�ѡ��ѡ��
			if (pubProduct.elements[i].checked==true)
			{
			    //�ж��Ƿ�ѡ��
 				rIndex = pubProduct.elements[i].RIndex;
 				objCode = "Rinput" + rIndex + 1;
				if(document.all(objCode).value != "")
				{
					if (retCode == "") {
						retCode = document.all(objCode).value;
                    }
					else {
						retCode = retCode + "," + document.all(objCode).value;
                    }
				}
			}
		}
	}

    window.returnValue = retCode;
    if(retCode == "")
    {
    	rdShowMessageDialog("��ѡ���Ʒ��Ϣ��",0);
    	return false;
    }
	opener.getvalueProdAppend(retCode);
    window.close();
}
//-------------------------------------------------
function allChoose()
{   //��ѡ��ȫ��ѡ��
    for(i=0;i<pubProduct.elements.length;i++)
    {
        if(pubProduct.elements[i].type=="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            if(pubProduct.elements[i].disabled == false)
            {   pubProduct.elements[i].checked = true;	}
        }
    }
}
function cancelChoose()
{   //ȡ����ѡ��ȫ��ѡ��
    for(i=0;i<pubProduct.elements.length;i++)
    {
        if(pubProduct.elements[i].type =="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            if(pubProduct.elements[i].disabled == false)
            {   pubProduct.elements[i].checked = false;		}
        }
    }
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="pubProduct">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

   

  <table cellspacing="0">
    <tr>
<%  //���ƽ����ͷ
     chPos = fieldName.indexOf("|");
     out.print("<TR align=center>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TH>" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);

%>

<%
    //���ݴ����Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{
			fieldNum = "3";
      		String choiceFlag = "0";

            paramsIn = new String[15];
            paramsIn[0] = workno;
            paramsIn[1] = nopass;
            paramsIn[2] = sm_code;
            paramsIn[3] = op_code;
            paramsIn[4] = org_id;
            paramsIn[5] = group_id;
            paramsIn[6] = owner_code;
            paramsIn[7] = class_code;
            paramsIn[8] = credit_code;
            paramsIn[9] = powerRight;
            paramsIn[10] = "40";
            paramsIn[11] = "";
            paramsIn[12] = "u01";
            paramsIn[13] = product_code;
            paramsIn[14] = "0";
        
            int iOutNum = 0;
            if("ML".equals(sm_code) || "AD".equals(sm_code)){
                iOutNum = 17;
            }else{
                iOutNum = 15;
            }
            String sOutNum = String.valueOf(iOutNum);
            System.out.println("# biz_code = "+biz_code);
        %>
            <wtc:service name="sPubMProdSelE" routerKey="region" routerValue="<%=regionCode%>" retcode="sPubSubProdSelCode" retmsg="sPubSubProdSelMsg" outnum="<%=sOutNum%>" >
            	<wtc:param value="<%=paramsIn[0]%>"/>
                <wtc:param value="<%=paramsIn[1]%>"/> 
                <wtc:param value="<%=paramsIn[2]%>"/>
                <wtc:param value="<%=paramsIn[3]%>"/>
                <wtc:param value="<%=paramsIn[4]%>"/>
                
                <wtc:param value="<%=paramsIn[5]%>"/>
                <wtc:param value="<%=paramsIn[6]%>"/>
                <wtc:param value="<%=paramsIn[7]%>"/>
                <wtc:param value="<%=paramsIn[8]%>"/>
                <wtc:param value="<%=paramsIn[9]%>"/>
                
                <wtc:param value="<%=paramsIn[10]%>"/>
                <wtc:param value="<%=paramsIn[11]%>"/>
                <wtc:param value="<%=paramsIn[12]%>"/>
                <wtc:param value="<%=paramsIn[13]%>"/>
                    
                <wtc:param value="<%=paramsIn[14]%>"/>
                <wtc:param value=""/>
                <wtc:param value=""/>
                <wtc:param value="<%=biz_code%>"/>
            </wtc:service>
            <wtc:array id="sPubSubProdSelArr" scope="end"/>
        <%

	      		//result = (String[][])retArray.get(4);
                int recordNum = sPubSubProdSelArr.length;

	      		outer: for(int i=0;(i<recordNum) && (i<iEndPos);i++)
	      		{
                    if (i < iStartPos) continue;
	      		    typeStr = "";
	      		    inputStr = "";
	      		    choiceFlag = "0";
          		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
	      		    {
	                    if(j==0)
	                    {
                            //choiceFlagΪ�󶨱�־,0-����ѡ��,1-����ѡһ,2-��
	                    	choiceFlag = sPubSubProdSelArr[i][6];
	                    	if(choiceFlag.compareTo("0") != 0 && choiceFlag.compareTo("1") != 0 && choiceFlag.compareTo("2") != 0 )
	                    	{	continue outer;	}
	                    	out.print("<TR>");
	                    }
	                    else if(j==1)
	                    {
	                        //��ѡ��
	                        typeStr ="<TD>&nbsp;<input type='" + selType +
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +
	                            " onkeydown='if(event.keyCode==13)turnToDepend();'";
	                        //�ж��Ƿ��ǰ󶨲�Ʒ
	                        if(choiceFlag.compareTo("2") == 0)
	                        {  	typeStr = typeStr + "checked disabled"; }
	                        typeStr = typeStr + ">";
	                        //������Ϣ
	                        typeStr = typeStr + (sPubSubProdSelArr[i][3]).trim() + "<input type='hidden' " +
	          		            " id='Rinput" + i + j + "' class='button' value='" +
	          		            (sPubSubProdSelArr[i][3]).trim() + "'readonly></TD>";
	                    }
                        else
                        {
	          		        inputStr = inputStr + "<TD>&nbsp;" + (sPubSubProdSelArr[i][4]).trim() +
	          		            "<input type='hidden' " +
	          		            " id='Rinput" + i + j + "' class='button' value='" +
	          		            (sPubSubProdSelArr[i][4]).trim() + "'readonly></TD>";
	                    }
          		    }
	                inputStr = inputStr + "</TD>";
	      		    out.print(typeStr + inputStr);
	      		    out.print("</TR>");
            }
     	}catch(Exception e){
			e.printStackTrace();
     	}
%>
<%


%>
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellSpacing=0>
    <TBODY>
        <TR id="footer">
            <TD>
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>");
    }
%>
                <input class="b_foot" name=commit onClick="turnToDepend()" style="cursor:hand" type=button value=ȷ��>
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>
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
</BODY>
</HTML>
